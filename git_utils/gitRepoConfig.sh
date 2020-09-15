#!/bin/bash -x
# Version 0.1
# shellcheck disable=SC2086
echo "WARNING only run this script in the directory that you want the git repo in.  This script will clone the reposity in the directory it is running in."
while true; do
	echo "Menu"
	echo "1. Clone a Repository"
	echo "2. Clone a Repository with an Upstream Repository"
	echo "3. Add an Upstream Repository"
	echo "4. Update a Repository from Upstream"
	echo "5. Do not select Designed for future use"
	echo "6. Do not select Designed for future use"
	echo "7.Exit"

	read -r choice
	case $choice in

	1)
		echo "Please Enter your Repository: "
		read -r repo
		echo $repo
		git clone $repo
		;;

	2)
		read -rp "Please Enter your Repository: " repo
		read -rp "Please enter the directory of the reposity: " repodir
		read -rp "Please enter the upstream reposity: " uprepo
		echo $repo
		echo $repodir
		echo $uprepo
		git clone $repo
		cd $repodir || exit 1
		git remote add upstream $uprepo
		git fetch upstream
		git checkout master
		git merge upstream/master
		git push
		;;

	3)
		read -rp "Please enter the directory of the reposity: " repodir
		read -rp "Please enter the upstream reposity: " uprepo
		echo $repodir
		echo $uprepo
		cd $repodir || exit 1
		git remote add upstream $uprepo
		git fetch upstream
		git checkout master
		git merge upstream/master
		git push
		;;

	4)
		read -rp "Please enter the directory of the reposity: " repodir
		echo $repodir
		cd $repodir || exit 1
		git fetch upstream
		git checkout master
		git merge upstream/master
		git push
		;;

	5)
		echo "Do not select Designed for future use"
		;;

	6)
		echo "Do not select Designed for future use"
		;;

	7)
		exit
		;;
	*)
		echo "invalid no."
		;;

	esac
done
