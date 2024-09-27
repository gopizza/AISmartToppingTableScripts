echo "AISTT Start!!"

PROJECT_NAME="AISmartToppingTableV3.0"
GIT_URI="git@github.com:gopizza/$PROJECT_NAME.git"
PROJECT_DIRECTORY="/home/gopizza/aistt"
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
    cd AISTT/build
    cmake ..
    make -j4
    cp libLIBAISTT.so /home/gopizza/lib/
fi
echo

/bin/python3 $PROJECT_DIRECTORY/$PROJECT_NAME/pyLauncher/aistt.py