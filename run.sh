	#! /bin/bash
	if [ -z "$1" ]
	then
	     ProjectName="ddApi"
	else
		ProjectName=$1
	fi
	if [ -z "$2" ]
	then
	     GitUrl="https://github.com/guoxiangke/dcdc_api.git"
	else
		GitUrl=$2
	fi

	if [ -z "$3" ]
	then
	    GitBranch="master"
	else
		GitBranch=$3
	fi
	echo Your ProjectName is : $ProjectName
	echo your github url $GitUrl
	echo your github Branch must be $GitBranch
	drupalFolder="drupal"
	mkdir -p ./$drupalFolder && cd ./$drupalFolder
	if [ -d .git ]; then
		git checkout .
		git fetch
		git checkout $GitBranch
		git pull origin $GitBranch
		cd ../
		#todo if ./drupal/composer.yml update : docker build -t="drupal:composer" .
	else
		cd ../
		rm ./$drupalFolder -rf
		git clone -b $GitBranch $GitUrl ./$drupalFolder
	fi;
	
	
	docker-compose -p $ProjectName down --remove-orphans
	docker-compose -p $ProjectName  up -d  --build --remove-orphans --force-recreate

	docker restart a-nginx a-nginx-gen