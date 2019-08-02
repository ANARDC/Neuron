//
//  AddNoteCellButton.swift
//  Neuron
//
//  Created by Anar on 17/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class DiaryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var addNote: AddNoteCellButton!
    @IBOutlet weak var dateInt: UILabel!
    @IBOutlet weak var dateString: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
}
