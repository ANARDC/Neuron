//
//  SchulteTableGameConfigurator.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import Foundation

protocol SchulteTableGameConfigurator {
  func configure(_ schulteTableGameViewController: SchulteTableGameViewController)
}

final class SchulteTableGameConfiguratorImplementation: SchulteTableGameConfigurator {
  var presenter: SchulteTableGamePresenter?
  
  init(_ schulteTableGameViewController: SchulteTableGameViewController) {
    self.presenter = SchulteTableGamePresenter(view: schulteTableGameViewController)
  }
  
  func configure(_ schulteTableGameViewController: SchulteTableGameViewController) {
    schulteTableGameViewController.presenter = self.presenter
  }
}
