# このスクリプトを実行して permission denied が発生した場合は
# `chmod +x build_opencv2_xcframework.sh` を実行してください

OPENCV_VERSION=4.9.0
SOURCE_URL=https://github.com/opencv/opencv/archive/refs/tags/$OPENCV_VERSION.zip
WORKSPACE_DIR=~/works/opencv

mkdir -p "$WORKSPACE_DIR/opencv-$OPENCV_VERSION"

curl -L $SOURCE_URL -o "$WORKSPACE_DIR/$OPENCV_VERSION.zip"
unzip "$WORKSPACE_DIR/$OPENCV_VERSION.zip" -d "$WORKSPACE_DIR"

cd "$WORKSPACE_DIR/opencv-$OPENCV_VERSION"

python ./platforms/apple/build_xcframework.py --out ./build --iphoneos_archs arm64 --macos_archs arm64 --catalyst_archs arm64 --iphonesimulator_archs arm64 --iphoneos_deployment_target 14 --build_only_specified_archs --without videoio --without video --without ts --without photo --without ml --without highgui --without gapi