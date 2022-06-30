#!/bin/bash
# save the current working directory in $cwd
cwd=`pwd`
# change to the directory where the script is located
cd `dirname $0`
# save in $BINDIR the directory where the script is 
BINDIR=`pwd`
# return to the working directory	
cd $cwd
# Set the script name (without path to it)
BASENAME=`basename $0`
# Set a temporary directory if needed
TMPDIR=/tmp/$BASENAME.$$
# $ETCDIR is the config directory
ETCDIR=$BINDIR/../etc

# Read input file, which contains the git urls and the directories to clone to in the format:
# <git url> <directory to clone to>

# Params: $1 - input file with the git urls and the directories to clone to
#         $2 - local base directory to clone to

# variables for the parameters
input_file=$1
local_base_dir=$2

# Base directory exists? If not, create it.
if [ ! -d $local_base_dir ]; then
  mkdir -p $local_base_dir
fi

# check if the input file exists and is readable
if [ ! -r $input_file ]; then
  echo "Error: input file $input_file does not exist or is not readable"
  exit 1
fi

# git repo from input file exists in the local base directory? If not, clone it. If yes, update it.
while read line; do
  # split the line into the git url and the directory to clone to
  git_url=`echo $line | cut -d' ' -f1`
  local_dir=`echo $line | cut -d' ' -f2`
  # check if the local directory exists
  if [ ! -d $local_base_dir/$local_dir ]; then
    echo "Cloning $git_url to $local_base_dir/$local_dir"
    git clone $git_url $local_base_dir/$local_dir
  else
    echo "Updating $git_url in $local_base_dir/$local_dir"
    cd $local_base_dir/$local_dir
    git pull
    cd $cwd
  fi
done < $input_file

# if directory in base directory exists, which is not in the input file, delete it.
for dir in `ls -d $local_base_dir/*/`; do
  dir=`echo $dir | sed 's/\/$//'`
  if [ ! -r $input_file ]; then
    echo "Deleting $dir"
    rm -rf $dir
  fi
done

# Next line in csv file exists? If yes, repeat the process. If no, exit.
if [ -r $input_file ]; then
  $0 $input_file $local_base_dir
fi