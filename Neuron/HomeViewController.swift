//
//  ViewController.swift
//  Neuron
//
//  Created by Anar on 16/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var diaryCollectionView: DiaryCollectionView!
    @IBOutlet weak var lastExCollectionView: LastExCollectionView!
    @IBOutlet weak var allExCollectionView: AllExCollectionView!
    
    @IBAction func addNoteCell(_ sender: UIButton) {
//        addNoteCell?.addNote
    }
    
    var diaryCountCells = 1
    
    
    
    var addNoteCell: DiaryCollectionViewCell? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.diaryCollectionView:
            return 5
        case self.lastExCollectionView:
            return 15
        default:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.diaryCollectionView:
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNoteCell", for: indexPath) as! DiaryCollectionViewCell
                addNoteCell = cell
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Note", for: indexPath) as UICollectionViewCell
                return cell
            }
        case self.lastExCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastExercise", for: indexPath) as UICollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Exercise", for: indexPath) as UICollectionViewCell
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = diaryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.width - 20
//            let height = UIScreen.main.bounds.height
//            switch UIScreen.main.bounds.height {
//            case 568: /// iPhone SE
//            case 667: /// iPhone 6/6 Plus/6s/6s Plus/7/8
//            case 736: /// iPhone 7 Plus/8 Plus
//            case 812: /// iPhone X/Xs
//            default:  /// iPhone Xs Max/Xr
//            }
            flowLayout.itemSize = CGSize(width: width, height: 90)
        }
    }
}
