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
        print(notesCount)
//        let tc = UIWindow.
//        let nc = UIWindow?.rootViewController as! UINavigationController
//        let vc = nc.topViewController as! HomeViewController
//        UICollectionView.reloadData(<#T##UICollectionView#>)
//        self.vc?.reloadInputViews()
        
//        self.homeVC?.showAllNotes.text = "---"
//        print(self.homeVC?.showAllNotes.text!)
        performSegue(withIdentifier: "unwindSeque", sender: nil)
    }
    
    
    let userDefaults = UserDefaults.standard
    var notesCount = UserDefaults.standard.integer(forKey: "notesCount")
//    var count = 0
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "unwindSeque" else { return }
//        let destVC = segue.destination as! NoteViewController
//        destVC.viewDidLoad()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "lol"
    }
}

