//
//  NoteViewController.swift
//  Neuron
//
//  Created by Anar on 18/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class NoteViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Class Properties
    var noteTitleText = ""
    var noteTextText = "Enter something..."
    var noteTextUserInteractionStatus = true
    var noteTitleUserInteractionStatus = true
    var doneButtonHiddenStatus = false
}

// MARK: - Done Button IBAction

extension NoteViewController {
    @IBAction func doneButton(_ sender: UIButton) {
        guard noteTitle.text != "" else {
            showAlert(for: "Title")
            return
        }
        guard noteText.text != "" && noteText.text != "Enter something..." else {
            showAlert(for: "Text")
            return
        }
        
        CoreDataProcesses.saveNoteToCoreData(text: noteText.text, title: noteTitle.text!)
        
        performSegue(withIdentifier: "unwindSeque", sender: nil)
    }
    
    func showAlert(for emptyElement: String) {
        let ac = UIAlertController(title: "Error", message: "\(emptyElement) cannot be empty", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }
}

// MARK: - Customize Functions

extension NoteViewController {
    func noteTextViewSetting() {
        noteText.delegate = self
        noteText.backgroundColor?.withAlphaComponent(0)
        noteText.textColor = .lightGray
    }
    
    func fieldsFilling() {
        noteTitle.text = noteTitleText
        noteText.text = noteTextText
        noteTitle.isUserInteractionEnabled = noteTitleUserInteractionStatus
        noteText.isUserInteractionEnabled = noteTextUserInteractionStatus
        doneButton.isHidden = doneButtonHiddenStatus
        doneButton.isEnabled = !doneButtonHiddenStatus
    }
    
    func navBarSetting() {
        navigationItem.title = "Note"
        self.tabBarController?.tabBar.isHidden = true
        BarDesign().addCustomizedBackButton(navigationController: self.navigationController, navigationItem: self.navigationItem)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Назад")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - NoteViewController Life Cycle

extension NoteViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextViewSetting()
        navBarSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fieldsFilling()
    }
}


// MARK: - Placeholder Realization

extension NoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Enter something..." && textView.textColor == .lightGray) {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = "Enter something..."
            textView.textColor = .lightGray
        }
    }
}
