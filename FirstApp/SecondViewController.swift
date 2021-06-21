//
//  SecondViewController.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit
import NCMB
import PKHUD


class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedSave: SaveTwo!
        var saves = [SaveTwo]()
        
        
        @IBOutlet var collectionView: UICollectionView!
        

        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.dataSource = self
            collectionView.delegate = self
            
            let nib = UINib(nibName: "TwoCollectionViewCell", bundle: Bundle.main)
            collectionView.register(nib, forCellWithReuseIdentifier: "Cell")
            
             
            
            // レイアウト設定
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 120, height: 120)
            
    //        layout.minimumInteritemSpacing =
            
            collectionView.collectionViewLayout = layout
            
    //         collectionViewFlowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 3)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            loadData()
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return saves.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TwoCollectionViewCell
             
            cell.tag = indexPath.item
            let whoLabel = saves[indexPath.item].who
            cell.whoLabel.text = whoLabel
            
            cell.backgroundColor = UIColor(displayP3Red: 79/255, green: 242/255, blue: 254/255,alpha: 1.0)
            
            return cell
        }

        
        func loadData() {
            let query = NCMBQuery(className: "SaveTwo")
            query?.includeKey("user")
            query?.whereKey("user", equalTo: NCMBUser.current())
            query?.order(byDescending: "createDate")
            
            query?.findObjectsInBackground({ (result, error) in
                if error != nil {
                print(error)
                } else {
                    self.saves = [SaveTwo]()
                    for saveObject in result as! [NCMBObject] {
                        
                        let whos = saveObject.object(forKey: "whoText") as! String
                        let whats = saveObject.object(forKey: "whatText") as! String
                        
                        let save = SaveTwo(objectId: saveObject.objectId, who: whos, what: whats, createDate: saveObject.createDate)
                          
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
                let detailView = segue.destination as! Detail2ViewController
                let selectedIndexPath = collectionView.indexPathsForSelectedItems
                detailView.objectId = selectedSave.objectId
            }
            
        
        
    }
   

   
}
