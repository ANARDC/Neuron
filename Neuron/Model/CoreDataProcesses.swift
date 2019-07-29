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
}
