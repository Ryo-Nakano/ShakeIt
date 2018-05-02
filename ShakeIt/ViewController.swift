//
//  ViewController.swift
//  ShakeIt
//
//  Created by Ryohei Nanano on 2018/05/02.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navigationLabel: UILabel!//振った結果を表示
    @IBOutlet weak var numbersOfCoinsLabel: UILabel!//合計コイン獲得枚数を表示する為のLabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    //==========シェイクモーション検知==========
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
//        print("motionBegan - subtype: \(motion.rawValue) with \(event)")
        if motion == UIEventSubtype.motionShake {
            print("ShakeBegan!!")
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
//        print("motionEnded - subtype: \(motion.rawValue) with \(event)")
        if motion == UIEventSubtype.motionShake {
            print("ShakeEnded!!!")
            
            //ここにコインゲットするしないとかの関数書けばいいのかな。
        }
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
//        print("motionCancelled - subtype: \(motion.rawValue) with \(event)")
        if motion == UIEventSubtype.motionShake {
            print("  SHAKE...")
        }
    }

    
    //==========関数・メソッド==========
    
    //コインゲットする関数(shake1回につき1回呼ばれる)
//    func getCoin(mode: String) {//引数にmodeを取る→ここの値によって確率や獲得コインが可変
//        let randomNum = generateRandomNumber(min: 1, max: 100//1-100までの乱数発生→変数randomNumberに格納
//        if randomNum > 3{//randomNumが4-100の時
//            
//        }
//        else{//randomNumが1,2,3のいずれかの時
//            
//        }
//    }
    
    
    //乱数を発生させて、Int型で返してくれるメソッド
    func generateRandomNumber(min: UInt32, max: UInt32) -> Int {//maxからminの範囲の乱数をInt型で返してくれる
        return Int(arc4random_uniform(UInt32(max - min + 1)) + min)
    }


}

