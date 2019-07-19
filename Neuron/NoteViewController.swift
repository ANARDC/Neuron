//
//  NoteViewController.swift
//  Neuron
//
//  Created by Anar on 18/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    @IBAction func doneButton(_ sender: UIButton) {
        self.userDefaults.set(notesCount + 1, forKey: "notesCount")
        performSegue(withIdentifier: "unwindSeque", sender: nil)
    }
    
    let userDefaults = UserDefaults.standard
    var notesCount = UserDefaults.standard.integer(forKey: "notesCount")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "lol"
    }
}

