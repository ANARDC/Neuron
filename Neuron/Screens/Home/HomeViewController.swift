//
//  ViewController.swift
//  Neuron
//
//  Created by Anar on 16/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData
import Hero

final class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var diaryCollectionView: UICollectionView!
    @IBOutlet weak var lastExCollectionView: UICollectionView!
    @IBOutlet weak var allExCollectionView: UICollectionView!
    @IBOutlet weak var showAllNotes: UIButton!
    @IBOutlet weak var diaryCVHeight: NSLayoutConstraint!
    
    // MARK: - Class Properties
    var addNoteCell: DiaryCollectionViewCell? = nil
    let userDefaults = UserDefaults.standard
    var notesCount = 1
    var viewColor = UIColor.white
    var notes = [Note]()
    
    
    // MARK: - IBActions
    @IBAction func addNoteCell(_ sender: UIButton) {
    }
    
    // MARK: - Unwind Segue
    @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
        self.tabBarController?.tabBar.isHidden = false
        
        gettingNotesFromCoreData()
        
        diaryCollectionView?.reloadData()
        switch userDefaults.integer(forKey: "notesCount") {
        case ..<5:
            diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (userDefaults.integer(forKey: "notesCount") - 1))
        default:
            diaryCVHeight.constant = 390
        }
        
        showAllNotesViewing()
    }
    
    // MARK: - UICollectionView functions
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
    
    // MARK: - Getting data from CoreData functions
    func gettingNotesFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Viewing Functions
    func showAllNotesViewing() {
        // Создаем minimumFontScale для кнопки showAllNotes как у UILabel
        showAllNotes.titleLabel?.minimumScaleFactor = 0.65
        showAllNotes.titleLabel?.numberOfLines = 1
        showAllNotes.titleLabel?.adjustsFontSizeToFitWidth = true
        showAllNotes.borderColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
        // Настраиваем текст showAllNotes
        showAllNotes.setTitle("  Show All (\(userDefaults.integer(forKey: "notesCount") - 1))  ", for: .normal)
        // Настраиваем отображение showAllNotes
        showAllNotes.isHidden = userDefaults.integer(forKey: "notesCount") < 5 ? true : false
    }
    
    func diaryCollectionViewHeightVieweing() {
        switch userDefaults.integer(forKey: "notesCount") {
        case ..<5:
            diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (userDefaults.integer(forKey: "notesCount") - 1))
        default:
            diaryCVHeight.constant = 390
        }
    }
    
    func diaryCollectionViewing() {
        if let flowLayout = diaryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.width - 20
            flowLayout.itemSize = CGSize(width: width, height: 90)
        }
        diaryCollectionViewHeightVieweing()
    }
    
    // FIXME: - Переделай тут с UserDefaults на CoreData/
    // Вытащи мелкие вещи в отдельные функции (одна вещь - одна функция)
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.integer(forKey: "notesCount") == 0 { userDefaults.set(1, forKey: "notesCount") }
        else { notesCount = userDefaults.integer(forKey: "notesCount") }
        diaryCollectionViewing()
        showAllNotesViewing()
        self.tabBarController?.tabBar.isHidden = false
        
        BarDesign().makeNavigationBarTranslucent(navigationController: self.navigationController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        lastExCollectionView.scrollToItem(at: IndexPath(row: 14, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
    }
}
