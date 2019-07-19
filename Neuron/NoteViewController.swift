//
//  NoteViewController.swift
//  Neuron
//
//  Created by Anar on 18/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    
    
    let userDefaults = UserDefaults.standard
    var notesCount = UserDefaults.standard.integer(forKey: "notesCount")
    
    
    
    
    @IBAction func doneButton(_ sender: UIButton) {
        guard noteTitle.text != "" else {
            showAlert(for: "Title")
            return
        }
        guard noteText.text != "" else {
            showAlert(for: "Text")
            return
        }
        
        /// Сохранение данных в CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as! Note
        
        /// Получаем текущую дату
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.EEEE.MMM.yyyy"
        let result = formatter.string(from: date)
        
        /// Присваивание значения атрибутам
        object.date = result
        object.symbolsAmount = Int32(noteText.text.count)
        object.text = noteText.text
        object.title = noteTitle.text
        print("asdasdad")
        
        
        /// Сохранение контекста
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        /// Увеличиваем количество записей и возвращаемся обратно в HomeViewController
        self.userDefaults.set(notesCount + 1, forKey: "notesCount")
        performSegue(withIdentifier: "unwindSeque", sender: nil)
    }
    
    
    
    
    func showAlert(for emptyElement: String) {
        let ac = UIAlertController(title: "Error", message: "\(emptyElement) cannot be empty", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "lol"
    }
}

