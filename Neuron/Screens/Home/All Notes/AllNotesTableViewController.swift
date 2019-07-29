//
//  AllNotesTableViewController.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

final class AllNotesTableViewController: UITableViewController {
    
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    var notes = CoreDataProcesses.notesFromCoreData
    var notesCount = 0
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return notesCount - 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        let index = notes.count - indexPath.row - 1
        cell.noteTitle.text = notes[index].title
        cell.noteText.text = notes[index].text
        cell.dateInt.text = notes[index].date?.components(separatedBy: ".")[0]
        cell.dateString.text = notes[index].date?.components(separatedBy: ".")[1]
        
        return cell
    }
    
    override func viewDidLoad() {
        notesCount = UserDefaults.standard.integer(forKey: "notesCount")
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        BarDesign().addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        calendarButton.image = UIImage(named: "Иконка календаря")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        sortButton.image = UIImage(named: "Сортировка")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Назад")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
