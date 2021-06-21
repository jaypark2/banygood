//
//  DetailViewController.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit
import NCMB
import PKHUD

class DetailViewController: UIViewController {
    
    var objectId: String!
    
    @IBOutlet var detailWho: UILabel!
    
    @IBOutlet var detailWhat: UITextView!
    

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
        
        detailWho.layer.cornerRadius = 5.0
        detailWho.backgroundColor = .white
         
               
               
                // 枠のカラー
                             detailWhat.layer.borderColor = UIColor.lightGray.cgColor
                             
                             // 枠の幅
                             detailWhat.layer.borderWidth = 1.0
                             
                             // 枠を角丸にする
                             detailWhat.layer.cornerRadius = 5.0
                             detailWhat.layer.masksToBounds = true
        

       }
    
    override func viewWillAppear(_ animated: Bool) {
        detailLoadData()
    }
    
    func detailLoadData() {
        
        let query = NCMBQuery(className: "Save")
        query?.whereKey("objectId", equalTo: objectId)
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print(error)
            } else {
                for saveObject in result as! [NCMBObject] {
                    let detailwhos = saveObject.object(forKey: "whoText")  as! String
                    let detailwhats = saveObject.object(forKey: "whatText") as! String
                    
                    self.detailWho.text = detailwhos
                    self.detailWhat.text = detailwhats
                    
                }
            }
        })
        
        
    }
    
    @IBAction func detailDelete() {
 let alert: UIAlertController = UIAlertController(title: "Delete", message: "削除してもよろしいですか？", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
        
        let query = NCMBQuery(className: "Save")
            query?.getObjectInBackground(withId: self.objectId, block: { (save, error) in
            if error != nil {
                print(error)
            } else {
                save?.deleteInBackground({ (error) in
                    if error != nil {
                        HUD.show(.error)
                        print(error)
                    } else {
                        print("成功")
                        PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Success", subtitle: "Delete complete")
                        PKHUD.sharedHUD.show(onView: self.view)
                        PKHUD.sharedHUD.hide(afterDelay: 2.0) { _ in
                              self.navigationController?.popViewController(animated: true)
                        }
                    }
                })
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
