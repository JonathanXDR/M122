#!/bin/bash
cwd=$(pwd)               # save the current working directory in $cwd
cd $(dirname $0)         # change to the directory where the script is located
BINDIR=$(pwd)            # save in $BINDIR the directory where the script is
cd $cwd                  # return to the working directory
BASENAME=$(basename $0)  # Set the script name (without path to it)
TMPDIR=/tmp/$BASENAME.$$ # Set a temporary directory if needed
ETCDIR=$BINDIR/../etc    # $ETCDIR is the config directory

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# read input file, which contains the git urls and the directories to clone to in the format:
# <git url> <directory to clone to>

input_file=$1
base_dir=$2

# if parameters are not set, exit
if [ -z "$input_file" ] || [ -z "$base_dir" ]; then
  printf "${RED}Error: parameters are not set${NC}\n"
  printf "${YELLOW}Usage: $BASENAME <input file> <target directory>${NC}\n"
  exit 1
fi

# base directory exists? If not, ask for creation
if [ ! -d "$base_dir" ]; then
  printf "${RED}Error: base directory $base_dir does not exist${NC}\n"
  echo "Do you want to create it? (y/n)"
  read create_dir
  if [ "$create_dir" == "y" ] || [ "$create_dir" == "Y" ] || [ "$create_dir" == "yes" ] || [ "$create_dir" == "Yes" ]; then
    mkdir -p $base_dir
    printf "${GREEN}Directory successfully created${NC}\n"
  else
    exit 1
  fi
fi

# check if the input file exists
if [ ! -f "$input_file" ]; then
  printf "${RED}Error: $input_file does not exist${NC}\n"
  exit 3
fi

# check if input file is empty
if [ ! -s "$input_file" ]; then
  printf "${RED}Error: $input_file is empty${NC}\n"
  exit 4
fi

# git repo from input file exists in the base directory? If not, clone it. If yes, update it.
while read line || [ -n "$line" ]; do
  echo ""
  # split the line into the git url and the directory to clone to
  git_url=$(echo $line | cut -d' ' -f1)
  target_dir=$(echo $line | cut -d' ' -f2)
  # check if the local directory exists
  if [ ! -d $base_dir/$target_dir ]; then
    git clone $git_url $base_dir/$target_dir
  else
    echo "Updating $base_dir/$target_dir..."
    cd $base_dir/$target_dir
    git pull
    cd $cwd
  fi
done <$input_file

# remove all files or directories from the base directory, where the names are not contained in the input file
for file in $base_dir/*; do
  if [ ! -d $file ]; then
    continue
  fi
  # get the name of the directory
  dir_name=$(basename $file)
  # check if the directory name is contained in the input file
  if grep -q $dir_name $input_file; then
    continue
  fi

  # ask user if the directory should be removed and reuse the answer for all other directories
  if [ -z "$answer" ]; then
    echo ""
    echo "Removing all directories not contained in $input_file..."
    echo "Do you want to continue? (y/n)"
    read answer
  fi
  if [ "$answer" == "y" ] || [ "$answer" == "Y" ] || [ "$answer" == "yes" ] || [ "$answer" == "Yes" ]; then
    rm -rf $file
    echo "Removing $dir_name..."
  fi
  printf "${GREEN}Successfully removed directory${NC}\n"
done
