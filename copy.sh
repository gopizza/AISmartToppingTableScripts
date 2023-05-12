# docker cp settings/camera.env aistt:/aistt/AISmartToppingTable/Camera/.env
# docker cp settings/face.env aistt:/aistt/AISmartToppingTable/Face/.env

# docker cp settings/menu.sh aistt:/aistt/AISmartToppingTable/MenuTracker/run.sh
# docker cp settings/face.sh aistt:/aistt/AISmartToppingTable/Face/run.sh
# docker cp settings/vat.sh aistt:/aistt/AISmartToppingTable/Vat/run.sh

if [ -e ‘"/dev/video0"’ ] ; then
    echo 'test2'
else
    echo 'test2'
fi