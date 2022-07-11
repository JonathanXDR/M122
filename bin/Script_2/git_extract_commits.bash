#!/bin/bash

bold=$(tput bold)

echo -e "${bold}\n"
echo "------------------------------"
echo "####### Script started #######"
echo "------------------------------"
echo -e "\n"

#Vorbereitungen
##sudo install git

# Save Current Work Directory
cwd=$(pwd)


# Save directory-path with repositories
twd="$1"

# Check if twd is empty
if [ "$twd" = "" ]; then
  echo "Path to repositories is missing: $twd"
  exit 1
fi

# Check if twd exists
if [ ! -d "$twd" ]; then
  echo "Path does not exist: $twd"
  exit 1
fi


# Save output-file-path
outputFile="$2"

# Check if outputFile is empty
if [ "$outputFile" = "" ]; then
  echo "Path to output file is missing: $twd"
  exit 1
fi

# Check if outputFile exists
if [ ! -d "$outputFile" ]; then
  echo "Path does not exist: $outputFile"
  exit 1
fi

Green='\033[1;32m'
PURPLE='\033[0;35m'


# Add headline to output-file
echo "Zielverzeichnis,Datum,Commit-Hash,Author" >"${cwd}/${outputFile}/OutputFile$$.csv"

printf "${Green}Repo Directorys: \n"

# Go trough each element in directory
for f in $twd/*; do

  if [ -d "$f" ]; then

    cd "$f"

    if [ -d .git ]; then
      #Directory is repo

      repoName=${f#$twd/}
      echo "$repoName"

      if ! git log --pretty=format:"$repoName,%cd,%H,%an" --date=format:'%Y%m%d' >>"${cwd}/${outputFile}/OutputFile$$.csv"; then
        echo "Error while getting the log of $f"
      fi

    else
      # Add directory to non-repo file
      echo "${f#$twd/}" >>"/tmp/nonrepolist.$$"
    fi

    # Move back to source directory
    cd "$cwd"
  fi

done

echo -e "\n"

# Output all non repo Directories
if [ -f /tmp/nonrepolist.$$ ]; then
  printf "${PURPLE}Non Repo Directorys:"
  cat /tmp/nonrepolist.$$
fi
echo -e "\n \n"

for f in $subdirectories; do
  echo "File -> $f"
done
