//
//  LacesGameConfigurator.swift
//  Neuron
//
//  Created by Anar on 04.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

protocol LacesGameConfigurator {
  func configure(_: LacesGameViewController)
}

final class LacesGameConfiguratorImplementation: LacesGameConfigurator {
  var presenter: LacesGamePresenter?
  
  init(_ lacesGameViewController: LacesGameViewController) {
    self.presenter = LacesGamePresenter(view: lacesGameViewController)
  }
  
  func configure(_ lacesGameViewController: LacesGameViewController) {
    lacesGameViewController.presenter = self.presenter
  }
}
