VREPDIR=$HOME/src/V-REP_PRO_EDU_V3_3_2_64_Linux # Set to Vrep directory
# VREPDIR=/Applications/V-REP_PRO_EDU_V3_2_2_Mac/vrep.app/Contents/MacOS # OSX

TRACKERDIR=$HOME/src/robonetracker
BUILDDIR=$TRACKERDIR/build

LIBDIR=/lib # Change if using eclipse or OSX
# LIBDIR=/lib/Debug/ # OSX

LIBEXT=.so
# LIBEXT=.dylib

# link all available libraries to the vrep executable directory
for arg in "libagast" "libv_repExtGrlInverseKinematics" "libcamodocal_brisk" "libcamodocal_calib" "libcamodocal_camera_models" "libcamodocal_camera_systems" "libcamodocal_chessboard"  "libcamodocal_fivepoint" "libcamodocal_pugixml" "libcamodocal_DBoW2" "libcamodocal_gpl" "libcamodocal_sparse_graph" "libv_repExtHandEyeCalibration" "libv_repExtPivotCalibration" "libcamodocal_DUtilsCV" "libcamodocal_infrastr_calib" "libcamodocal_visual_odometry" "libfusionTrack64" "libv_repExtKukaLBRiiwa" "libcamodocal_DUtils" "libcamodocal_location_recognition" "libcamodocal_DVision" "libcamodocal_pose_estimation" "libceres" "libcamodocal_features2d" "libcamodocal_pose_graph" "libdevice64" "libv_repExtAtracsysFusionTrack"
do
    FILETOLINK=$BUILDDIR/$LIBDIR/$arg$LIBEXT
    echo "ln -s $FILETOLINK $VREPDIR"
    if [ -f $FILETOLINK ]
    then
        ln -s $FILETOLINK $VREPDIR
    else
        echo "skipped above link command because file $FILETOLINK doesn't exist"
    fi
done

# Link all relevant non-library files
for FILETOLINK in "$TRACKERDIR/modules/grl/src/lua/grl.lua" "$TRACKERDIR/modules/grl/src/lua/robone.lua" "$TRACKERDIR/modules/roboneprivate/data/RoboneSimulation_private.ttt" "$TRACKERDIR/modules/robone/data/RoboneSimulation.ttt"
do
    echo "ln -s $FILETOLINK $VREPDIR"
    if [ -f $FILETOLINK ]
    then
        ln -s $FILETOLINK $VREPDIR
    else
        echo "skipped above link command because file $FILETOLINK doesn't exist"
    fi
done

#ln -s $TRACKERDIR/modules/robone/data/RoboneSimulation.ttt $VREPDIR

# LINUXBREW use case only (this is uncommon):
# vrep won't pick up the correct libraries if everything is built with linuxbrew
# so change the dynamic library path loaded by vrep
#
# TODO: This solution isn't perfect, it may pick up versions conflicting with those
#       used to build vrep, resulting in mysterious crashes. Try to use the libraries
#       in the same directory as vrep whenever possible.
if [ -d $HOME/.linuxbrew ] ; then
    ln -s $HOME/.linuxbrew/lib $VREPDIR
    patchelf --set-rpath '$ORIGIN:$ORIGIN/lib' $VREPDIR/vrep
fi
