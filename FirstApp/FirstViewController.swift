//
//  FirstViewController.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit
import NCMB

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var selectedSave: Save!
    var saves = [Save]()
    
    
    @IBOutlet var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        //  collectionView.backgroundColor =
        // レイアウト設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        

        
        collectionView.collectionViewLayout = layout
        

        //グラデーションの開始色
        let topColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        //グラデーションの開始色
        let bottomColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)

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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
         
        cell.tag = indexPath.item
        let whoLabel = saves[indexPath.item].who
        cell.whoLabel.text = whoLabel
        
        
//        cell.backgroundColor = .red   セルの色
        
        cell.backgroundColor = UIColor(displayP3Red: 0/255, green: 172/255, blue: 254/255,alpha: 1.0);
        return cell
    }

    
    func loadData() {
        let query = NCMBQuery(className: "Save")
        query?.includeKey("user")
        query?.whereKey("user", equalTo: NCMBUser.current())
        query?.order(byDescending: "createDate")
        
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
            print(error)
            } else {
                self.saves = [Save]()
                for saveObject in result as! [NCMBObject] {
                    
                    let whos = saveObject.object(forKey: "whoText") as! String
                    let whats = saveObject.object(forKey: "whatText") as! String
                    
                    let save = Save(objectId: saveObject.objectId, who: whos, what: whats, createDate: saveObject.createDate)
                      
                    self.saves.append(save)
                    }
                self.collectionView.reloadData()
            }
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSave = saves[indexPath.item]
        performSegue(withIdentifier: "toDetail", sender: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let detailView = segue.destination as! DetailViewController
            let selectedIndexPath = collectionView.indexPathsForSelectedItems
            detailView.objectId = selectedSave.objectId
        }
        
    
    
}

}
