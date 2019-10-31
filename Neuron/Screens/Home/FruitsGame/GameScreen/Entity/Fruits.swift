//
//  Fruits.swift
//  Neuron
//
//  Created by Anar on 22/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

enum Fruits: String, CaseIterable {
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
  
  func getFruitView(x: Double = 0, y: Double = 0, width: Double, height: Double) -> UIView {
    let fruitView = self.makeFruitView(x: x, y: y, width: width, height: height)
    let fruit     = self.makeFruit()
    fruitView.addSubview(fruit)
    self.addFruitViewAutolayout(for: fruit, to: fruitView)
    
    return fruitView
  }
  
  private func makeFruitView(x: Double, y: Double, width: Double, height: Double) -> UIView {
    let fruitView             = UIView()
    fruitView.frame           = CGRect(x: x, y: y, width: width, height: height)
    fruitView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    fruitView.cornerRadius    = 17.27
    fruitView.borderWidth     = 1
    fruitView.borderColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    fruitView.shadowColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    fruitView.shadowOpacity   = 1
    fruitView.shadowRadius    = 14
    fruitView.shadowOffset    = CGSize(width: 0, height: 0)
    
    return fruitView
  }
  
  private func makeFruit() -> UIImageView {
    let fruit                                       = UIImageView()
    fruit.contentMode                               = .scaleAspectFill
    fruit.image                                     = UIImage(named: self.rawValue)?.withRenderingMode(.alwaysOriginal)
    fruit.isUserInteractionEnabled                  = true
    fruit.translatesAutoresizingMaskIntoConstraints = false
    
    return fruit
  }
  
  private func addFruitViewAutolayout(for view: UIView, to mainView: UIView) {
    let constraintsConstants = ["БольшоеЯблоко"   : FruitConstraintsConstants(top: 2,   trailing: 0,   bottom: 0,   leading: 0),
                                "БольшойБанан"    : FruitConstraintsConstants(top: 5,   trailing: -10, bottom: 0,   leading: 0),
                                "БольшиеБрокколи" : FruitConstraintsConstants(top: 0,   trailing: -5,  bottom: -5,  leading: 5),
                                "БольшаяМорковь"  : FruitConstraintsConstants(top: -4,  trailing: -11, bottom: 3,   leading: 11),
                                "БольшаяКукуруза" : FruitConstraintsConstants(top: 5,   trailing: -5,  bottom: 5,   leading: 5),
                                "БольшойВиноград" : FruitConstraintsConstants(top: -2,  trailing: 0,   bottom: 2,   leading: 0),
                                "БольшойЛимон"    : FruitConstraintsConstants(top: 10,  trailing: -11, bottom: -10, leading: 10),
                                "БольшойЛук"      : FruitConstraintsConstants(top: 0,   trailing: 0,   bottom: 0,   leading: 2),
                                "БольшойАпельсин" : FruitConstraintsConstants(top: -2,  trailing: -3,  bottom: 2,   leading: 2),
                                "БольшаяГруша"    : FruitConstraintsConstants(top: -3,  trailing: -13, bottom: -6,  leading: 14),
                                "БольшойТомат"    : FruitConstraintsConstants(top: -4,  trailing: 1,   bottom: 3,   leading: -2),
                                "БольшойАрбуз"    : FruitConstraintsConstants(top: -16, trailing: 16,  bottom: 17,  leading: -17)]
    
    let topConstraint      = view.topAnchor.constraint(equalTo: mainView.topAnchor, constant: CGFloat(constraintsConstants[self.rawValue]!.top))
    let trailingConstraint = view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: CGFloat(constraintsConstants[self.rawValue]!.trailing))
    let bottomConstraint   = view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: CGFloat(constraintsConstants[self.rawValue]!.bottom))
    let leadingConstraint  = view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: CGFloat(constraintsConstants[self.rawValue]!.leading))
    let widthConstraint    = mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width)
    let heightConstraint   = mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height)
    
    NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint, widthConstraint, heightConstraint])
  }
}

struct FruitConstraintsConstants {
  let top: Int
  let trailing: Int
  let bottom: Int
  let leading: Int
}
