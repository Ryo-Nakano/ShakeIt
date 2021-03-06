//
//  ViewController.swift
//  ShakeIt
//
//  Created by Ryohei Nanano on 2018/05/02.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import AVFoundation//SE鳴らす為の準備

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var navigationLabel: UILabel!//振った結果を表示
    @IBOutlet weak var numbersOfCoinsLabel: UILabel!//合計コイン獲得枚数を表示する為のLabel
    var coins: Int = 0//所持コイン枚数
    
    var canShake: Bool = true//shakeの可否を判定するフラグ
    var gameMode: String = "normal"//初期値はnormal
    
    var audioPlayerInstance : AVAudioPlayer! = nil  // 再生するサウンドのインスタンスを作成
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: "coin", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        
        // AVAudioPlayerのインスタンスを作成
        do {
            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)//これでいつでも音再生できるようになった
        } catch {
            print("AVAudioPlayerインスタンス作成失敗")
        }
        
        // バッファに保持していつでも再生できるようにする
        audioPlayerInstance.prepareToPlay()
    }
    
    //Viewが作られる度に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        _init()//各種パラメータの初期化
    }
    
    
    
    //==========シェイクモーション検知==========
    ///シェイクモーション開始時に呼ばれる
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            print("ShakeBegan!!")
        }
    }
    
    ///シェイクモーション終了時に呼ばれる
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == UIEventSubtype.motionShake {
            print("ShakeEnded!!!")
            
            getCoin(mode: gameMode)//gameModeに応じてcoin取得の処理(確率可変)
            changeGameMode(i: generateRandomNumber(min: 1, max: 10))//1-10の乱数の結果に応じてgameModeを変更
        }
    }
    
    ///シェイクモーションが途中でキャンセルされた時に呼ばれる
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
//        print("motionCancelled - subtype: \(motion.rawValue) with \(event)")
        if motion == UIEventSubtype.motionShake {
            print("  SHAKE...")
        }
    }

    
    //==========関数・メソッド==========
    
    //コインゲットする関数(shake1回につき1回呼ばれる)
    func getCoin(mode: String) {//引数にmodeを取る→ここの値によって確率や獲得コインが可変
        if canShake == true {
            canShake = false
            let randomNum = generateRandomNumber(min: 1, max: 100)//1-100までの乱数発生→変数randomNumberに格納
            
            switch mode{
            case "Normal"://通常モード
                //→死ぬ確率5%
                print("Do with \(mode) mode")
                
                if randomNum > 5{//randomNumが6-100の時
                    coins += 10//所持コイン+10
                    navigationLabel.text = "10コイン獲得！！"
                    numbersOfCoinsLabel.text = String(coins)
                    audioPlayerInstance.play()//SEの再生
                    canShake = true
                }
                else{//randomNumが1-5の範囲の時
                    //GameOver
                    print("GameOver")
                    coins = 0//コイン没収
                    numbersOfCoinsLabel.text = String(coins)//コイン枚数表示
                    infoLabel.text = "運の悪さに脱帽"
                    navigationLabel.text = "死んだ。"
                    sleep(1)//1s間待つ
                }
                
            case "Coin2x"://コイン獲得数2倍,死ぬ確率2倍
                print("Do with \(mode) mode")
                
                if randomNum > 10{//randomNumが11-100の時
                    coins += 20//所持コイン+10
                    navigationLabel.text = "20コイン獲得！！！！"
                    numbersOfCoinsLabel.text = String(coins)
                    audioPlayerInstance.play()//SEの再生
                    //ToDo:2枚連続でコイン取得する音にしたいな
                    canShake = true
                    
                }
                else{//randomNumが1-10の範囲の時
                    //GameOver
                    print("GameOver")
                    coins = 0//コイン没収
                    numbersOfCoinsLabel.text = String(coins)//コイン枚数表示
                    infoLabel.text = "ほら。欲張るから"
                    navigationLabel.text = "欲張ったら死んだ。"
                    sleep(1)//1s間待つ
                }

            case "Death50%"://保持コイン2倍,死ぬ確率50%
                print("Do with \(mode) mode")
                
                if randomNum > 50{//randomNumが51-100の時
                    coins *= 2//所持コイン2倍
                    navigationLabel.text = "コイン2倍！！！！！！"
                    numbersOfCoinsLabel.text = String(coins)
                    audioPlayerInstance.play()//SEの再生
                    //ToDo:ここもっと派手な音にしたいな
                    canShake = true
                }
                else{//randomNumが1-50の範囲の時
                    //GameOver
                    print("GameOver")
                    coins = 0//コイン没収
                    numbersOfCoinsLabel.text = String(coins)//コイン枚数表示
                    infoLabel.text = "引き際が大事と何度..."
                    navigationLabel.text = "死ぬと思ってた。"
                    sleep(1)//1s間待つ
                }
                
            default://それ以外の時
                return
            }
        }
    }
    
    //getCoin関数のmodeを切り替える関数
    func changeGameMode(i: Int) {
        if canShake == true {
            switch i {//iの値に応じて条件分岐
            case 1...7://1-7の間の値の時
                gameMode = "Normal"
                
            case 8...9://8か9の時
                gameMode = "Coin2x"
                
            default://10の時
                gameMode = "Death50%"
            }
            print("Changed \(gameMode) Mode !!!")
            print("==============================")
            infoLabel.text = "\(gameMode) Mode"
        }
    }
    
    //『チキる』ボタン押した時に呼ばれるメソッド
    @IBAction func chikiru()
    {
        showAlert()//アラートの表示
        //ToDo:次の画面に値を渡しつつ画面遷移するコードを記述
        //AlertCOntrollerを出して『本当にチキりますか？』とか出したい
        //そこで『チキる』を選んだら画面遷移
    }
    
    //乱数を発生させて、Int型で返してくれるメソッド
    func generateRandomNumber(min: UInt32, max: UInt32) -> Int {//maxからminの範囲の乱数をInt型で返してくれる
        return Int(arc4random_uniform(UInt32(max - min + 1)) + min)
    }

    func showAlert()
    {
        //①AlertControllerを作成
        let alert = UIAlertController(title: "ほんとうにチキりますか？", message: "ほんとのほんと？", preferredStyle: .alert)
        
        //②アクションを定義
        let okAction = UIAlertAction(title: "チキる", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            //『チキる』ボタン押したら呼ばれる！
            self.performSegue(withIdentifier: "goSecond", sender: self.coins)//"SecondViewController"のID持つセグエの先に画面遷移
            //画面遷移しつつ、遷移先にcoinsの値を渡す
        })
        let cancelAction = UIAlertAction(title: "男気見せる", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        //③AlertControllerにアクションを追加
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        //④アラートを表示
        self.present(alert, animated: true, completion: nil)
    }
    
    //各種パラメータの初期化をする関数
    func _init()
    {
        navigationLabel.text = "ざわ.. ざわ.."
        gameMode = "Normal"
        infoLabel.text = "Shake It"
        coins = 0
        canShake = true
        numbersOfCoinsLabel.text = "0"
    }
    
    //segueを用いた画面遷移時に値を次の画面に渡す関数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SecondViewController//segueの先にあるViewControllerを取得→SecondViewController型にダウンキャスト→変数vcに格納
        vc.coins = coins//取得したvcの中にあるcoinsに対して、こちらのcoinsの値を渡す
    }

}

