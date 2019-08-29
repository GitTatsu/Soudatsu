//
//  StatisticsViewController.swift
//  Soudatsu
//
//  Created by USER on 2019/08/21.
//  Copyright © 2019 SwiftProject. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Charts

class StatisticsViewController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var barChartView: BarChartView!
    @IBOutlet var menuStatisticsOpenButton : UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var backImage: UIImageView!
    
    //一度だけメニュー作成するフラグ
    var didPrepareMenu = false
    //タブの横幅
    let tabLabelWidth:CGFloat = 150
    //平均ラベル
    let averageLabel = UILabel()
    //グラフに入れるデータ
    var barDataEntries = [BarChartDataEntry]()
    //データクリアボタン
    let clearButton = CustomButton()
    //ポップアップへ渡す仮引数
    var preDate : String = ""
    
    //override func viewDidLoad() {
    //viewDidLoadで処理を行うとscrollViewの正しいサイズが取得できない
    override func viewDidLayoutSubviews() {
        
        //super.viewDidLoad()
        
        //viewDidLayoutSubviewはviewDidLoadと違い何度も呼ばれてしまうので、
        //一度だけメニュー作成を行うようにする
        if didPrepareMenu { return }
        didPrepareMenu = true
        
        //メニューボタンのカスタム
        menuStatisticsOpenButton.layer.borderColor = UIColor.black.cgColor
        menuStatisticsOpenButton.layer.borderWidth = 1.0
        menuStatisticsOpenButton.layer.cornerRadius = 10.0
        menuStatisticsOpenButton.layer.masksToBounds = true
        
        //realmファイルのパス
        let Path = NSHomeDirectory() + "/Documents"
        let filePath = NSURL(fileURLWithPath: Path + "/default.realm")
        //Realmインスタンス生成
        let realm = try! Realm(fileURL: filePath as URL)
        //取得条件の作成
        let dateArray = Set(realm.objects(DataBase.self).value(forKey:"date") as! [String])
        let dateSortArray = dateArray.sorted()
        
        //スクロールビュー
        scrollView.delegate = self
        let tabLabelHeight:CGFloat = scrollView.frame.size.height
        
        //右端にダミーのUILabelを置くことで一番右のタブもセンターに持ってくることが出来る
        let dummyLabelWidth = scrollView.frame.size.width / 2 - tabLabelWidth / 2
        let headDummyLabel = UILabel()
        headDummyLabel.frame = CGRect(x: 0, y: 0, width: dummyLabelWidth, height: tabLabelHeight)
        scrollView.addSubview(headDummyLabel)
        //タブの初期位置
        var originX:CGFloat = dummyLabelWidth
        
        //配列に日付を代入
        for date in dateSortArray {
            let button = CustomButton()
            button.frame = CGRect(x:originX + 10, y:0, width:tabLabelWidth - 20, height:tabLabelHeight - 20)
            button.tag = 1
            button.setTitle(date, for: .normal)
            button.setTitleColor(UIColor(red: 55 / 255, green: 61 / 255, blue: 158 / 255, alpha: 1.0), for: .normal)
            button.backgroundColor = UIColor(red: 187 / 255, green: 201 / 255, blue: 238 / 255, alpha: 1.0)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 10
            button.date = date
            //ボタンのメソッド
            button.addTarget(self, action: #selector(buttonEvent(_:)), for: .touchUpInside)
            //スクロールビュー用のViewに追加
            scrollView.addSubview(button)
            //タブのX座標を移動
            originX += tabLabelWidth
        }
        //左端にもダミーのUILabelを置く
        let tailLabel = UILabel()
        tailLabel.frame = CGRect(x: originX, y: 0, width: dummyLabelWidth, height: tabLabelHeight)
        scrollView.addSubview(tailLabel)
        //ダミーLabel分を足す
        originX += dummyLabelWidth
        
        //scrollViewのcontentSizeを、タブ全体のサイズに合わせてあげる
        //最終的なoriginXはタブ全体の横幅になる
        scrollView.contentSize = CGSize(width: originX, height: tabLabelHeight)
        
        //平均値のラベル
        averageLabel.frame = CGRect(x: view.frame.size.width * 2 / 3, y: 0, width: 200, height: view.frame.size.height - scrollView.frame.size.height)
        averageLabel.text = ""
        averageLabel.textColor = UIColor.white
        averageLabel.font = UIFont.systemFont(ofSize: 20)
        averageLabel.numberOfLines = 0
        view.addSubview(averageLabel)
        
    }
    
    //ボタンイベント
    @objc func buttonEvent(_ sender : CustomButton){
        
        //表示用の配列
        let mapName : [String] = ["ボス","３方","３ボ","４方","脱出","くる","碑石","レバ","幽霊","スロ","ブラ","トゲ","ベレ"]
        var mapCount : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        var lapCount : [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        //realmファイルのパス
        let Path = NSHomeDirectory() + "/Documents"
        let filePath = NSURL(fileURLWithPath: Path + "/default.realm")
        //Realmインスタンス生成
        let realm = try! Realm(fileURL: filePath as URL)
        //日付で抽出
        let dayArray = realm.objects(DataBase.self).filter("date == %@ && lap != 10000", sender.date!)
        //一日分を配列から変数に格納
        for day in dayArray {
            switch (day.map) {
                case "ボス":
                    mapCount[0] += 1
                    lapCount[0] += day.lap
                    break
                case "３方":
                    mapCount[1] += 1
                    lapCount[1] += day.lap
                    break
                case "３ボ":
                    mapCount[2] += 1
                    lapCount[2] += day.lap
                    break
                case "４方":
                    mapCount[3] += 1
                    lapCount[3] += day.lap
                    break
                case "脱出":
                    mapCount[4] += 1
                    lapCount[4] += day.lap
                    break
                case "くる":
                    mapCount[5] += 1
                    lapCount[5] += day.lap
                    break
                case "碑石":
                    mapCount[6] += 1
                    lapCount[6] += day.lap
                    break
                case "レバ":
                    mapCount[7] += 1
                    lapCount[7] += day.lap
                    break
                case "幽霊":
                    mapCount[8] += 1
                    lapCount[8] += day.lap
                    break
                case "スロ":
                    mapCount[9] += 1
                    lapCount[9] += day.lap
                    break
                case "ブラ":
                    mapCount[10] += 1
                    lapCount[10] += day.lap
                    break
                case "トゲ":
                    mapCount[11] += 1
                    lapCount[11] += day.lap
                    break
                case "ベレ":
                    mapCount[12] += 1
                    lapCount[12] += day.lap
                    break
                default:
                    break
            }//END switch
        }//END for
        
        //日付切り替えにグラフデータのクリア
        barDataEntries.removeAll()
        //平均値の計算
        for i in 0 ..< mapCount.count {
            //グラフにデータを入れる
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(Int(mapCount[i])))
            barDataEntries.append(dataEntry)
            //平均ラップ
            var averageLap : Int = 0
            //マップカウントが0なら計算できないので分岐
            if (mapCount[i] == 0) {
                averageLap = 0
            }else{
                averageLap = lapCount[i] / mapCount[i]
            }
            //１周目だけ別処理
            if (i == 0) {
                averageLabel.text = ""
                averageLabel.text = mapName[i] + " : \t" + String(averageLap) + "秒"
            }else{
                averageLabel.text =  averageLabel.text?.appending("\n" + mapName[i] + " : \t" + String(averageLap) + "秒")
            }
        }
        //データセット
        let dataSet = BarChartDataSet(entries: barDataEntries, label: "クリアマップ数")
        dataSet.valueFont = UIFont.systemFont(ofSize: 16)
        dataSet.valueTextColor = UIColor.white
        dataSet.valueFormatter = ChartValueFormatter()
        
        //チャートカスタム
        //X軸
        let formatter = ChartStringFormatter()
        barChartView.xAxis.valueFormatter = formatter
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelCount = mapCount.count - 1
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 16)
        barChartView.xAxis.labelTextColor = UIColor.white
        //Y軸
        barChartView.rightAxis.enabled = false //右軸削除
        barChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 16)
        barChartView.leftAxis.labelTextColor = UIColor.white
        
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        barChartView.isHidden = false
        barChartView.data = BarChartData(dataSet: dataSet)
        view.addSubview(barChartView)
        
        //クリアボタン
        clearButton.removeFromSuperview()
        clearButton.frame = CGRect(x: menuStatisticsOpenButton.frame.minX - menuStatisticsOpenButton.frame.width / 2, y: view.frame.size.height - scrollView.frame.size.height * 2, width: 75, height: 50)
        
        clearButton.setTitle("クリア", for: .normal)
        clearButton.setTitleColor(UIColor(red: 55 / 255, green: 61 / 255, blue: 158 / 255, alpha: 1.0), for: .normal)
        clearButton.backgroundColor = UIColor(red: 187 / 255, green: 201 / 255, blue: 238 / 255, alpha: 1.0)
        clearButton.alpha = 0.5
        clearButton.layer.borderWidth = 1
        clearButton.layer.cornerRadius = 10
        clearButton.date = sender.date!
        //ボタンのメソッド
        clearButton.addTarget(self, action: #selector(clearButtonEvent(_:)), for: .touchUpInside)
        //スクロールビュー用のViewに追加
        view.addSubview(clearButton)
        
    }//END func buttonEvent
    
    //データクリア
    @objc func clearButtonEvent(_ sender : CustomButton){
        //データクリア用の日付を一時格納
        preDate = sender.date!
        //ポップアップ表示
        performSegue(withIdentifier: "popup", sender: nil)
    }
    
    //データクリアセグエ実行時に引数を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popup" {
            let popupview : PopupViewController = segue.destination as! PopupViewController
            popupview.sendText = preDate
        }
    }
    
    //メニューボタン
    @IBAction func menuStatisticsOpenButton(_ sender: Any) {
        performSegue(withIdentifier: "menu", sender: nil)
    }
    
    //スクロールをタブの位置に持ってくるアニメーション
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == self.scrollView else { return }
        
        let index = Int((scrollView.contentOffset.x + tabLabelWidth / 2) / tabLabelWidth)
        let x = index * 150
        UIView.animate(withDuration: 0.3, animations: {
            scrollView.contentOffset = CGPoint(x: x, y: 0)
        })
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == self.scrollView else { return }
        
        let index = Int((scrollView.contentOffset.x + tabLabelWidth / 2) / tabLabelWidth)
        let x = index * 150
        UIView.animate(withDuration: 0.3, animations: {
            scrollView.contentOffset = CGPoint(x: x, y: 0)
        })
    }
    
    
}//END class StatisticsViewController

//ボタンに引数を持たせ渡す
class CustomButton : UIButton {
    var date : String?
}

//X軸を文字列に変換
class ChartStringFormatter : NSObject, IAxisValueFormatter {
    let mapName : [String] = ["ボス","３方","３ボ","４方","脱出","くる","碑石","レバ","幽霊","スロ","ブラ","トゲ","ベレ"]
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        return mapName[index]
    }
}

//Y値の小数点削除
class ChartValueFormatter : NSObject, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(Int(entry.y))
    }
}
