# source: https://gist.github.com/phatblat/1713458
# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# Mujoco - https://www.roboti.us/"
echo "############################"
echo ""
echo "MuJoCo stands for Multi-Joint dynamics with Contact."
echo "It is a physics engine aiming to facilitate research and"
echo "development in robotics, biomechanics, graphics and animation," 
echo "and other areas where fast and accurate simulation is needed."
echo ""
echo "MANUAL STEPS REQUIRED - NEED MUJOCO LICENSE IN ~/Downloads/mjkey.txt"


cd ~/src/

# if [ ! -d ~/src/mujoco ]
# then
# fi
mkdir -p mujoco
cd ~/src/mujoco
curl -O https://www.roboti.us/download/mjpro140_linux.zip
unzip -a mjpro140_linux.zip

curl -O https://www.roboti.us/download/mjpro131_linux.zip
unzip -a mjpro131_linux.zip

cd ~/src/mujoco
cp ~/Downloads/mjkey.txt ~/src/mujoco/mjpro131

cd $DIR
