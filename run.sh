#!/bin/bash
# cd /aistt/AISmartToppingTable

echo "AISTT Start!!"

PROJECT_NAME="AISmartToppingTable"
GIT_URI="git@github.com:gopizza/$PROJECT_NAME.git"
PROJECT_DIRECTORY="/aistt"
echo "PROJECT NAME : $PROJECT_NAME"
echo "GIT URL : $GIT_URI"
echo "PROJECT DIR : $PROJECT_DIRECTORY"
echo 

# Download project according repository GIT
echo "Download Project from GIT"
if [ ! -d "$PROJECT_DIRECTORY/$PROJECT_NAME" ] ; then
    cd "$PROJECT_DIRECTORY" && git clone "$GIT_URI" "$PROJECT_DIRECTORY/$PROJECT_NAME" --verbose
    cd "$PROJECT_DIRECTORY/$PROJECT_NAME"
else
    cd "$PROJECT_DIRECTORY/$PROJECT_NAME" && git pull
fi
echo

bash /aistt/AISmartToppingTable/MenuTracker/run.sh >> /aistt/log/menu.log 2>&1 &
bash /aistt/AISmartToppingTable/Face/run.sh >> /aistt/log/face.log 2>&1 &
bash /aistt/AISmartToppingTable/Vat/run.sh >> /aistt/log/vat.log 2>&1 &