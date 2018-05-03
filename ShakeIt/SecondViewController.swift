//
//  SecondViewController.swift
//  ShakeIt
//
//  Created by Ryohei Nanano on 2018/05/04.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!//コインの枚数表示するLabel
    var coins: Int = 0//前の画面からコインの枚数を受け取る為の変数(初期値0)

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = String(coins)
    }

   
    @IBAction func button()
    {
        self.dismiss(animated: true, completion: nil)//前の画面に戻る
    }

}
