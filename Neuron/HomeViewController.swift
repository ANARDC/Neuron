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
    //    @IBOutlet weak var showAllNotes: UILabel!
    @IBOutlet weak var showAllNotes: UIButton!
    //    @IBAction func showAllNotes(_ sender: UIButton) {
    //    }
    
    let userDefaults = UserDefaults.standard
    var notesCount = 1
    var viewColor = UIColor.white
    
    @IBAction func theme(_ sender: UISwitch) {
        switch viewColor {
        case .white:
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = .lightGray
            }, completion: nil)
            viewColor = .lightGray
        default:
            UIView.animate(withDuration: 0.7, animations: {
                self.view.backgroundColor = .white
            }, completion: nil)
            viewColor = .white
        }
        
    }
    
    @IBAction func addNoteCell(_ sender: UIButton) {
        //        addNoteCell?.addNote
    }
    
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        diaryCollectionView?.reloadData()
        showAllNotesViewing()
    }
    
    var addNoteCell: DiaryCollectionViewCell? = nil
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userDefaults.integer(forKey: "notesCount") == 0 { userDefaults.set(1, forKey: "notesCount") }
        else { notesCount = userDefaults.integer(forKey: "notesCount") }
        switch collectionView {
        case self.diaryCollectionView:
            return self.notesCount
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
    
    
    
    func showAllNotesViewing() {
        /// Создаем minimumFontScale для кнопки showAllNotes как у UILabel
        showAllNotes.titleLabel?.minimumScaleFactor = 0.65
        showAllNotes.titleLabel?.numberOfLines = 1
        showAllNotes.titleLabel?.adjustsFontSizeToFitWidth = true
        /// Настраиваем текст showAllNotes
        showAllNotes.setTitle("  Show All (\(userDefaults.integer(forKey: "notesCount") - 1))  ", for: .normal)
        /// Настраиваем отображение showAllNotes
        showAllNotes.isHidden = userDefaults.integer(forKey: "notesCount") < 5 ? true : false
    }
    
    func diaryCollectionViewing() {
        if let flowLayout = diaryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.width - 20
            flowLayout.itemSize = CGSize(width: width, height: 90)
            //            let height = UIScreen.main.bounds.height
            //            switch UIScreen.main.bounds.height {
            //            case 568: /// iPhone SE
            //            case 667: /// iPhone 6/6 Plus/6s/6s Plus/7/8
            //            case 736: /// iPhone 7 Plus/8 Plus
            //            case 812: /// iPhone X/Xs
            //            default:  /// iPhone Xs Max/Xr
            //            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryCollectionViewing()
        if userDefaults.integer(forKey: "notesCount") == 0 { userDefaults.set(1, forKey: "notesCount") }
        else { notesCount = userDefaults.integer(forKey: "notesCount") }
        showAllNotesViewing()
    }
}
