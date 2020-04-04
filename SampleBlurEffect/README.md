# SampleBlurEffect

https://teratail.com/questions/235983 の質問に答えるために作成したサンプルプロジェクトです。

UIVisualEffectViewを使って画像をぼかしたいという質問でした。

Interface Builderで画面を組む際には、UIImageViewの前面にUIVisualEffectView置くと下図のように画像にブラーがかかります。

<img width="538" alt="スクリーンショット 2020-03-30 21 21 50" src="https://user-images.githubusercontent.com/137952/77912658-e7bce580-72cd-11ea-9e4f-9468d2e1a749.png">

動的に配置する際にも同様にUIVisualEffectViewがUIImageViewよりも前面になるように addSubview()する順番を変更しました。

![Simulator Screen Shot - iPhone 8 - 2020-03-30 at 21 23 33](https://user-images.githubusercontent.com/137952/77912676-edb2c680-72cd-11ea-8f6c-e6ea06ee6933.png)

### 検証環境について

検証環境は以下の通りです。

* Xcode 11.4
* iOS 13.4
