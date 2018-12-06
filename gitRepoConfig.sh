#!bin/bash -x
echo "WARNING only run this script in the directory that you want the git repo in.  This script will clone the reposity in the directory it is running in."
while `test $ans='y'`
do
    echo "Menu"
    echo "1. Clone a Repository"
    echo "2. Clone a Repository with an Upstream Repository"
    echo "3. Add an Upstream Repository"
    echo "4. Update a Repository from Upstream"
    echo "5. Do not select Designed for future use"
    echo "6. Do not select Designed for future use"
    echo "7.Exit"

    read choice
    case $choice in

    1) echo "Please Enter your Repository: "
       read repo
       echo $repo
       git clone $repo
       ;;

    2) read -p  "Please Enter your Repository: " repo
       read -p "Please enter the directory of the reposity: " repodir
       read -p "Please enter the upstream reposity: " uprepo
       echo $repo
       echo $repodir
       echo $uprepo
       git clone $repo
       cd $repodir
       git remote add upstream $uprepo
       git fetch upstream
       git checkout master
       git merge upstream/master
       git push
       ;;

    3) read -p "Please enter the directory of the reposity: " repodir
       read -p "Please enter the upstream reposity: " uprepo
       echo $repodir
       echo $uprepo
       cd $repodir
       git remote add upstream $uprepo
       git fetch upstream
       git checkout master
       git merge upstream/master
       git push
       ;;

    4) read -p "Please enter the directory of the reposity: " repodir
       echo $repodir
       cd $repodir
       git fetch upstream
       git checkout master
       git merge upstream/master
       git push
       ;;

    5) echo "Do not select Designed for future use"
      ;;

    6) echo "Do not select Designed for future use"
       ;;

    7) exit
      ;;
      *) echo "invalid no."
      ;;

    esac
done
