//
// Created by Anar on 20/09/2019.
// Copyright (c) 2019 Commodo. All rights reserved.
//

import Foundation

protocol FruitsGameConfigurator {
  func configure(_: FruitsGameViewController)
  func configure(_: PopUpTopView)
  func configure(_: PopUpBottomView)
}

final class FruitsGameConfiguratorImplementation: FruitsGameConfigurator {
  var presenter: FruitsGamePresenterDelegate?
  
  func configure(_ fruitsGameViewController: FruitsGameViewController) {
    self.presenter = FruitsGamePresenter(view: fruitsGameViewController)
    
    fruitsGameViewController.presenter = self.presenter
  }
  
  func configure(_ popUpTopView: PopUpTopView) {
    popUpTopView.presenter = self.presenter
  }
  
  func configure(_ popUpBottomView: PopUpBottomView) {
    popUpBottomView.presenter = self.presenter
  }
}
