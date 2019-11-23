//
//  SchulteTableGameViewController.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol SchulteTableGameViewControllerDelegate {
  var settingsData : SchulteTableGameSettings! { get }
  
  func makeRestartButtonImage()
}

final class SchulteTableGameViewController: UIViewController, SchulteTableGameViewControllerDelegate {
  var configurator : SchulteTableGameConfigurator!
  var presenter    : SchulteTableGamePresenterDelegate!
  
  var settingsData : SchulteTableGameSettings!
  
  @IBOutlet weak var timerLabel          : UILabel!
  @IBOutlet weak var restartButton       : UIBarButtonItem!
  @IBOutlet weak var tableCollectionView : UICollectionView!
  @IBOutlet var stars                    : [UIImageView]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = SchulteTableGameConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidload()
  }
}

// MARK: - UI Making Functions

extension SchulteTableGameViewController {
  
  // MARK: - makeRestartButtonImage
  func makeRestartButtonImage() {
    self.restartButton.image = #imageLiteral(resourceName: "Рестарт").withRenderingMode(.alwaysOriginal)
  }
}
