//
//  Model.swift
//  Neuron
//
//  Created by Anar on 17.10.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import Foundation

final class FruitsGameModel {
  let useCases: UseCases
  let fruitsDataCore: FruitsDataCore
  
  init(useCases: UseCases, fruitsDataCore: FruitsDataCore) {
    self.useCases = useCases
    self.fruitsDataCore = fruitsDataCore
  }
}
