//
//  SchulteTableStartLevelsCollectionViewCell.swift
//  Neuron
//
//  Created by Anar on 09.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

class SchulteTableStartLevelsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.makeCellAppearance()
      self.makeLevelLabel()
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Appearance Functions

extension SchulteTableStartLevelsCollectionViewCell {
  
  // MARK: - makeCellAppearance
  func makeCellAppearance() {
    self.clipsToBounds = false
    
    self.layer.shadowColor   = UIColor(red: 0.898, green: 0.925, blue: 0.929, alpha: 1).cgColor
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius  = 6
    self.layer.shadowOffset  = CGSize(width: 0, height: 11)
    
    self.layer.cornerRadius = 8
    
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor(red: 0.896, green: 0.926, blue: 0.931, alpha: 1).cgColor
    
    self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
  }
  
  // MARK: - makeLevelLabel
  func makeLevelLabel() {
    let label           = UILabel()
    label.text          = "\(SchulteTableStartViewController.levelNumberForSettingsCollectionViewCellsAppear)×\(SchulteTableStartViewController.levelNumberForSettingsCollectionViewCellsAppear)"
    label.textColor     = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1)
    label.font          = UIFont(name: "NotoSans-Bold", size: 22)
    label.textAlignment = .center
    
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
