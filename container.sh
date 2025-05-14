#!/bin/bash
STORE_INDEX='1'
NAME='aistt'
#IMAGE='nvcr.io/nvidia/l4t-pytorch:r35.2.1-pth2.0-py3'
IMAGE='futureplanning/aistt:jetson'
COUNTRY_CODE='KR' # KR ID TH

bash manage.sh $STORE_INDEX $NAME $IMAGE $COUNTRY_CODE