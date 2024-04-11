echo "AISTT Start!!"

PROJECT_NAME="AISmartToppingTableScripts"
GIT_URI="git@github.com:gopizza/$PROJECT_NAME.git"
PROJECT_DIRECTORY="/home/gopizza/project"
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
    cd "$PROJECT_DIRECTORY/$PROJECT_NAME"
    git stash && git pull && git stash pop
fi
echo

/bin/python3 $PROJECT_DIRECTORY/$PROJECT_NAME/check.py