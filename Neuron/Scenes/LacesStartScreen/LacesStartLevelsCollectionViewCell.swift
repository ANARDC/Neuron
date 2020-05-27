//
//  LacesStartCollectionViewCell.swift
//  Neuron
//
//  Created by Anar on 02.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

// MARK: - class
final class LacesStartLevelsCollectionViewCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.cellAppearance()
    switch LacesStartViewController.levelAccessState {
    case .open:
      self.makeGridLabel()
      self.addStarsStackView(rate: LacesStartViewController.levelNumber % 5 + 1)
    case .close:
      self.makeClosedLabel()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI Making Functions

extension LacesStartLevelsCollectionViewCell {
  
  // MARK: - cellAppearance
  func cellAppearance() {
    self.clipsToBounds         = false
    self.layer.masksToBounds   = false
    self.layer.shadowColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    self.layer.shadowRadius    = 6
    self.layer.shadowOpacity   = 1
    self.layer.shadowOffset    = CGSize(width: 0, height: 11)
    self.layer.cornerRadius    = 8
    self.layer.borderWidth     = 1
    self.layer.borderColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
  }
  
  // MARK: - makeGridLabel
  func makeGridLabel() {
    let grid       = UILabel()
    grid.text      = "\(LacesStartViewController.levelNumber)×\(LacesStartViewController.levelNumber)"
    grid.textColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    grid.font      = UIFont(name: "NotoSans-Bold", size: 25)
    
    self.addSubview(grid)
    
    self.makeGridLabelConstraints(grid)
  }
  
  // MARK: - makeGridLabelConstraints
  func makeGridLabelConstraints(_ grid: UILabel) {
    grid.translatesAutoresizingMaskIntoConstraints = false
    
    let centerXConstraint = grid.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let topConstraint     = grid.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
    
    NSLayoutConstraint.activate([centerXConstraint, topConstraint])
  }
  
  // MARK: - addStarsStackView
  func addStarsStackView(rate: Int) {
    var stars = [UIImageView]()
    
    for _ in 0..<rate {
      let goldStar   = UIImageView()
      goldStar.image = UIImage(named: "ЗолотаяЗвезда")
      stars.append(goldStar)
    }

    for _ in 0..<5 - rate {
      let emptyStar   = UIImageView()
      emptyStar.image = UIImage(named: "ПустаяЗвезда")
      stars.append(emptyStar)
    }

    let stackView  = UIStackView(arrangedSubviews: stars)
    stackView.axis = .horizontal
    
    self.addSubview(stackView)

    self.makeStartStackViewConstraints(stackView)
  }
  
  // MARK: - makeStartStackViewConstraints
  func makeStartStackViewConstraints(_ stackView: UIStackView) {
    stackView.translatesAutoresizingMaskIntoConstraints = false

    let centerXConstraint = stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let bottomConstraint  = stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)

    NSLayoutConstraint.activate([centerXConstraint, bottomConstraint])
  }
  
  // MARK: - makeClosedLabel
  func makeClosedLabel() {
    let closedLabel       = UILabel()
    closedLabel.textColor = UIColor(red: 0.49, green: 0.545, blue: 0.592, alpha: 1)
    closedLabel.font      = UIFont(name: "NotoSans-Bold", size: 16)
    closedLabel.text      = "CLOSED"
    
    self.addSubview(closedLabel)
    
    self.makeClosedLabelConstraints(closedLabel)
  }
  
  // MARK: - makeClosedLabelConstraints
  func makeClosedLabelConstraints(_ closedLabel: UILabel) {
    closedLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let centerXConstraint = closedLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let centerYConstraint = closedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    
    NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
  }
}
