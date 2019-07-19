//
//  ViewController.swift
//  Neuron
//
//  Created by Anar on 16/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var diaryCollectionView: DiaryCollectionView!
    @IBOutlet weak var lastExCollectionView: LastExCollectionView!
    @IBOutlet weak var allExCollectionView: AllExCollectionView!
    @IBOutlet weak var showAllNotes: UIButton!
    @IBOutlet weak var diaryCVHeight: NSLayoutConstraint!
    
    
    
    
    
    // MARK: - Class Properties
    var addNoteCell: DiaryCollectionViewCell? = nil
    let userDefaults = UserDefaults.standard
    var notesCount = 1
    var viewColor = UIColor.white
    var notes = [Note]()
    
    //    @IBAction func theme(_ sender: UISwitch) {
    //        switch viewColor {
    //        case .white:
    //            UIView.animate(withDuration: 0.5, animations: {
    //                self.view.backgroundColor = .lightGray
    //            }, completion: nil)
    //            viewColor = .lightGray
    //        default:
    //            UIView.animate(withDuration: 0.7, animations: {
    //                self.view.backgroundColor = .white
    //            }, completion: nil)
    //            viewColor = .white
    //        }
    //    }
    
    
    
    @IBAction func addNoteCell(_ sender: UIButton) {
    }
    
    // MARK: - Unwind Segue
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        gettingNotesFromCoreData()
        
        diaryCollectionView?.reloadData()
        switch userDefaults.integer(forKey: "notesCount") {
            //        case 1:
        //            diaryCVHeight.constant = 90
        case ..<5:
            diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (userDefaults.integer(forKey: "notesCount") - 1))
        default:
            diaryCVHeight.constant = 390
        }
        
        showAllNotesViewing()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if userDefaults.integer(forKey: "notesCount") == 0 { userDefaults.set(1, forKey: "notesCount") }
        else { notesCount = userDefaults.integer(forKey: "notesCount") }
        
        
        switch collectionView {
        case self.diaryCollectionView:
            return self.notesCount < 5 ? self.notesCount : 4
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
                gettingNotesFromCoreData()
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Note", for: indexPath) as! DiaryCollectionViewCell
                let index = notes.count - indexPath.row
                cell.title.text = notes[index].title
                cell.text.text = notes[index].text
                cell.dateInt.text = notes[index].date?.components(separatedBy: ".")[0]
                cell.dateString.text = notes[index].date?.components(separatedBy: ".")[1]
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
    
    
    func gettingNotesFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        //        print(notes[0].date, "--------------+++++++++++++++++--------------------")
    }
    
    
    
    
    // MARK: - Viewing Functions
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
        print(userDefaults.integer(forKey: "notesCount"))
        switch userDefaults.integer(forKey: "notesCount") {
            //        case 1:
        //            diaryCVHeight.constant = 90
        case ..<5:
            diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (userDefaults.integer(forKey: "notesCount") - 1))
        default:
            diaryCVHeight.constant = 390
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.integer(forKey: "notesCount") == 0 { userDefaults.set(1, forKey: "notesCount") }
        else { notesCount = userDefaults.integer(forKey: "notesCount") }
        diaryCollectionViewing()
        showAllNotesViewing()
    }
}
