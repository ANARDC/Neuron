//
// Created by Anar on 20/09/2019.
// Copyright (c) 2019 Commodo. All rights reserved.
//

import UIKit

protocol FruitsGameConfigurator {
  func configure(_: FruitsGameViewController)
  func configure(_: FruitsGamePopUpTopView)
  func configure(_: FruitsGamePopUpBottomView)
}

final class FruitsGameConfiguratorImplementation: FruitsGameConfigurator {
  var presenter: FruitsGamePresenterProtocol?
  
  init(_ fruitsGameViewController: FruitsGameViewController) {
    let model = FruitsGameModel(fruitsDataCore: FruitsDataCore())
    self.presenter = FruitsGamePresenter(view: fruitsGameViewController, model: model)
  }
  
  func configure(_ fruitsGameViewController: FruitsGameViewController) {
    fruitsGameViewController.presenter = self.presenter
  }
  
  func configure(_ popUpTopView: FruitsGamePopUpTopView) {
    popUpTopView.presenter = self.presenter
  }
  
  func configure(_ popUpBottomView: FruitsGamePopUpBottomView) {
    popUpBottomView.presenter = self.presenter
  }
}
