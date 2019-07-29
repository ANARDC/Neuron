//
//  CalendarViewController.swift
//  Neuron
//
//  Created by Anar on 23/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

// MARK: - CalendarViewController

final class CalendarViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayNoteView: UIView!
    @IBOutlet weak var dayNoteTitle: UILabel!
    @IBOutlet weak var dayNoteText: UILabel!
    
    //     MARK: - Class Properties
    let currentMonthInfo = NoteCalendar().getDateInfo(of: .current)
    var daysList = [String]()
    var daysListStatus = [String]()
    var daysDatesList = [String]()
    
    // MARK: - IBActions
    @IBAction func previousMonth(_ sender: UIButton) {
        dayNoteTitle.text = "Empty"
        dayNoteText.text! = "You didn't fill in the diary on this day"
        fillingDaysList(of: .previous)
        calendarCollectionView.reloadData()
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        dayNoteTitle.text = "Empty"
        dayNoteText.text! = "You didn't fill in the diary on this day"
        fillingDaysList(of: .next)
        calendarCollectionView.reloadData()
    }
    
    // MARK: - CalendarViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewViewing(calendarView)
        viewViewing(dayNoteView)
        fillingDaysList(of: .current)
        collectionViewSetting()
    }
}

// MARK: - CollectionView Functions

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! CalendarCollectionViewCell
        fillingDaysOfTheWeek(indexPath)
        cellDayViewViewing(cell, indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
        if cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.6) || cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1) {
            UIView.animate(withDuration: 0.5) {
                cell.dayView.borderColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
                cell.dayView.borderWidth = 2
                cell.dayView.shadowOpacity = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                cell.dayView.borderColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
                cell.dayView.borderWidth = 2
            }
        }
        
        let notes = CoreDataProcesses.notesFromCoreData
        for note in notes {
            let day = note.date!.components(separatedBy: ".")[0]
            let month = note.date!.components(separatedBy: ".")[2].prefix(3)
            let year = note.date!.components(separatedBy: ".")[3]
            if "\(day).\(month).\(year)" == daysDatesList[indexPath.row] {
                dayNoteTitle.text = note.title!
                dayNoteText.text! = note.text!
                break
            } else {
                dayNoteTitle.text = "Empty"
                dayNoteText.text! = "You didn't fill in the diary on this day"
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
        
        if cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.6) || cell.dayView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1) {
            UIView.animate(withDuration: 0.8) {
                cell.dayView.borderWidth = 0
                cell.dayView.shadowOpacity = 1
            }
        } else {
            UIView.animate(withDuration: 0.8) {
                cell.dayView.borderWidth = 0
            }
        }
        
    }
    
    func collectionViewSetting() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
    }
}

// MARK: - Customize Functions

extension CalendarViewController {
    
    // MARK: - Appearance Of Some View
    func viewViewing(_ element: UIView) {
        element.layer.cornerRadius = 5
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        
        element.shadowColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        element.shadowOpacity = 1
        element.shadowRadius = 14
        element.shadowOffset = CGSize(width: 0, height: 11)
    }
    
    // MARK: - Day Cell Appearance
    func cellDayViewViewing(_ cell: CalendarCollectionViewCell, _ index: Int) {
        cell.dayView.cornerRadius = 15
        cell.dayView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1)
        
        cell.dayView.borderWidth = 0
        
        cell.dayNumber.text = daysList[index]
        
        switch daysListStatus[index] {
        case "Current":
            if NoteCalendar.offset == 0 && daysList[index] == String(currentMonthInfo.currentDay!) {
                cell.dayView.shadowColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
                cell.dayView.shadowOpacity = 1
                cell.dayView.shadowRadius = 5
                cell.dayView.shadowOffset = CGSize(width: 0, height: 5)
                cell.dayView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
                cell.dayNumber.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cell.dayView.shadowOpacity = 0
                cell.dayNumber.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
            }
        default:
            if (NoteCalendar.offset == -1 || NoteCalendar.offset == 1) && daysDatesList.contains("\(currentMonthInfo.currentDay!).\(currentMonthInfo.month.prefix(3)).\(currentMonthInfo.year)") {
                cell.dayView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.6)
                cell.dayNumber.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
            } else {
                cell.dayNumber.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.4)
            }
        }
    }
    
    // MARK: - Filling Days Of The Week
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
            
            calendarView.addSubview(view)
        default:
            return
        }
    }
}

// MARK: - Filling Data For Calendar
extension CalendarViewController {
    func fillingDaysList(of position: NoteCalendar.position) {
        let month = NoteCalendar().getDateInfo(of: position)
        
        // It's properties for daysDatesList
        let previousMonthIndex = DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1 < 1 ?
            12 - DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1
            :
            DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1
        let previousMonthName = DateFormatter().monthSymbols[previousMonthIndex]
        let previousYear = DateFormatter().monthSymbols.firstIndex(of: month.month)! - 1 < 1 ?
            Int(month.year)! - 1
            :
            Int(month.year)!
        
        let nextMonthIndex = DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1 > 11 ?
            (DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1) % 12
            :
            DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1
        let nextMonthName = DateFormatter().monthSymbols[nextMonthIndex]
        let nextYear = DateFormatter().monthSymbols.firstIndex(of: month.month)! + 1 > 12 ?
            Int(month.year)! + 1
            :
            Int(month.year)!
        
        dateLabel.text = "\(month.month) \(month.year)"
        
        
        daysList.removeAll()
        daysListStatus.removeAll()
        daysDatesList.removeAll()
        
        let firstDayNumberInWeek = ("\(month.year)-\(month.month)-\(1)".date?.firstDayOfTheMonth.weekday)!
        
        // Filling first part
        if firstDayNumberInWeek != 0 {
            let previousMonthInfo = NoteCalendar().getDateInfo(of: .previous)
            for i in 1...firstDayNumberInWeek {
                let day = String(previousMonthInfo.daysCount - (firstDayNumberInWeek - i))
                daysList.append(day)
                daysDatesList.append("\(day).\(previousMonthName.prefix(3)).\(previousYear)")
                daysListStatus.append("NotCurrent")
            }
            NoteCalendar.offset += 1
        }
        
        // Filling second part
        for i in 1...month.daysCount {
            daysList.append(String(i))
            daysDatesList.append("\(i).\(month.month.prefix(3)).\(previousYear)")
            daysListStatus.append("Current")
        }
        
        // Filling third part
        if daysList.count < 35 {
            for i in 0...6 - (firstDayNumberInWeek + month.daysCount) % 7 {
                daysList.append(String(i + 1))
                daysDatesList.append("\(i + 1).\(nextMonthName.prefix(3)).\(nextYear)")
                daysListStatus.append("NotCurrent")
            }
        }
    }
}
