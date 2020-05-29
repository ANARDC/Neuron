//
//  AllNotesTableViewController.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class AllNotesTableViewController: UITableViewController {
  @IBOutlet weak var calendarButton : UIBarButtonItem!
  @IBOutlet weak var sortButton     : UIBarButtonItem!

  var notes      = DataService.notesFromCoreData
  var notesCount = 0

  var selectedNoteTitle              = ""
  var selectedNoteText               = ""
  var noteTextUserInteractionStatus  = false
  var noteTitleUserInteractionStatus = false
  var noteDoneButtonHiddenStatus     = true
}

// MARK: - Life Cycle
extension AllNotesTableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.notesCount = UserDefaults.standard.integer(forKey: "notesCount")
    self.tabBarController?.tabBar.isHidden = true
    self.navBarSetting()
    self.tableView.separatorColor = .clear
  }
}

// MARK: - UITableView
extension AllNotesTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.notesCount - 1
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
    let index = self.notes.count - indexPath.row - 1
    cell.noteTitle.text  = self.notes[index].title
    cell.noteText.text   = self.notes[index].text
    cell.dateInt.text    = self.notes[index].date?.components(separatedBy: ".")[0]
    cell.dateString.text = self.notes[index].date?.components(separatedBy: ".")[1]

    cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)

    cell.mainView.shadowColor   = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    cell.mainView.shadowOpacity = 1
    cell.mainView.shadowRadius  = 14
    cell.mainView.shadowOffset  = CGSize(width: 0, height: 11)

    cell.selectionStyle = .none

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! NoteTableViewCell
    self.selectedNoteTitle              = cell.noteTitle.text!
    self.selectedNoteText               = cell.noteText.text!
    self.noteTextUserInteractionStatus  = false
    self.noteTitleUserInteractionStatus = false
    self.noteDoneButtonHiddenStatus     = true
    self.performSegue(withIdentifier: "showNoteFromAllNotes", sender: nil)
  }
}

// MARK: - Navigation
extension AllNotesTableViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let dvc = segue.destination as? NoteViewController {
      dvc.noteTitleText                  = self.selectedNoteTitle
      dvc.noteTextText                   = self.selectedNoteText
      dvc.noteTextUserInteractionStatus  = self.noteTextUserInteractionStatus
      dvc.noteTitleUserInteractionStatus = self.noteTitleUserInteractionStatus
      dvc.doneButtonHiddenStatus         = self.noteDoneButtonHiddenStatus
    }
  }
}

// MARK: - UI Making
extension AllNotesTableViewController {
  func navBarSetting() {
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
    self.calendarButton.image = UIImage(named: "Иконка календаря")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    self.sortButton.image     = UIImage(named: "Сортировка")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
  }
}
