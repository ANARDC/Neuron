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
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Appearance Functions

extension SchulteTableGameTableCollectionViewCell {
  
  // MARK: - setup
  func setup() {
    self.clearSubviews()
    self.makeCellAppearance()
    self.makeCellLabel()
  }
  
  // MARK: - clearSubviews
  func clearSubviews() {
    self.subviews.forEach { (subview) in
      subview.removeFromSuperview()
    }
  }
  
  // MARK: - makeCellAppearance
  func makeCellAppearance() {
    self.backgroundColor = SchulteTableGameViewController.currentTableCollectionViewCellData.backgroundColor
    self.borderWidth     = 2
    self.borderColor     = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
  }
  
  // MARK: - makeCellLabel
  func makeCellLabel() {
    let label       = UILabel()
    label.text      = SchulteTableGameViewController.currentTableCollectionViewCellData.labelText
    label.textColor = SchulteTableGameViewController.currentTableCollectionViewCellData.labelTextColor
    label.font      = UIFont(name: "NotoSans", size: 30)
    
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
