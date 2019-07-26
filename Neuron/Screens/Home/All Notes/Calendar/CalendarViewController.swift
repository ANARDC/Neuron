//
//  CalendarViewController.swift
//  Neuron
//
//  Created by Anar on 23/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData


final class CalendarViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var dayNoteView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //     MARK: - Class Properties
    let currentMonthInfo = NoteCalendar().getDateInfo(of: .current)
    var daysList = [String]()
    var daysListStatus = [String]()
    
    // MARK: - IBActions
    @IBAction func previousMonth(_ sender: UIButton) {
        fillingDaysList(of: .previous)
        calendarCollectionView.reloadData()
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        fillingDaysList(of: .next)
        calendarCollectionView.reloadData()
    }
    
    // MARK: - CalendarViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewViewing(calendarView)
        viewViewing(dayNoteView)
        fillingDaysList(of: .current)
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
        cellDayButtonViewing(cell, indexPath.row)
        return cell
    }
}

// MARK: - Functions Customize The Appearance Of The Elements
extension CalendarViewController {
    func viewViewing(_ element: UIView) {
        element.layer.cornerRadius = 5
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        
        element.shadowColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        element.shadowOpacity = 1
        element.shadowRadius = 14
        element.shadowOffset = CGSize(width: 0, height: 11)
    }
    
    func cellDayButtonViewing(_ cell: CalendarCollectionViewCell, _ index: Int) {
        cell.dayButton.cornerRadius = 15
        cell.dayButton.layer.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1).cgColor
        
        cell.dayButton.shadowColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
        cell.dayButton.shadowOpacity = 1
        cell.dayButton.shadowRadius = 5
        cell.dayButton.shadowOffset = CGSize(width: 0, height: 0.5)
        
        
        cell.dayButton.setTitle(daysList[index], for: .normal)
        
        switch daysListStatus[index] {
        case "Current":
            cell.dayButton.setTitleColor(UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9), for: .normal)
        default:
            cell.dayButton.setTitleColor(UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.4), for: .normal)
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
            
            calendarView.addSubview(view)
        default:
            return
        }
    }
}

// MARK: - Filling daysList
extension CalendarViewController {
    func fillingDaysList(of position: NoteCalendar.position) {
        let month = NoteCalendar().getDateInfo(of: position)
        
        
        dateLabel.text = "\(month.month) \(month.year)"
        
        daysList.removeAll()
        daysListStatus.removeAll()
        
        let firstDayNumberInWeek = ("\(month.year)-\(month.month)-\(1)".date?.firstDayOfTheMonth.weekday)!
        
        // Filling first part
        if firstDayNumberInWeek != 0 {
            let previousMonthInfo = NoteCalendar().getDateInfo(of: .previous)
            for i in 1...firstDayNumberInWeek {
                daysList.append(String(previousMonthInfo.daysCount - (firstDayNumberInWeek - i)))
                daysListStatus.append("NotCurrent")
            }
            NoteCalendar.offset += 1
        }
        
        // Filling second part
        for i in 1...month.daysCount {
            daysList.append(String(i))
            daysListStatus.append("Current")
        }
        
        // Filling third part
        for i in 0...6 - (firstDayNumberInWeek + month.daysCount) % 7 {
            daysList.append(String(i + 1))
            daysListStatus.append("NotCurrent")
        }
    }
}

