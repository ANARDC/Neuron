//
// Created by Anar on 20/09/2019.
// Copyright (c) 2019 Commodo. All rights reserved.
//

import Foundation

protocol FruitsGameConfigurator {
  func configure(of: FruitsGameViewController)
}

final class FruitsGameConfiguratorImplementation: FruitsGameConfigurator {

  func configure(of fruitsGameViewController: FruitsGameViewController) {
    let presenter = FruitsGamePresenter(view: fruitsGameViewController)

    fruitsGameViewController.presenter = presenter
  }
}
