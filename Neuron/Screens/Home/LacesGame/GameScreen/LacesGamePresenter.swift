//
//  LacesGamePresenter.swift
//  Neuron
//
//  Created by Anar on 04.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

// MARK: - protocol
protocol LacesGamePresenterDelegate {
  func viewDidLoad()
}

// MARK: - class
final class LacesGamePresenter: LacesGamePresenterDelegate {
  var view: LacesGameViewControllerDelegate?
  
  init(view: LacesGameViewControllerDelegate) {
    self.view = view
  }
  
  func viewDidLoad() {
    
  }
}
