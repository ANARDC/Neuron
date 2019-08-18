//
//  FruitsGameViewController.swift
//  Neuron
//
//  Created by Anar on 14/08/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class FruitsGameViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var restartButton: UIBarButtonItem!
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet weak var fruitsMenuView: UIImageView!

    static var levelNumber = 0

    var menuFruits = [UIView]()
}

// MARK: - FruitsGameViewController Life Cycle

extension FruitsGameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.image = UIImage(named: "Рестарт")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        addNavBarTitle()
        addMenuElements(count: 3)
        self.fruitsMenuView.isUserInteractionEnabled = true
    }
}

// MARK: - Customize Functions

extension FruitsGameViewController {
    func addNavBarTitle() {
        let navBarTitleFont      = UIFont(name: "NotoSans-Bold", size: 23)!
        let navBarTitleFontColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)

        self.navigationItem.title = "Level \(FruitsGameViewController.levelNumber)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                        NSAttributedString.Key.foregroundColor: navBarTitleFontColor]
    }

    func addMenuElements(count: Int) {
        if count == 3 {
            let broccoliFruitView = fruits.broccoli.addFruitView(x: 36, y: 27, width: 59, height: 59)
            let bananaFruitView   = fruits.banana.addFruitView(x: 158, y: 27, width: 59, height: 59)
            let tomatoFruitView   = fruits.tomato.addFruitView(x: 280, y: 27, width: 59, height: 59)
            
            menuFruits.append(contentsOf: [broccoliFruitView,
                                           bananaFruitView,
                                           tomatoFruitView])
            
            self.menuFruits.forEach { (fruit) in
                self.fruitsMenuView.addSubview(fruit)
                addTapGesture(for: fruit)
            }
        }
    }
}

// MARK: - FruitsViewsCore

extension FruitsGameViewController {
    enum fruits: String, CaseIterable {
        case broccoli   = "БольшиеБрокколи"
        case banana     = "БольшойБанан"
        case tomato     = "БольшойТомат"
        case grape      = "БольшойВиноград"
        case apple      = "БольшоеЯблоко"
        case watermelon = "БольшойАрбуз"
        case corn       = "БольшаяКукуруза"
        case orange     = "БольшойАпельсин"
        case lemon      = "БольшойЛимон"
        case pear       = "БольшаяГруша"
        case carrot     = "БольшаяМорковь"
        case onion      = "БольшойЛук"

        func addFruitView(x: Double, y: Double, width: Double, height: Double) -> UIView {
            let fruitView = makeFruitView(x: x, y: y, width: width, height: height)
            let fruit     = makeFruit()
            fruitView.addSubview(fruit)
            addAutolayout(for: fruit, to: fruitView)
            
            return fruitView
        }
        
        func makeFruitView(x: Double, y: Double, width: Double, height: Double) -> UIView {
            let fruitView = UIView()
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

        func addAutolayout(for view: UIView, to mainView: UIView) {
            let topConstraint      = view.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 2)
            let trailingConstraint = view.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0)
            let bottomConstraint   = view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 15)
            let leadingConstraint  = view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0)

            NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint])
        }
    }
}

// MARK: - Gesture Function

extension FruitsGameViewController {
    func addTapGesture(for view: UIView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(lol))
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }
    
    @objc func lol() {
        print("button touched")
    }
}
