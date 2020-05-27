//
//  ViewController.swift
//  Neuron
//
//  Created by Anar on 16/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
  
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
  
  var selectedNoteTitle = ""
  var selectedNoteText = ""
  var noteTextUserInteractionStatus = false
  var noteTitleUserInteractionStatus = false
  var noteDoneButtonHiddenStatus = true
}


// MARK: - IBActions
extension HomeViewController {
  // MARK: - Add Note Cell
  @IBAction func addNoteCell(_ sender: UIButton) {
    selectedNoteTitle = ""
    selectedNoteText = "Enter something..."
    noteTextUserInteractionStatus = true
    noteTitleUserInteractionStatus = true
    noteDoneButtonHiddenStatus = false
    performSegue(withIdentifier: "showNoteFromHome", sender: nil)
  }
}


// MARK: - Segue Processes

extension HomeViewController {
  
  // MARK: - Unwind Segue
  @IBAction func unwindToHome(_ sender: UIStoryboardSegue) {
    self.tabBarController?.tabBar.isHidden = false
    
    notes = DataService.notesFromCoreData
    
    diaryCollectionView?.reloadData()
    switch userDefaults.integer(forKey: "notesCount") {
    case ..<5:
      diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (userDefaults.integer(forKey: "notesCount") - 1))
    default:
      diaryCVHeight.constant = 390
    }
    
    showAllNotesViewing()
  }
  
  // MARK: - Prepare for segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showNoteFromHome" {
      if let dvc = segue.destination as? NoteViewController {
        dvc.noteTitleText = selectedNoteTitle
        dvc.noteTextText = selectedNoteText
        dvc.noteTextUserInteractionStatus = noteTextUserInteractionStatus
        dvc.noteTitleUserInteractionStatus = noteTitleUserInteractionStatus
        dvc.doneButtonHiddenStatus = noteDoneButtonHiddenStatus
      }
    }
  }
}

// MARK: - Home View Controller Life Cycle

extension HomeViewController {
  
  // FIXME: - Переделай тут с UserDefaults на CoreData
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if userDefaults.integer(forKey: "notesCount") == 0 { userDefaults.set(1, forKey: "notesCount") }
    else { notesCount = userDefaults.integer(forKey: "notesCount") }
    
    
    
    
    
    diaryCollectionViewing()
    showAllNotesViewing()
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
    BarDesign().makeNavigationBarTranslucent(self.navigationController)
    collectionViewsSetting()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.tabBarController?.tabBar.isHidden = false
  }
  
  override func viewDidLayoutSubviews() {
    lastExCollectionView.scrollToItem(at: IndexPath(row: 14, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
  }
}

// MARK: - UICollectionView functions

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  // MARK: - Number Of Items In Section
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
  
  // MARK: - Cell For Item At
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
  
  // MARK: - Did Select Item At
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch collectionView {
    case diaryCollectionView:
      let cell = collectionView.cellForItem(at: indexPath) as! DiaryCollectionViewCell
      selectedNoteTitle = cell.title.text!
      selectedNoteText = cell.text.text!
      noteTextUserInteractionStatus = false
      noteTitleUserInteractionStatus = false
      noteDoneButtonHiddenStatus = true
      performSegue(withIdentifier: "showNoteFromHome", sender: nil)
    case lastExCollectionView:
      return
    default:
      switch indexPath.row {
      case 0: performSegue(withIdentifier: "showFruitsGame", sender: nil)
      case 1: performSegue(withIdentifier: "showSchulteTableGame", sender: nil)
      case 2: performSegue(withIdentifier: "showLacesGame", sender: nil)
      default: return
      }
    }
  }
  
  // MARK: - Assigning delegate and dataSource
  func collectionViewsSetting() {
    [diaryCollectionView, lastExCollectionView, allExCollectionView].forEach { (collectionView) in
      collectionView!.dataSource = self
      collectionView!.delegate = self
    }
  }
}

// MARK: - Viewing Functions

extension HomeViewController {
  
  // MARK: - Show All Notes Viewing
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
  
  // MARK: - Diary Collection View Height Vieweing
  func diaryCollectionViewHeightVieweing() {
    switch userDefaults.integer(forKey: "notesCount") {
    case ..<5:
      diaryCVHeight.constant = CGFloat(90 + (10 + 90) * (userDefaults.integer(forKey: "notesCount") - 1))
    default:
      diaryCVHeight.constant = 390
    }
  }
  
  // MARK: - Diary Collection Viewing
  func diaryCollectionViewing() {
    if let flowLayout = diaryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      let width = UIScreen.main.bounds.width - 20
      flowLayout.itemSize = CGSize(width: width, height: 90)
    }
    diaryCollectionViewHeightVieweing()
  }
}
