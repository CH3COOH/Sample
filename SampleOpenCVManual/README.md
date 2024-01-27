# SampleOpenCVManual

iOSプロジェクトにOpenCVを追加し、（OpenCVの基本的な使い方として）サンプル画像をグレースケール変換する

## 環境設定

1. このディレクトリにある `build_opencv2_xcframework.sh` を実行して opencv2.xcframework をビルドする
2. OpenCVSample ディレクトリに opencv2.xcframework を配置する

## 注意事項

* `build_opencv2_xcframework.sh` で指定しているワークスペースは任意のディレクトリパスに書き換えてください
* 環境の条件が異なる場合、ビルドできない可能性があります

Add the following frameworks:

* libc++.tbd
* CoreMedia
* CoreImage
* CoreGraphics

Additionally, add `-all_load` to the `Other Linker Flags`.

## 検証環境について

検証環境は以下の通りです。

* MacBook Pro (16-inch, 2021) Apple M1 Pro
* CMake 3.81
* Python 3.8.10
* Xcode 15.1
* macOS 14.1
* OpenCV 4.9.0