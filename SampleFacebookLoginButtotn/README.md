# SampleFacebookLoginButtotn

https://teratail.com/questions/249950 の質問に答えるために作成したサンプルプロジェクトです。

Facebook iOS SDKを導入して利用できるFBSDKLoginButtonの文言が「Contiune with Facebook」と英語で表示されていて、日本語で表示されないとのことでした。

<img width="875" alt="スクリーンショット 2020-03-30 20 18 36" src="https://user-images.githubusercontent.com/137952/77908029-b2ac9500-72c5-11ea-80df-6b3087ba104d.png">

検証したところプロジェクトの対応言語に「Japanese」を追加することで上図のように日本語で文言が表示できることが確認できました。

プロジェクトの対応言語は、下図のLocalizationsで追加することができます。

<img width="816" alt="スクリーンショット 2020-03-30 20 28 44" src="https://user-images.githubusercontent.com/137952/77908061-bfc98400-72c5-11ea-84eb-b78581ef59fd.png">

### 検証環境について

検証環境は以下の通りです。

* Xcode 11.4
* iOS 13.4
* Facebook SDK 6.3.0
