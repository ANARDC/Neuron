//
//  AllNotesTableViewController.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class AllNotesTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    // MARK: - Class Properties
    var notes = CoreDataProcesses.notesFromCoreData
    var notesCount = 0
    
    var selectedNoteTitle = ""
    var selectedNoteText = ""
    var noteTextUserInteractionStatus = false
    var noteTitleUserInteractionStatus = false
    var noteDoneButtonHiddenStatus = true
}

// MARK: - AllNotesTableViewController Life Cycle

extension AllNotesTableViewController {
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        notesCount = UserDefaults.standard.integer(forKey: "notesCount")
        self.tabBarController?.tabBar.isHidden = true
        navBarSettung()
        
        self.tableView.separatorColor = .clear
    }
}

// MARK: - Table View Functions

extension AllNotesTableViewController {
    
    // MARK: - Number Of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // MARK: - Number Of Rows In Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notesCount - 1
    }
    
    // MARK: - Cell For Row At
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        let index = notes.count - indexPath.row - 1
        cell.noteTitle.text = notes[index].title
        cell.noteText.text = notes[index].text
        cell.dateInt.text = notes[index].date?.components(separatedBy: ".")[0]
        cell.dateString.text = notes[index].date?.components(separatedBy: ".")[1]
        
//        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        
        cell.mainView.shadowColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        cell.mainView.shadowOpacity = 1
        cell.mainView.shadowRadius = 14
        cell.mainView.shadowOffset = CGSize(width: 0, height: 11)
        
        return cell
    }
    
    // MARK: - Did Select Item At
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NoteTableViewCell
        selectedNoteTitle = cell.noteTitle.text!
        selectedNoteText = cell.noteText.text!
        noteTextUserInteractionStatus = false
        noteTitleUserInteractionStatus = false
        noteDoneButtonHiddenStatus = true
        performSegue(withIdentifier: "showNoteFromAllNotes", sender: nil)
    }
    
    // MARK: - Prepare for segue
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

// MARK: - Customize Functions

extension AllNotesTableViewController {
    func navBarSettung() {
        BarDesign().addCustomizedBackButton(navigationController: self.navigationController, navigationItem: self.navigationItem)
        calendarButton.image = UIImage(named: "Иконка календаря")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        sortButton.image = UIImage(named: "Сортировка")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Назад")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
