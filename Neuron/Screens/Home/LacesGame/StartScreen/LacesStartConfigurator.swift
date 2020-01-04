//
//  Configurator.swift
//  Neuron
//
//  Created by Anar on 02.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

protocol LacesStartConfigurator {
  func configure(_: LacesStartViewController)
}

final class LacesStartConfiguratorImplementation: LacesStartConfigurator {
  var presenter: LacesStartPresenter?
  
  init(_ lacesStartViewController: LacesStartViewController) {
    self.presenter = LacesStartPresenter(view: lacesStartViewController)
  }
  
  func configure(_ lacesStartViewController: LacesStartViewController) {
    lacesStartViewController.presenter = self.presenter
  }
}
