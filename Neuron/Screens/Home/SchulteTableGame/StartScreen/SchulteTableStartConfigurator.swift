//
//  SchulteTableStartConfigurator.swift
//  Neuron
//
//  Created by Anar on 03.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol SchulteTableStartConfigurator {
  func configure(_: SchulteTableStartViewController)
}

final class SchulteTableStartConfiguratorImplementation: SchulteTableStartConfigurator {
  var presenter: SchulteTableStartPresenter?
  
  init(_ schulteTableStartViewController: SchulteTableStartViewController) {
    self.presenter = SchulteTableStartPresenter(view: schulteTableStartViewController)
  }
  
  func configure(_ schulteTableStartViewController: SchulteTableStartViewController) {
    schulteTableStartViewController.presenter = self.presenter
  }
}
