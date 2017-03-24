# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# Download Microsoft coco dataset"
echo "############################"
echo " http://mscoco.org/"
echo " https://github.com/pdollar/coco"
echo " To install supporting software run robotics_setup/coco.sh"



if [ ! -d $HOME/datasets ]
  mkdir -p $HOME/datasets/coco
fi

cd $HOME/datasets/coco

# Note that by running this download you agree to microsoft's terms and conditions
# http://mscoco.org/dataset/#download
if [ ! -f $HOME/datasets/coco/train2014.zip ] ; then
  curl -O http://msvocds.blob.core.windows.net/coco2014/train2014.zip
  curl -O http://msvocds.blob.core.windows.net/coco2014/val2014.zip
  curl -O http://msvocds.blob.core.windows.net/coco2014/test2014.zip
  curl -O http://msvocds.blob.core.windows.net/coco2015/test2015.zip
  curl -O http://msvocds.blob.core.windows.net/annotations-1-0-3/instances_train-val2014.zip
  curl -O http://msvocds.blob.core.windows.net/annotations-1-0-3/person_keypoints_trainval2014.zip
  curl -O http://msvocds.blob.core.windows.net/annotations-1-0-3/captions_train-val2014.zip
  curl -O http://msvocds.blob.core.windows.net/annotations-1-0-4/image_info_test2014.zip
  curl -O http://msvocds.blob.core.windows.net/annotations-1-0-4/image_info_test2015.zip

  unzip -u train2014.zip
  unzip -u val2014.zip
  unzip -u test2014.zip
  unzip -u test2015.zip
  unzip -u instances_train-val2014.zip
  unzip -u person_keypoints_trainval2014.zip
  unzip -u captions_train-val2014.zip
  unzip -u image_info_test2014.zip
  unzip -u image_info_test2015.zip

fi

cd $DIR
