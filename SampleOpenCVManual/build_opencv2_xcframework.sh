OPENCV_VERSION=4.9.0
SOURCE_URL=https://github.com/opencv/opencv/archive/refs/tags/$OPENCV_VERSION.zip
WORKSPACE_DIR=/Users/ch3cooh/works/opencv

mkdir -p "$WORKSPACE_DIR/opencv-$OPENCV_VERSION"

curl -L $SOURCE_URL -o "$WORKSPACE_DIR/$OPENCV_VERSION.zip"
unzip "$WORKSPACE_DIR/$OPENCV_VERSION.zip" -d "$WORKSPACE_DIR"

cd "$WORKSPACE_DIR/opencv-$OPENCV_VERSION"

python ./platforms/apple/build_xcframework.py --out ./build --iphoneos_archs arm64 --iphonesimulator_archs arm64 --iphoneos_deployment_target 14 --build_only_specified_archs --without videoio --without video --without ts --without stitching --without photo --without ml --without highgui --without gapi