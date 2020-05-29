//
//  ViewController.swift
//  Neuron
//
//  Created by Anar on 16/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
  @IBOutlet weak var diaryCollectionView  : UICollectionView!
  @IBOutlet weak var lastExCollectionView : UICollectionView!
  @IBOutlet weak var allExCollectionView  : UICollectionView!
  @IBOutlet weak var showAllNotes         : UIButton!
  @IBOutlet weak var diaryCVHeight        : NSLayoutConstraint!
  
  var addNoteCell: DiaryCollectionViewCell? = nil
  let userDefaults                          = UserDefaults.standard
  var notesCount                            = 1
  var viewColor                             = UIColor.white
  var notes                                 = [Note]()
  
  var selectedNoteTitle              = ""
  var selectedNoteText               = ""
  var noteTextUserInteractionStatus  = false
  var noteTitleUserInteractionStatus = false
  var noteDoneButtonHiddenStatus     = true
}

// MARK: - Life Cycle
extension HomeViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if self.userDefaults.integer(forKey: "notesCount") == 0 { self.userDefaults.set(1, forKey: "notesCount") }
    else { notesCount = self.userDefaults.integer(forKey: "notesCount") }
    
    self.diaryCollectionViewing()
    self.showAllNotesViewing()
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
    BarDesign().makeNavigationBarTranslucent(self.navigationController)
    self.collectionViewsSetting()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func viewDidLayoutSubviews() {
    lastExCollectionView.scrollToItem(at: IndexPath(row: 14, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
  }
}

// MARK: - IBActions
extension HomeViewController {
  @IBAction func addNoteCell(_ sender: UIButton) {
    self.selectedNoteTitle              = ""
    self.selectedNoteText               = "Enter something..."
    self.noteTextUserInteractionStatus  = true
    self.noteTitleUserInteractionStatus = true
    self.noteDoneButtonHiddenStatus     = false
    self.performSegue(withIdentifier: "showNoteFromHome", sender: nil)
  }
}

// MARK: - Segue Processes
extension HomeViewController {
  @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
    self.tabBarController?.tabBar.isHidden = false
    
    self.notes = DataService.notesFromCoreData
    
    self.diaryCollectionView?.reloadData()
    switch self.userDefaults.integer(forKey: "notesCount") {
      case ..<5:
        self.diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (self.userDefaults.integer(forKey: "notesCount") - 1))
      default:
        self.diaryCVHeight.constant = 390
    }
    
    showAllNotesViewing()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showNoteFromHome" {
      if let dvc = segue.destination as? NoteViewController {
        dvc.noteTitleText                  = self.selectedNoteTitle
        dvc.noteTextText                   = self.selectedNoteText
        dvc.noteTextUserInteractionStatus  = self.noteTextUserInteractionStatus
        dvc.noteTitleUserInteractionStatus = self.noteTitleUserInteractionStatus
        dvc.doneButtonHiddenStatus         = self.noteDoneButtonHiddenStatus
      }
    }
  }
}

// MARK: - UI Making
extension HomeViewController {
  func showAllNotesViewing() {
    // Создаем minimumFontScale для кнопки showAllNotes как у UILabel
    self.showAllNotes.titleLabel?.minimumScaleFactor = 0.65
    self.showAllNotes.titleLabel?.numberOfLines = 1
    self.showAllNotes.titleLabel?.adjustsFontSizeToFitWidth = true
    self.showAllNotes.borderColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
    // Настраиваем текст showAllNotes
    self.showAllNotes.setTitle("  Show All (\(self.userDefaults.integer(forKey: "notesCount") - 1))  ", for: .normal)
    // Настраиваем отображение showAllNotes
    self.showAllNotes.isHidden = self.userDefaults.integer(forKey: "notesCount") < 5 ? true : false
  }
  
  func diaryCollectionViewing() {
    if let flowLayout = diaryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      let width = UIScreen.main.bounds.width - 20
      flowLayout.itemSize = CGSize(width: width, height: 90)
    }
    self.diaryCollectionViewHeightVieweing()
  }
  
  func diaryCollectionViewHeightVieweing() {
    switch self.userDefaults.integer(forKey: "notesCount") {
      case ..<5:
        self.diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (self.userDefaults.integer(forKey: "notesCount") - 1))
      default:
        self.diaryCVHeight.constant = 390
    }
  }
}

// MARK: - UICollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if self.userDefaults.integer(forKey: "notesCount") == 0 { self.userDefaults.set(1, forKey: "notesCount") }
    else { notesCount = self.userDefaults.integer(forKey: "notesCount") }
    
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
      case diaryCollectionView:
        switch indexPath.row {
          case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNoteCell", for: indexPath) as! DiaryCollectionViewCell
            addNoteCell = cell
            return cell
          default:
            notes = DataService.notesFromCoreData
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Note", for: indexPath) as! DiaryCollectionViewCell
            let index = notes.count - indexPath.row
            cell.title.text = notes[index].title
            cell.text.text = notes[index].text
            cell.dateInt.text = notes[index].date?.components(separatedBy: ".")[0]
            cell.dateString.text = notes[index].date?.components(separatedBy: ".")[1]
            return cell
      }
      case lastExCollectionView:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastExercise", for: indexPath) as UICollectionViewCell
        return cell
      default:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Exercise", for: indexPath) as UICollectionViewCell
        return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
      case diaryCollectionView:
        let cell = collectionView.cellForItem(at: indexPath) as! DiaryCollectionViewCell
        self.selectedNoteTitle              = cell.title.text!
        self.selectedNoteText               = cell.text.text!
        self.noteTextUserInteractionStatus  = false
        self.noteTitleUserInteractionStatus = false
        self.noteDoneButtonHiddenStatus     = true
        performSegue(withIdentifier: "showNoteFromHome", sender: nil)
      case lastExCollectionView:
        return
      default:
        switch indexPath.row {
          case 0: self.performSegue(withIdentifier: "showFruitsGame", sender: nil)
          case 1: self.performSegue(withIdentifier: "showSchulteTableGame", sender: nil)
          case 2: self.performSegue(withIdentifier: "showLacesGame", sender: nil)
          default: return
      }
    }
  }
  
  func collectionViewsSetting() {
    [diaryCollectionView, lastExCollectionView, allExCollectionView].forEach { (collectionView) in
      guard let collectionView = collectionView else { return }
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }
}
