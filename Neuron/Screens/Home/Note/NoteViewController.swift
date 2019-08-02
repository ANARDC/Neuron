//
//  NoteViewController.swift
//  Neuron
//
//  Created by Anar on 18/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

final class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    
    var noteTitleText = ""
    var noteTextText = ""
    var noteTextUserInteractionStatus = true
    var noteTitleUserInteractionStatus = true
    var doneButtonHiddenStatus = false
    
    
    
    let userDefaults = UserDefaults.standard
    var notesCount = UserDefaults.standard.integer(forKey: "notesCount")
    
    
    
    
    @IBAction func doneButton(_ sender: UIButton) {
        guard noteTitle.text != "" else {
            showAlert(for: "Title")
            return
        }
        guard noteText.text != "" && noteText.text != "Enter something..." else {
            showAlert(for: "Text")
            return
        }
        
        // Сохранение данных в CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as! Note
        
        // Получаем текущую дату
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.EEEE.MMM.yyyy"
        let result = formatter.string(from: date)
        
        // Присваивание значения атрибутам
        object.date = result
        object.symbolsAmount = Int32(noteText.text.count)
        object.text = noteText.text
        object.title = noteTitle.text
        
        
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
    
    
    func noteTextViewSetting() {
        noteText.delegate = self
        noteText.text = "Enter something..."
        noteText.backgroundColor?.withAlphaComponent(0)
        noteText.textColor = .lightGray
    }
    
    func showAlert(for emptyElement: String) {
        let ac = UIAlertController(title: "Error", message: "\(emptyElement) cannot be empty", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextViewSetting()
        navigationItem.title = "Note"
        self.tabBarController?.tabBar.isHidden = true
        BarDesign().addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Назад")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        noteTitle.text = noteTitleText
        noteText.text = noteTextText
        noteTitle.isUserInteractionEnabled = noteTitleUserInteractionStatus
        noteText.isUserInteractionEnabled = noteTextUserInteractionStatus
        doneButton.isHidden = doneButtonHiddenStatus
        doneButton.isEnabled = doneButtonHiddenStatus
    }
}

// MARK: - Placeholder Realization
extension NoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Enter something..." && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Enter something..."
            textView.textColor = .lightGray
        }
    }
}



