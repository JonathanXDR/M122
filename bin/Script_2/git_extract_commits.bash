#!/bin/bash

echo -e "\n"
echo "------------------------------"
echo "####### Script started #######"
echo "------------------------------"
echo -e "\n"

#Vorbereitungen
##sudo install git
cwd=$(pwd)

#Read RepoDirectory
twd="$1"

# Read output File
outputFile="$2"


  echo "Zielverzeichnis,Datum,Commit-Hash,Author"> "${cwd}/${outputFile}/OutputFile$$.csv"

# Do with every Directory and File in the specified directory
for f in $twd/*; do

  if [ -d "$f" ]; then

    cd "$f"

    if [ -d .git ]; then
      #Directory is repo
      echo "repository found."

      repoName=${f#$twd/}

     #echo "$f" > "${cwd}/${outputFile}/Test$$.csv"
    # git log --pretty=format:"%H,%as,%an"> "${cwd}/${outputFile}/OutputFile$$.csv"
  
    
   if !  git log --pretty=format:"$repoName,%cd,%H,%an" --date=format:'%Y%m%d' >> "${cwd}/${outputFile}/OutputFile$$.csv"; then
   echo "Error while getting the log of $f"
   fi

    else
      #directory is not a repo
      
      #Write non Directory items in File
      echo "$f" >>"/tmp/nonrepolist.$$"
    fi

    cd "$cwd"
  fi

done

echo -e "\n"

if [ -f /tmp/nonrepolist.$$ ]; then
  echo "Non Repo Directorys:"
  cat /tmp/nonrepolist.$$
fi
echo -e "\n \n"

#for i in "$nonRepolist";do

#echo "$i is not a repo"

#done

# wenn Subdirectoys
#no -> End

#yes -> Continue

# For each Directory
for f in $subdirectories; do
  echo "File -> $f"
done
## if Directory is Repo
### no -> Save Folder Name
### yes -> Add Commitmessages to output File

#

#output nonRepo Directorys

## end
