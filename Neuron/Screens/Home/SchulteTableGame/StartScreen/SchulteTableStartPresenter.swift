//
//  SchulteTableStartPresenter.swift
//  Neuron
//
//  Created by Anar on 03.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol SchulteTableStartPresenterDelegate {
  func viewDidLoad()
}

final class SchulteTableStartPresenter: SchulteTableStartPresenterDelegate {
  var view: SchulteTableStartViewControllerDelegate?
  
  init(view: SchulteTableStartViewControllerDelegate) {
    self.view = view
  }
  
  func viewDidLoad() {
    self.view?.makeNavBarTitle()
    self.view?.navBarSetting()
    self.view?.makeRulesTitleLabel()
  }
}
