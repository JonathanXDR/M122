#!/bin/bash
cwd=`pwd`		# save the current working directory in $cwd
cd `dirname $0`	# change to the directory where the script is located
BINDIR=`pwd`	# save in $BINDIR the directory where the script is 
cd $cwd		# return to the working directory
BASENAME=`basename $0`	# Set the script name (without path to it)
TMPDIR=/tmp/$BASENAME.$$	# Set a temporary directory if needed
ETCDIR=$BINDIR/../etc		# $ETCDIR is the config directory

# Read input file, which contains the git urls and the directories to clone to in the format:
# <git url> <directory to clone to>

input_file=$1
base_dir=$2

# if parameters are not set, exit
if [ -z "$input_file" ] || [ -z "$base_dir" ]; then
  echo "Error: parameters are not set"
  echo "Usage: $BASENAME <input file> <target directory>"
  exit 1
fi

# Base directory exists? If not, create it.
if [ ! -d $base_dir ]; then
  mkdir -p $base_dir
fi

# check if the input file exists
if [ ! -f "$input_file" ] ; then
  echo "Error: $input_file does not exist"
  exit 3
fi

# check if input file is empty
if [ ! -s "$input_file" ] ; then
  echo "Error: $input_file is empty"
  exit 4
fi

# git repo from input file exists in the base directory? If not, clone it. If yes, update it.
while read line || [ -n "$line" ] ; 
do
  # split the line into the git url and the directory to clone to
  git_url=`echo $line | cut -d' ' -f1`
  target_dir=`echo $line | cut -d' ' -f2`
  # check if the local directory exists
  if [ ! -d $base_dir/$target_dir ]; then
    echo "Cloning $git_url to $base_dir/$target_dir"
    git clone $git_url $base_dir/$target_dir
  else
    echo "Updating $git_url in $base_dir/$target_dir"
    cd $base_dir/$target_dir
    git pull
    cd $cwd
  fi
done < $input_file

# Remove all files or directories from the base directory, where the names are not contained in the input file
for file in $base_dir/*; do
  if [ ! -d $file ]; then
    continue
  fi
  # get the name of the directory
  dir_name=`basename $file`
  # check if the directory name is contained in the input file
  if grep -q $dir_name $input_file; then
    continue
  fi

  # ask user if the directory should be removed and reuse the answer for all other directories
  if [ -z "$answer" ]; then
    echo "Removing all directories not contained in $input_file"
    echo "Do you want to continue? (y/n)"
    read answer
  fi
  if [ "$answer" == "y" ]; then
    rm -rf $file
    echo "Removing $dir_name"
  fi
done