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
    let fruitView = makeFruitView(x: x, y: y, width: width, height: height)
    let fruit     = makeFruit()
    fruitView.addSubview(fruit)
    addFruitViewAutolayout(for: fruit, to: fruitView)
    
    return fruitView
  }
  
  func makeFruitView(x: Double, y: Double, width: Double, height: Double) -> UIView {
    let fruitView             = UIView()
    fruitView.frame           = CGRect(x: x, y: y, width: width, height: height)
    fruitView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    fruitView.cornerRadius    = 8
    fruitView.borderWidth     = 1
    fruitView.borderColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    fruitView.shadowColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    fruitView.shadowOpacity   = 1
    fruitView.shadowRadius    = 14
    fruitView.shadowOffset    = CGSize(width: 0, height: 0)
    
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
    let topConstraint      = view.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 2)
    let trailingConstraint = view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0)
    let bottomConstraint   = view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 14)
    let leadingConstraint  = view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0)
    let widthConstraint    = mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width)
    let heightConstraint   = mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height)
    
    NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint, widthConstraint, heightConstraint])
  }
}
