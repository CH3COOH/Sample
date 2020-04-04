# SampleIOSCartsDisplayValue

https://teratail.com/questions/251253 の質問に答えるために作成したサンプルプロジェクトです。

iOS-Cartsの `LineChartView` で線グラフを表示している。データの値が「小数点第二位」まで表示されており、これを「小数点第一位」までの表示に修正したいという質問でした。

iOS-Cartsは多機能でなんでもできる反面、設定が複雑で何もできなくなってしまいがちです。

小数点第一位まで表示させたいとのことでしたので、`IValueFormatter`を継承した ValueFormatterクラスを作成しました。

```
class ValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%0.1f", value)
    }
}
```

`LineChartDataSet#valueFormatter` に `ValueFormatter` を設定することで、任意の形式でグラフの値を表示させることができます。

```
let ds = LineChartDataSet(entries: yValues, label: "year") //ds means DataSet
ds.valueFormatter = ValueFormatter() // add
```

下図は、前述のコードを追加して実行した結果です。

<img width="870" alt="スクリーンショット 2020-04-04 17 59 46" src="https://user-images.githubusercontent.com/137952/78423034-6c2cb100-769e-11ea-96ff-43b86f058774.png">

### 検証環境について

検証環境は以下の通りです。

* Xcode 11.4
* iOS 13.4
* Charts 3.4.0
