#!/bin/bash
# Simple script to process all of the images inside the inputs/ folder
# We will be running this script inside the visionai/clouddream Docker image
# Copyright vision.ai, 2015


cd /opt/deepdream/inputs
find . -type f -not -path '*/\.*' -print0 | while read -d $'\0' f;
do
    cd /opt/deepdream
    if [ -e outputs/${f} ];
    then
	echo "File ${f} already processed"
	echo "Processing again"

	chmod 777 inputs/${f}

	rm inputs/${f}
	cp outputs/${f} inputs/${f}

	cp inputs/${f} input.jpg
	python deepdream.py
	ERROR_CODE=$?
	echo "Error Code is" ${ERROR_CODE}

	rm input.jpg
	cp output.jpg outputs/${f}
	cp output.jpg inputs/${f}
	rm output.jpg

	echo "Just created" outputs/${f}

    else
	echo "Deepdream" ${f}
	chmod 777 inputs/${f}

	cp inputs/${f} input.jpg
	python deepdream.py
	ERROR_CODE=$?
	echo "Error Code is" ${ERROR_CODE}

	rm input.jpg
	cp output.jpg outputs/${f}
	cp output.jpg inputs/${f}
	rm output.jpg

	echo "Just created" outputs/${f}
    fi
done


