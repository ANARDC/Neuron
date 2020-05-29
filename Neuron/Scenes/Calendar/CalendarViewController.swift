//
//  CalendarViewController.swift
//  Neuron
//
//  Created by Anar on 23/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {
  @IBOutlet weak var calendarCollectionView : UICollectionView!
  @IBOutlet weak var calendarView           : UIView!
  @IBOutlet weak var dateLabel              : UILabel!
  @IBOutlet weak var dayNoteView            : UIView!
  @IBOutlet weak var dayNoteTitle           : UILabel!
  @IBOutlet weak var dayNoteText            : UILabel!
  
  let currentMonthInfo   = NoteCalendar().getDateInfo(of: .current)
  var daysList           = [String]()
  var daysListStatus     = [String]()
  var daysDatesList      = [String]()
  let animationsDuration = 0.4
  
  var selectedNoteTitle              = ""
  var selectedNoteText               = ""
  var noteTextUserInteractionStatus  = false
  var noteTitleUserInteractionStatus = false
  var noteDoneButtonHiddenStatus     = true
}

// MARK: - Life Cycle
extension CalendarViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
    self.viewViewing(calendarView)
    self.viewViewing(dayNoteView)
    self.fillingDaysList(of: .current)
    self.collectionViewSetting()
    NoteCalendar.offset = 0
    self.calendarCollectionView.reloadData()
  }
}

// MARK: - UICollectionView
extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionViewSetting() {
    self.calendarCollectionView.dataSource = self
    self.calendarCollectionView.delegate   = self
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 35 }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! CalendarCollectionViewCell
    self.fillingDaysOfTheWeek(indexPath)
    self.cellDayViewViewing(cell, indexPath.row)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
    
    if cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.6) || cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1) {
      let animation0 = CABasicAnimation(keyPath: "borderColor")
      animation0.fromValue = cell.dayView.borderColor
      animation0.toValue = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
      animation0.duration = animationsDuration
      cell.dayView.layer.add(animation0, forKey: animation0.keyPath)
      
      let animation1 = CABasicAnimation(keyPath: "borderWidth")
      animation1.fromValue = cell.dayView.borderWidth
      animation1.toValue = 2
      cell.dayView.layer.add(animation1, forKey: animation1.keyPath)
      
      let animation2 = CABasicAnimation(keyPath: "shadowOpacity")
      animation2.fromValue = cell.dayView.shadowOpacity
      animation2.toValue = 0
      cell.dayView.layer.add(animation2, forKey: animation2.keyPath)
      
      cell.dayView.borderColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
      cell.dayView.borderWidth = 2
      cell.dayView.shadowOpacity = 0
    } else {
      let animation0 = CABasicAnimation(keyPath: "borderColor")
      animation0.fromValue = cell.dayView.borderColor
      animation0.toValue = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
      animation0.duration = animationsDuration
      cell.dayView.layer.add(animation0, forKey: animation0.keyPath)
      
      let animation1 = CABasicAnimation(keyPath: "borderWidth")
      animation1.fromValue = cell.dayView.borderWidth
      animation1.toValue = 2
      cell.dayView.layer.add(animation1, forKey: animation1.keyPath)
      
      cell.dayView.borderColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
      cell.dayView.borderWidth = 2
    }
    
    let notes = DataService.notesFromCoreData
    
    for note in notes {
      let day   = note.date!.components(separatedBy: ".")[0]
      let month = note.date!.components(separatedBy: ".")[2].prefix(3)
      let year  = note.date!.components(separatedBy: ".")[3]
      if "\(day).\(month).\(year)" == daysDatesList[indexPath.row] {
        self.dayNoteTitle.text = note.title!
        self.dayNoteText.text! = note.text!
        break
      } else {
        self.dayNoteTitle.text = "Empty"
        self.dayNoteText.text! = "You didn't fill in the diary on this day"
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
    
    if cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.6) {
      UIView.animate(withDuration: 0.8) {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = cell.dayView.borderWidth
        animation.toValue = 0
        animation.duration = self.animationsDuration
        cell.dayView.layer.add(animation, forKey: animation.keyPath)
        
        cell.dayView.borderWidth = 0
      }
    } else if cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1) {
      UIView.animate(withDuration: 0.8) {
        let animation0 = CABasicAnimation(keyPath: "borderWidth")
        animation0.fromValue = cell.dayView.borderWidth
        animation0.toValue = 0
        animation0.duration = self.animationsDuration
        cell.dayView.layer.add(animation0, forKey: animation0.keyPath)
        
        let animation1 = CABasicAnimation(keyPath: "shadowOpacity")
        animation1.fromValue = cell.dayView.shadowOpacity
        animation1.toValue = 1
        animation1.duration = self.animationsDuration
        cell.dayView.layer.add(animation1, forKey: animation1.keyPath)
        
        cell.dayView.borderWidth = 0
        cell.dayView.shadowOpacity = 1
      }
    } else {
      UIView.animate(withDuration: 0.8) {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = cell.dayView.borderColor
        animation.toValue = 0
        animation.duration = self.animationsDuration
        cell.dayView.layer.add(animation, forKey: animation.keyPath)
        
        cell.dayView.borderWidth = 0
      }
    }
  }
}

