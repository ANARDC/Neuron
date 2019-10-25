//
//  CoreDataProcesses.swift
//  Neuron
//
//  Created by Anar on 27/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataProcesses {

  // MARK: - Getting Notes From CoreData
  static var notesFromCoreData: [Note] {
    var notes = [Note]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
    do {
      notes = try context.fetch(fetchRequest)
    } catch {
      print(error.localizedDescription)
    }
    return notes
  }

  /* 
   * TODO: - Создай структуру для заметки
   *         как в фруктах
   *         и организуй работу с данными
   *         через нее
   */
  static func saveNoteToCoreData(text: String, title: String) {
    // Получаем необходимые свойства
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
    let object = NSManagedObject(entity: entity!, insertInto: context) as! Note

    // Получаем текующую дату
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "d.EEEE.MMM.yyyy" // "17.Thursday.Oct.2019"
    let currentDate = formatter.string(from: date)

    // Присваивание значений свойствам объекта
    object.date          = currentDate
    object.symbolsAmount = Int32(text.count)
    object.text          = text
    object.title         = title


    // Сохранение контекста
    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }

    // Увеличиваем количество записей и возвращаемся обратно в HomeViewController
    let notesCount = UserDefaults.standard.integer(forKey: "notesCount")
    UserDefaults.standard.set(notesCount + 1, forKey: "notesCount")
  }
}
