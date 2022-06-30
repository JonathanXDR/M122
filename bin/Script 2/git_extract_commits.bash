#!/bin/bash

echo -e "\n"
echo "------------------------------"
echo "####### Script started #######"
echo "------------------------------"
echo -e "\n"


#Vorbereitungen
##sudo install git
cwd=`pwd`
#Read RepoDirectory and output File
twd="$1"
nonRepolist=()

for f in $1/*; do
if [ -d "$f" ]; then

cd "$f"


if [ -d .git ]; then
#Directory is repo
    echo "repository here.";



else
#directory is not a repo
    #nonRepolist+="$f \n"
    echo "$f" >> "/tmp/nonrepolist.$$"
fi


cd "$cwd"
  fi
done

echo -e "\n"

if [ -f /tmp/nonrepolist.$$ ] ; then
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

