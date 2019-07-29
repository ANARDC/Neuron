//
//  NoteTableViewCell.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var dateInt: UILabel!
    @IBOutlet weak var dateString: UILabel!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
