//
//  NoteViewController.swift
//  Neuron
//
//  Created by Anar on 18/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class NoteViewController: UIViewController {
  @IBOutlet weak var noteTitle  : UITextField!
  @IBOutlet weak var noteText   : UITextView!
  @IBOutlet weak var doneButton : UIButton!

  var noteTitleText                  = ""
  var noteTextText                   = "Enter something..."
  var noteTextUserInteractionStatus  = true
  var noteTitleUserInteractionStatus = true
  var doneButtonHiddenStatus         = false
}

// MARK: - Life Cycle
extension NoteViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.noteTextViewSetting()
    self.navBarSetting()
  }

  override func viewWillAppear(_ animated: Bool) {
    fieldsFilling()
  }
}

// MARK: - Done Button IBAction
extension NoteViewController {
  @IBAction func doneButton(_ sender: UIButton) {
    guard self.noteTitle.text != "" else {
      self.showAlert(for: "Title")
      return
    }

    guard noteText.text != "" && noteText.text != "Enter something..." else {
      showAlert(for: "Text")
      return
    }

    DataService.saveNoteToCoreData(text: self.noteText.text, title: self.noteTitle.text!)

    self.performSegue(withIdentifier: "unwindSeque", sender: nil)
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
    self.noteText.delegate = self
    self.noteText.backgroundColor?.withAlphaComponent(0)
    self.noteText.textColor = .lightGray
  }

  func fieldsFilling() {
    self.noteTitle.text                     = self.noteTitleText
    self.noteText.text                      = self.noteTextText
    self.noteTitle.isUserInteractionEnabled = self.noteTitleUserInteractionStatus
    self.noteText.isUserInteractionEnabled  = self.noteTextUserInteractionStatus
    self.doneButton.isHidden                = self.doneButtonHiddenStatus
    self.doneButton.isEnabled               = !self.doneButtonHiddenStatus
  }

  func navBarSetting() {
    self.navigationItem.title              = "Note"
    self.tabBarController?.tabBar.isHidden = true
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

// MARK: - Placeholder Realization
extension NoteViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if (textView.text == "Enter something..." && textView.textColor == .lightGray) {
      textView.text      = ""
      textView.textColor = .black
    }
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if (textView.text == "") {
      textView.text      = "Enter something..."
      textView.textColor = .lightGray
    }
  }
}
