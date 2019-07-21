//
//  AllNotesTableViewController.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

class AllNotesTableViewController: UITableViewController {
    
    var notes = [Note]()
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
        gettingNotesFromCoreData()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath) as! NoteTableViewCell
        let index = notes.count - indexPath.row - 1
        cell.noteTitle.text = notes[index].title
        cell.noteText.text = notes[index].text
        cell.dateInt.text = notes[index].date?.components(separatedBy: ".")[0]
        cell.dateString.text = notes[index].date?.components(separatedBy: ".")[1]
        
        return cell
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
    
    
    override func viewDidLoad() {
        gettingNotesFromCoreData()
        notesCount = UserDefaults.standard.integer(forKey: "notesCount")
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
    }
}
