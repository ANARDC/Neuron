//
//  SchulteTableStartViewController.swift
//  Neuron
//
//  Created by Anar on 02.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

protocol SchulteTableStartViewControllerDelegate {
  var configurator: SchulteTableStartConfigurator! { get set }
  var presenter  : SchulteTableStartPresenterDelegate! { get set }
  
  func viewDidLoad()
  func viewWillAppear(_ animated: Bool)
  func makeNavBarTitle()
}

final class SchulteTableStartViewController: UIViewController, SchulteTableStartViewControllerDelegate {
  var configurator : SchulteTableStartConfigurator!
  var presenter    : SchulteTableStartPresenterDelegate!
  
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
}

extension SchulteTableStartViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = SchulteTableStartConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.tabBarController?.tabBar.isHidden = true
  }
}

extension SchulteTableStartViewController {
  
  // MARK: - makeNavBarTitle
  func makeNavBarTitle() {
    let navBarTitleFont      = UIFont(name: "NotoSans-Bold", size: 23)!
    let navBarTitleFontColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)

    self.navigationItem.title = "Schulte Table"
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                    NSAttributedString.Key.foregroundColor: navBarTitleFontColor]
  }
}