// MARK: - IBActions
extension CalendarViewController {
  @IBAction func previousMonth(_ sender: UIButton) {
    self.dayNoteTitle.text = "Empty"
    self.dayNoteText.text! = "You didn't fill in the diary on this day"
    self.fillingDaysList(of: .previous)
    self.calendarCollectionView.reloadData()
  }
  
  @IBAction func nextMonth(_ sender: UIButton) {
    self.dayNoteTitle.text = "Empty"
    self.dayNoteText.text! = "You didn't fill in the diary on this day"
    self.fillingDaysList(of: .next)
    self.calendarCollectionView.reloadData()
  }
  
  @IBAction func noteViewTapped(_ sender: UITapGestureRecognizer) {
    if dayNoteTitle.text! != "Empty" && dayNoteText.text! != "You didn't fill in the diary on this day" {
      self.selectedNoteTitle              = self.dayNoteTitle.text!
      self.selectedNoteText               = self.dayNoteText.text!
      self.noteTextUserInteractionStatus  = false
      self.noteTitleUserInteractionStatus = false
      self.noteDoneButtonHiddenStatus     = true
      self.performSegue(withIdentifier: "showNoteFromCalender", sender: nil)
    }
  }
}

// MARK: - Navigation
extension CalendarViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dvc = segue.destination as? NoteViewController {
      dvc.noteTitleText = selectedNoteTitle
      dvc.noteTextText = selectedNoteText
      dvc.noteTextUserInteractionStatus = noteTextUserInteractionStatus
      dvc.noteTitleUserInteractionStatus = noteTitleUserInteractionStatus
      dvc.doneButtonHiddenStatus = noteDoneButtonHiddenStatus
    }
  }
}

// MARK: - UI Making
extension CalendarViewController {
  func viewViewing(_ element: UIView) {
    element.layer.cornerRadius = 5
    element.layer.borderWidth  = 1
    element.layer.borderColor  = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    
    element.shadowColor   = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    element.shadowOpacity = 1
    element.shadowRadius  = 14
    element.shadowOffset  = CGSize(width: 0, height: 11)
  }
  
  func cellDayViewViewing(_ cell: CalendarCollectionViewCell, _ index: Int) {
    cell.dayView.cornerRadius    = 15
    cell.dayView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1)
    
    cell.dayView.borderWidth   = 0
    cell.dayView.shadowOpacity = 0
    
    cell.dayNumber.text = daysList[index]
    
