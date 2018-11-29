#!/bin/bash

git_init(){	
        read -p "Please enter the link of the remote repository: " remote_link
	git init
	git remote add origin "$remote_link"
	git pull origin master
}

git_pull(){
	git pull origin master
}

git_fetch(){
	git fetch origin master
}

git_merge(){
	git merge origin/master
}

git_rebase(){
	git rebase -p origin/master
}

do_merge(){
	while true; 
	do
    	read -p "Do your want to merge the repository? (yes or no):" yn
    	case $yn in
        	[Yy]* )
				git_merge
				break;;
        	[Nn]* )
				break;;
        	* ) echo "Please answer yes or no.";;
    	esac
	done
}

do_rebase(){
	while true; 
	do
    	read -p "Do your want to rebase the repository? (yes or no):" yn
    	case $yn in
        	[Yy]* )
				git_rebase
				break;;
        	[Nn]* )
				break;;
        	* ) echo "Please answer yes or no.";;
    	esac
	done
}

merge_rebase_options(){
	while true; 
	do
    	read -p "Enter number 1 to git merge, or number 2 to git rebase: " nu
    	case $nu in
        	"1" )
				echo "You chose number 1; that is merge."
            	do_merge
				break;;
        	"2" )
				echo "You chose number 2; that is rebase."
            	do_rebase
				break;;
        	* ) echo "Please enter number 1 or 2.";;
    	esac
	done
}

fetch_pull_options(){
	while true; 
	do
    	read -p "Enter number 1 to git pull, or number 2 to git fetch: " nu
    	case $nu in
        	"1" )
				echo "You chose number 1; that is pull."
            	git_pull
				break;;
        	"2" )
				echo "You chose number 2; that is fetch."
            	git_fetch
            	merge_rebase_options
				break;;
        	* ) echo "Please enter number 1 or 2.";;
    	esac
	done
}

do_fetch_pull_options(){
	while true; 
	do
    	read -p "Do you want to update from the remote repository? (yes or no):" yn
    	case $yn in
        	[Yy]* )
				fetch_pull_options
				break;;
        	[Nn]* )
				break;;
        	* ) echo "Please answer yes or no.";;
    	esac
	done
}

main(){

	git_status_results=$(git status)

	if [[ $git_status_results =~ 'On branch master' ]]; then

		echo "This directory is a git repository."

            git_remote_status_results=$(git remote show origin)
        
            if [[ $git_remote_status_results =~ 'up to date' ]]; then
        	
        	echo "The local repository is up to date."
            else
        	
        	echo "The local repository is out of date"
        	do_fetch_pull_options
            fi
	else
            echo "You will need to clone a git repository first.  We will do it for you."
            git_init
	fi
}

main
