//
//  SchulteTableGameTableCollectionViewCell.swift
//  Neuron
//
//  Created by Anar on 24.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class SchulteTableGameTableCollectionViewCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.makeCellAppearance()
    self.makeCellLabel()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Appearance Functions

extension SchulteTableGameTableCollectionViewCell {
  
  // MARK: - makeCellAppearance
  func makeCellAppearance() {
    self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    self.borderWidth = 2
    self.borderColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
  }
  
  // MARK: - makeCellLabel
  func makeCellLabel() {
    let label = UILabel()
    label.text = SchulteTableGameViewController.cellLabelText
    label.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1)
    label.font = UIFont(name: "NotoSans", size: 30)
    
    self.addSubview(label)
    
    self.makeLevelLabelConstraints(label)
  }
  
  // MARK: - makeLevelLabelConstraints
  func makeLevelLabelConstraints(_ label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    
    let centerXConstraint = label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let centerYConstraint = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    
    NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
  }
}