    switch daysListStatus[index] {
      case "Current":
        if NoteCalendar.offset == 0 && daysList[index] == String(currentMonthInfo.currentDay!) {
          cell.dayView.shadowColor     = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
          cell.dayView.shadowOpacity   = 1
          cell.dayView.shadowRadius    = 5
          cell.dayView.shadowOffset    = CGSize(width: 0, height: 5)
          cell.dayView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
          cell.dayNumber.textColor     = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
          cell.dayView.shadowOpacity = 0
          cell.dayNumber.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
      }
      default:
        if (NoteCalendar.offset == -1 || NoteCalendar.offset == 1) && daysDatesList[index] == "\(currentMonthInfo.currentDay!).\(currentMonthInfo.month.prefix(3)).\(currentMonthInfo.year)" {
          cell.dayView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.6)
          cell.dayNumber.textColor     = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        } else {
          cell.dayNumber.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.4)
      }
    }
  }
  
  func fillingDaysOfTheWeek(_ indexPath: IndexPath) {
    switch indexPath.row {
      case ..<7:
        let dayNames = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
        let itemFrame = calendarCollectionView.layoutAttributesForItem(at: indexPath)?.frame
        let x = (itemFrame?.origin.x)! + (itemFrame?.width)!/4 + 2
        let y = (itemFrame?.origin.y)! + 50
        
        let view = UILabel()
        view.frame = CGRect(x: x, y: y, width: 20, height: 16)
        view.backgroundColor = .white
        
        view.alpha = 0.5
        view.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1)
        view.font = UIFont(name: "NotoSansChakma-Regular", size: 12)
        
        view.textAlignment = .center
        view.text = dayNames[indexPath.row]
        
        self.calendarView.addSubview(view)
      default:
        return
    }
  }
}

// MARK: - Data
extension CalendarViewController {
  func fillingDaysList(of position: NoteCalendar.Position) {
    let month = NoteCalendar().getDateInfo(of: position)
    
    // It's properties for daysDatesList
    let previousMonthIndex = DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1 < 1 ? 12 - DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1 : DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1
    let previousMonthName  = DateFormatter().monthSymbols[previousMonthIndex]
    let previousYear       = DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1 < 1 ? Int(month.year)! - 1 : Int(month.year)!
    
    let nextMonthIndex = DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1 > 11 ? (DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1) % 12 : DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1
    let nextMonthName  = DateFormatter().monthSymbols[nextMonthIndex]
    let nextYear       = DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1 > 12 ? Int(month.year)! + 1 : Int(month.year)!
    
    self.dateLabel.text = "\(month.month) \(month.year)"
    
    self.daysList.removeAll()
    self.daysListStatus.removeAll()
    self.daysDatesList.removeAll()
    
    let firstDayNumberInWeek = ("\(month.year)-\(month.month)-\(1)".date?.firstDayOfTheMonth.weekday)!
    
    // Filling first part
    if firstDayNumberInWeek != 0 {
      let previousMonthInfo = NoteCalendar().getDateInfo(of: .previous)
      for i in 1...firstDayNumberInWeek {
        let day = String(previousMonthInfo.daysCount - (firstDayNumberInWeek - i))
        self.daysList.append(day)
        self.daysDatesList.append("\(day).\(previousMonthName.prefix(3)).\(previousYear)")
        self.daysListStatus.append("NotCurrent")
      }
      NoteCalendar.offset += 1
    }
    
    // Filling second part
    for i in 1...month.daysCount {
      self.daysList.append(String(i))
      self.daysDatesList.append("\(i).\(month.month.prefix(3)).\(previousYear)")
      self.daysListStatus.append("Current")
    }
    
    // Filling third part
    if daysList.count < 35 {
      for i in 0...6 - (firstDayNumberInWeek + month.daysCount) % 7 {
        self.daysList.append(String(i + 1))
        self.daysDatesList.append("\(i + 1).\(nextMonthName.prefix(3)).\(nextYear)")
        self.daysListStatus.append("NotCurrent")
      }
    }
  }
}
