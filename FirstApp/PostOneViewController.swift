//
//  PostOneViewController.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit
import NCMB
import PKHUD

class PostOneViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var whoTextField: UITextField!
    
    @IBOutlet var whatTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
         //グラデーションの開始色
               let topColor = UIColor(red:0.03, green:0.78, blue:0.96, alpha:1)
               //グラデーションの開始色
               let bottomColor = UIColor(red:0.1, green:0.13, blue:0.75, alpha:1)

               //グラデーションの色を配列で管理
               let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]

               //グラデーションレイヤーを作成
               let gradientLayer: CAGradientLayer = CAGradientLayer()

               //グラデーションの色をレイヤーに割り当てる
               gradientLayer.colors = gradientColors
               //グラデーションレイヤーをスクリーンサイズにする
               gradientLayer.frame = self.view.bounds

               //グラデーションレイヤーをビューの一番下に配置
               self.view.layer.insertSublayer(gradientLayer, at: 0)
               
        

        whoTextField.borderStyle = .none
        whoTextField.layer.cornerRadius = 5
        whoTextField.layer.borderColor = UIColor.lightGray.cgColor
        whoTextField.layer.borderWidth  = 1
        whoTextField.layer.masksToBounds = true
        whoTextField.backgroundColor = .white
        
        
         // 枠のカラー
                      whatTextView.layer.borderColor = UIColor.white.cgColor
                      
                      // 枠の幅
                      whatTextView.layer.borderWidth = 1.0
                      
                      // 枠を角丸にする
                      whatTextView.layer.cornerRadius = 5.0
                      whatTextView.layer.masksToBounds = true
        whatTextView.backgroundColor = .white
    }
    
    
     
          
          
    
    

    @IBAction func Save() {
        
        let alert: UIAlertController = UIAlertController(title: "Save", message: "保存してもよろしいですか？", preferredStyle: .alert)
                   // OKボタン
                   let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
        let saveObject = NCMBObject(className: "Save")
                    saveObject?.setObject(self.whoTextField.text!, forKey: "whoText")
                    saveObject?.setObject(self.whatTextView.text!, forKey: "whatText")
        saveObject?.saveInBackground({ (error) in
            if error != nil {
                HUD.show(.error)
                print(error)
            } else {
               print("success")
            PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Success", subtitle: "Save complete")
            PKHUD.sharedHUD.show(onView: self.view)
            PKHUD.sharedHUD.hide(afterDelay: 2.0) { _ in
                
            self.navigationController?.popViewController(animated: true)
                
            }

            }
        })
        
    }
        // キャンセルボタン
                   let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                           //キャンセルボタンを押した時のアクション
                           alert.dismiss(animated: true, completion: nil)
        }
                   alert.addAction(okAction)
                   alert.addAction(cancelAction)
                   self.present(alert, animated: true, completion: nil)
                   
    }

}
