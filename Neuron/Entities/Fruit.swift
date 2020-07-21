//
//  Fruit.swift
//  Neuron
//
//  Created by Anar on 22/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

enum Fruit: String, CaseIterable {
  case apple      = "БольшоеЯблоко"
  case banana     = "БольшойБанан"
  case broccoli   = "БольшиеБрокколи"
  case carrot     = "БольшаяМорковь"
  case corn       = "БольшаяКукуруза"
  case grape      = "БольшойВиноград"
  case lemon      = "БольшойЛимон"
  case onion      = "БольшойЛук"
  case orange     = "БольшойАпельсин"
  case pear       = "БольшаяГруша"
  case tomato     = "БольшойТомат"
  case watermelon = "БольшойАрбуз"
  
  func getFruitView(x: Double = 0, y: Double = 0, width: Double, height: Double, space: FruitsSpace) -> UIView {
    let fruitView = self.makeFruitView(x: x, y: y, width: width, height: height, space: space)
    let fruit     = self.makeFruit()
    
    fruitView.addSubview(fruit)
    
    self.addFruitViewAutolayout(for: fruit, to: fruitView)
    
    return fruitView
  }
}

private extension Fruit {
  func makeFruitView(x: Double, y: Double, width: Double, height: Double, space: FruitsSpace) -> UIView {
    let fruitView             = UIView()
    fruitView.frame           = CGRect(x: x, y: y, width: width, height: height)
    fruitView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    switch space {
      case .game: fruitView.cornerRadius = CGFloat(width / 2)
      case .menu: fruitView.cornerRadius = 17.27
    }
    
    fruitView.borderWidth   = 1
    fruitView.borderColor   = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    fruitView.shadowColor   = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    fruitView.shadowOpacity = 1
    fruitView.shadowRadius  = 14
    fruitView.shadowOffset  = CGSize(width: 0, height: 0)
    
    return fruitView
  }
  
  func makeFruit() -> UIImageView {
    let fruit                                       = UIImageView()
    fruit.contentMode                               = .scaleAspectFill
    fruit.image                                     = UIImage(named: self.rawValue)?.withRenderingMode(.alwaysOriginal)
    fruit.isUserInteractionEnabled                  = true
    fruit.translatesAutoresizingMaskIntoConstraints = false
    
    return fruit
  }
  
  func addFruitViewAutolayout(for view: UIView, to mainView: UIView) {
    let constraintsConstants = [Fruit.apple      : FruitConstraintsConstants(top: 2,   trailing: 0,   bottom: 0,   leading: 0),
                                Fruit.banana     : FruitConstraintsConstants(top: 5,   trailing: -7,  bottom: 0,   leading: 3),
                                Fruit.broccoli   : FruitConstraintsConstants(top: 0,   trailing: -5,  bottom: -5,  leading: 5),
                                Fruit.carrot     : FruitConstraintsConstants(top: -4,  trailing: -11, bottom: 3,   leading: 11),
                                Fruit.corn       : FruitConstraintsConstants(top: 5,   trailing: -5,  bottom: 5,   leading: 5),
                                Fruit.grape      : FruitConstraintsConstants(top: -2,  trailing: 0,   bottom: 2,   leading: 0),
                                Fruit.lemon      : FruitConstraintsConstants(top: 8,   trailing: -8,  bottom: -8,  leading: 8),
                                Fruit.onion      : FruitConstraintsConstants(top: 0,   trailing: 0,   bottom: 0,   leading: 2),
                                Fruit.orange     : FruitConstraintsConstants(top: -2,  trailing: -3,  bottom: 2,   leading: 2),
                                Fruit.pear       : FruitConstraintsConstants(top: -3,  trailing: -13, bottom: -6,  leading: 14),
                                Fruit.tomato     : FruitConstraintsConstants(top: -4,  trailing: 1,   bottom: 3,   leading: -2),
                                Fruit.watermelon : FruitConstraintsConstants(top: -11, trailing: 11,  bottom: 11,  leading: -11)]
    
    guard let constraintConstants = constraintsConstants[self] else { return }
    
    let topConstraint      = view.topAnchor.constraint(equalTo: mainView.topAnchor, constant: CGFloat(constraintConstants.top))
    let trailingConstraint = view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: CGFloat(constraintConstants.trailing))
    let bottomConstraint   = view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: CGFloat(constraintConstants.bottom))
    let leadingConstraint  = view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(constraintConstants.leading))
    let widthConstraint    = mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width)
    let heightConstraint   = mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height)
    
    NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint, widthConstraint, heightConstraint])
  }
}
