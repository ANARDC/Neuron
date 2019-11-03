//
//  SchulteTableStartViewController.swift
//  Neuron
//
//  Created by Anar on 02.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

final class SchulteTableStartViewController: UIViewController {
  @IBOutlet weak var statsButton : UIBarButtonItem!
  
  @IBOutlet weak var rulesTitleLabel : UILabel!
  @IBOutlet weak var rulesTextLabel  : UILabel!
  
  @IBOutlet weak var settingBackgroundView   : UIView!
  @IBOutlet weak var mixingShadesOptionTitle : UILabel!
  @IBOutlet weak var mixingShadesSwitch      : PWSwitch!
  @IBOutlet weak var oneOrderLabel           : UILabel!
  @IBOutlet weak var twoOrdersLabel          : UILabel!
  @IBOutlet weak var threeOrdersLabel        : UILabel!
  @IBOutlet weak var settingsCollectionView  : UICollectionView!
  @IBOutlet weak var recordTitleLabel        : UILabel!
  @IBOutlet weak var recordTimeLabel         : UILabel!
  @IBOutlet var recordStars                  : [UIImageView]!
  
  @IBOutlet weak var chooseBackgroundView : UIView!
  @IBOutlet weak var leftArrow            : UIImageView!
  @IBOutlet weak var rightArrow           : UIImageView!
  @IBOutlet weak var chooseViewLabel      : UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.tabBarController?.tabBar.isHidden = true
  }
}
