//
// Created by Anar on 20/09/2019.
// Copyright (c) 2019 Commodo. All rights reserved.
//

import UIKit

protocol FruitsGameConfigurator {
  func configure(_: FruitsGameViewController)
  func configure(_: PopUpTopView)
  func configure(_: PopUpBottomView)
}

final class FruitsGameConfiguratorImplementation: FruitsGameConfigurator {
  var presenter: FruitsGamePresenterDelegate?
  
  init(_ fruitsGameViewController: FruitsGameViewController) {
    let model = FruitsGameModel(useCases: UseCases(), fruitsDataCore: FruitsDataCore())
    self.presenter = FruitsGamePresenter(view: fruitsGameViewController, model: model)
  }
  
  func configure(_ fruitsGameViewController: FruitsGameViewController) {
    fruitsGameViewController.presenter = self.presenter
  }
  
  func configure(_ popUpTopView: PopUpTopView) {
    popUpTopView.presenter = self.presenter
  }
  
  func configure(_ popUpBottomView: PopUpBottomView) {
    popUpBottomView.presenter = self.presenter
  }
}
