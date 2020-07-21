//
//  DataBase.swift
//  Neuron
//
//  Created by Anar on 14.10.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Protocol
protocol FruitsDataCoreProtocol {
  func saveFruitsGameData(fruitsGameSessionModel: FruitsGameSessionModel)
  func getFruitsGameData() -> [FruitsGameSessionModel]
}

// MARK: - FruitsDataCore
final class FruitsDataCore: FruitsDataCoreProtocol {
  func saveFruitsGameData(fruitsGameSessionModel: FruitsGameSessionModel) {
    // Получаем необходимые свойства
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entity  = NSEntityDescription.entity(forEntityName: "FruitsGameSession", in: context)
    let storageObject  = NSManagedObject(entity: entity!, insertInto: context) as! FruitsGameSession
    
    // Присваивание значений свойствам объекта
    storageObject.date         = fruitsGameSessionModel.date
    storageObject.time         = fruitsGameSessionModel.time
    storageObject.filledFruits = fruitsGameSessionModel.filledFruits
    storageObject.fruitsTypes  = fruitsGameSessionModel.fruitsTypes
    storageObject.rate         = fruitsGameSessionModel.rate
    storageObject.levelNumber  = fruitsGameSessionModel.levelNumber
    
    // Сохранение контекста
    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  // MARK: - Getting FruitsGamesSessionsModels From Storage
  func getFruitsGameData() -> [FruitsGameSessionModel] {
    var models = [FruitsGameSessionModel]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<FruitsGameSession> = FruitsGameSession.fetchRequest()
    
    do {
      let data = try context.fetch(fetchRequest)
      data.forEach { (session) in
        models.append(FruitsGameSessionModel(time         : session.time,
                                             filledFruits : session.filledFruits,
                                             fruitsTypes  : session.fruitsTypes,
                                             rate         : session.rate,
                                             levelNumber  : session.levelNumber,
                                             date         : session.date!))
      }
    } catch {
      print(error.localizedDescription)
    }
    
    return models
  }
}

// MARK: - FruitsGameSessionModel
struct FruitsGameSessionModel {
  var time         : Int32
  var filledFruits : Int16
  var fruitsTypes  : Int16
  var rate         : Int16
  var levelNumber  : Int16
  var date         : String
}
