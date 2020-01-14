//
//  LacesGameViewController.swift
//  Neuron
//
//  Created by Anar on 04.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

// MARK: - protocol
protocol LacesGameViewControllerDelegate {
  
}

// MARK: - class
final class LacesGameViewController: UIViewController, LacesGameViewControllerDelegate {
  var configurator : LacesGameConfigurator!
  var presenter    : LacesGamePresenterDelegate!
  
  
  @IBOutlet weak var timerLabel            : UILabel!
  @IBOutlet weak var restartButton         : UIBarButtonItem!
  @IBOutlet weak var eyeletsCollectionView : UICollectionView!
  @IBOutlet var stars                      : [UIImageView]!
  
  var levelNumber: Int!
}

// MARK: - Life Cycle

extension LacesGameViewController {
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = LacesGameConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
}
