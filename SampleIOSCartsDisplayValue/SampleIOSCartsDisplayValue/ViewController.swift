//
//  ViewController.swift
//  SampleIOSCartsDisplayValue
//
//  Created by KENJI WADA on 2020/04/04.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ViewController: UIViewController, IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return year[Int(value)]
    }

    var year: [String]!
    var koshincod: [Double] = []
    weak var axisFormatDelegate: IAxisValueFormatter?
    @IBOutlet var iosChartsFigure: LineChartView! {
        didSet {
            //x軸設定
            iosChartsFigure.xAxis.labelPosition = .bottom //x軸ラベル下側に表示
            iosChartsFigure.xAxis.labelFont = UIFont.systemFont(ofSize: 11) //x軸のフォントの大きさ
            iosChartsFigure.xAxis.labelCount = Int(35) //x軸に表示するラベルの数
            iosChartsFigure.xAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //x軸ラベルの色
            iosChartsFigure.xAxis.axisLineColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //x軸の色
            iosChartsFigure.xAxis.axisLineWidth = CGFloat(1) //x軸の太さ
            iosChartsFigure.xAxis.drawGridLinesEnabled = true //x軸のグリッド表示
            iosChartsFigure.xAxis.granularity = 1.0
            //y軸設定
            iosChartsFigure.rightAxis.enabled = false //右軸(値)の表示
            iosChartsFigure.leftAxis.enabled = true //左軸（値)の表示
            iosChartsFigure.leftAxis.axisMaximum = 14 //y左軸最大値
            iosChartsFigure.leftAxis.axisMinimum = 0 //y左軸最小値
            iosChartsFigure.leftAxis.labelFont = UIFont.systemFont(ofSize: 11) //y左軸のフォントの大きさ
            iosChartsFigure.leftAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //y軸ラベルの色
            iosChartsFigure.leftAxis.axisLineColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1) //y左軸の色(今回はy軸消すためにBGと同じ色にしている)
            iosChartsFigure.leftAxis.drawAxisLineEnabled = true //y左軸の表示
            iosChartsFigure.leftAxis.labelCount = Int(5) //y軸ラベルの表示数
            iosChartsFigure.leftAxis.drawGridLinesEnabled = true //y軸のグリッド表示(今回は表示する)
            iosChartsFigure.leftAxis.gridColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) //y軸グリッドの色
            iosChartsFigure.leftAxis.valueFormatter = YAxisValueFormatter()
            
            //その他UI設定
            iosChartsFigure.noDataFont = UIFont.systemFont(ofSize: 30) //Noデータ時の表示フォント
            iosChartsFigure.noDataTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //Noデータ時の文字色
            iosChartsFigure.noDataText = "Keep Waiting" //Noデータ時に表示する文字
            iosChartsFigure.legend.enabled = false //"■ months"のlegendの表示
            iosChartsFigure.dragDecelerationEnabled = true //指を離してもスクロール続くか
            iosChartsFigure.dragDecelerationFrictionCoef = 0.6 //ドラッグ時の減速スピード(0-1)
            iosChartsFigure.chartDescription?.text = nil //Description(今回はなし)
            iosChartsFigure.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) //Background Color
            iosChartsFigure.animate(xAxisDuration: 1.2, yAxisDuration: 1.5, easingOption: .easeInOutElastic)//グラフのアニメーション(秒数で設定)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        axisFormatDelegate = self
        year = ["S49","S50","S51","S52","S53","S54","S55","S56","S57","S58","S59","S60","S61","S62","S63","H1","H2","H3","H4","H5","H6","H7","H8","H9","H10","H11","H12","H13","H14","H15","H16","H17","H18","H19","H20","H21","H22","H23","H24","H25","H26","H27","H28","H29","H30"]
        koshincod = [12.0,12.0,12.0,10.0,12.0,11.0,9.9,9.7,9.8,10.0,11.0,10.0,10.0,10.0,10.0,10.0,10.0,9.1,9.4,9.8,11.0,11.0,10.0,9.4,12.0,9.7,9.2,9.1,9.8,9.1,9.0,8.3,8.0,7.9,8.1,7.5,8.0,7.8,7.7,7.4,7.6,7.2,8.0,7.8,8.8]

        drawLineChart(xValArr: year, yValArr: koshincod)

    }

    //グラフ描画部分
    func drawLineChart(xValArr: [String], yValArr: [Double]) {
        iosChartsFigure.noDataText = "You need to provide data for the chart."
        var yValues : [ChartDataEntry] = [ChartDataEntry]()

        for (i, _) in yValArr.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValArr[i])
            yValues.append(dataEntry) //(ChartDataEntry(x: Double(i), y: dollars1[i]))

        }

        let data = LineChartData()
        let ds = LineChartDataSet(entries: yValues, label: "year") //ds means DataSet
        ds.valueFormatter = ValueFormatter()
        let xAxisValue = iosChartsFigure.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        
        ////グラフのUI設定
        //グラフのグラデーション有効化
        let gradientColors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.2196078449, green: 1, blue: 0.8549019694, alpha: 1).withAlphaComponent(0.3).cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.7, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        ds.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient

        //その他UI設定
        ds.lineWidth = 2.0 //線の太さ
        //ds.circleRadius = 0 //プロットの大きさ
        ds.circleRadius = 5.0
        ds.drawCirclesEnabled = true //プロットの表示
        ds.mode = .linear //直線にする
        ds.fillAlpha = 0.8 //グラフの透過率
        ds.drawFilledEnabled = false //グラフ下の部分塗りつぶし
        //ds.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //グラフ塗りつぶし色
        ds.drawValuesEnabled = true //各プロットのラベル表示
        ds.highlightColor = #colorLiteral(red: 1, green: 0.8392156959, blue: 0.9764705896, alpha: 1) //各点を選択した時に表示されるx,yの線
        ds.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] //Drawing graph
        let ll = ChartLimitLine(limit: 5, label: "環境基準")
        iosChartsFigure.leftAxis.addLimitLine(ll)

        ////グラフのUI設定

        data.addDataSet(ds)
        self.iosChartsFigure.data = data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

class YAxisValueFormatter: NSObject, IAxisValueFormatter {
    let numFormatter: NumberFormatter

    override init() {
        numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 1
        numFormatter.maximumFractionDigits = 1

        numFormatter.minimumIntegerDigits = 1 // how many digits do want before decimal
        numFormatter.paddingPosition = .beforePrefix
        numFormatter.paddingCharacter = "0"
    }

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return numFormatter.string(from: NSNumber(floatLiteral: value))!
    }
}

class ValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%0.1f", value)
    }
}
