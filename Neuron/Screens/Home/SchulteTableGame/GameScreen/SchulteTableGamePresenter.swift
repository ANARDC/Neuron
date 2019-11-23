//
//  SchulteTableGamePresenter.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import Foundation

protocol SchulteTableGamePresenterDelegate {
  func viewDidload()
}

final class SchulteTableGamePresenter: SchulteTableGamePresenterDelegate {
  var view: SchulteTableGameViewControllerDelegate?
  
  init(view: SchulteTableGameViewControllerDelegate) {
    self.view = view
  }
  
  func viewDidload() {
    self.view?.makeRestartButtonImage()
  }
}
