//
//  SchulteTableGameConfigurator.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol SchulteTableGameConfigurator {
  func configure(_: SchulteTableGameViewController)
  func configure(_: SchulteTableGamePopUpTopView)
  func configure(_: SchulteTableGamePopUpBottomView)
}

final class SchulteTableGameConfiguratorImplementation: SchulteTableGameConfigurator {
  var presenter: SchulteTableGamePresenter?
  
  init(view schulteTableGameViewController: SchulteTableGameViewController) {
    self.presenter = SchulteTableGamePresenter(view: schulteTableGameViewController)
  }
  
  func configure(_ schulteTableGameViewController: SchulteTableGameViewController) {
    schulteTableGameViewController.presenter = self.presenter
  }
  
  func configure(_ schulteTableGamePopUpTopView: SchulteTableGamePopUpTopView) {
    schulteTableGamePopUpTopView.presenter = self.presenter
  }
  
  func configure(_ schulteTableGamePopUpBottomView: SchulteTableGamePopUpBottomView) {
    schulteTableGamePopUpBottomView.presenter = self.presenter
  }
}
