//
//  LacesGamePresenter.swift
//  Neuron
//
//  Created by Anar on 04.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

// MARK: - protocol
protocol LacesGamePresenterProtocol {
  func viewDidLoad()
}

// MARK: - class
final class LacesGamePresenter: LacesGamePresenterProtocol {
  var view: LacesGameViewControllerProtocol?
  
  init(view: LacesGameViewControllerProtocol) {
    self.view = view
  }
  
  func viewDidLoad() {
    
  }
}
