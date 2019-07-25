//
//  SettingsViewController.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        // Do any additional setup after loading the view.
    }
    
    func onSwitchChanged() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
