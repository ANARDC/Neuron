//
//  FruitsGameViewController.swift
//  Neuron
//
//  Created by Anar on 14/08/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

class FruitsGameViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var restartButton: UIBarButtonItem!
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet weak var fruitsMenuView: UIImageView!
    
    static var levelNumber = 0
    
    var gameFruits = [UIView]()
    var menuFruits = [UIView]()
}

// MARK: - FruitsGameViewController Life Cycle

extension FruitsGameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        assignRestartButtonImage()
        fruitsMenuViewUserInteractionEnable()
        addNavBarTitle()
        addMenuElements(count: 3+Int((FruitsGameViewController.levelNumber-1)/5))
        addGameFruits()
        makeFruitMenuView()
        editStarsStackView(rate: 5)
    }
}

// MARK: - Customize Functions

extension FruitsGameViewController {
    func assignRestartButtonImage() {
        restartButton.image = #imageLiteral(resourceName: "Рестарт").withRenderingMode(.alwaysOriginal)
    }
    
    func fruitsMenuViewUserInteractionEnable() {
        self.fruitsMenuView.isUserInteractionEnabled = true
    }
    
    func makeFruitMenuView() {
        let fruitMenuImage = FruitsGameViewController.levelNumber >= 1 && FruitsGameViewController.levelNumber <= 20 ? #imageLiteral(resourceName: "ФонФрукты1-20") : #imageLiteral(resourceName: "ФонФрукты21-50")
        self.fruitsMenuView.image = fruitMenuImage
    }
    
    func addNavBarTitle() {
        let navBarTitleFont      = UIFont(name: "NotoSans-Bold", size: 23)!
        let navBarTitleFontColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
        
        self.navigationItem.title = "Level \(FruitsGameViewController.levelNumber)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                        NSAttributedString.Key.foregroundColor: navBarTitleFontColor]
    }
    
    func addMenuElements(count: Int) {
        var mainStackView = UIStackView()
        
        for i in 0..<count {
            let fruitView = Fruits.allCases[i].getFruitView(width: 59, height: 59)
            self.menuFruits.append(fruitView)
        }
        
        self.menuFruits.enumerated().forEach { (index, fruit) in
            addTapGesture(for: fruit, fruitName: Fruits.allCases[index].rawValue)
        }
        
        switch count {
        case 3...6:
            let stackView          = UIStackView(arrangedSubviews: self.menuFruits)
            stackView.axis         = .horizontal
            stackView.distribution = .equalSpacing
            
            mainStackView = stackView
            
            self.view.addSubview(mainStackView)
            
            var edgesConstraintsConstant: CGFloat
            
            switch count {
            case 3, 4:
                edgesConstraintsConstant = 36
            case 5:
                edgesConstraintsConstant = 23
            case 6:
                edgesConstraintsConstant = 3
            default: return
            }
            
            let leadingConstraint = stackView.leadingAnchor.constraint(equalTo: fruitsMenuView.leadingAnchor, constant: edgesConstraintsConstant)
            let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: fruitsMenuView.trailingAnchor, constant: -edgesConstraintsConstant)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([leadingConstraint,
                                         trailingConstraint])
        case 7...12:
            let topStackView          = UIStackView(arrangedSubviews: Array(self.menuFruits[0..<count/2]))
            topStackView.axis         = .horizontal
            topStackView.distribution = .equalSpacing
            
            let bottomStackView          = UIStackView(arrangedSubviews: Array(self.menuFruits[Int(count/2)..<count]))
            bottomStackView.axis         = .horizontal
            bottomStackView.distribution = .equalSpacing
            
            let stackView = UIStackView(arrangedSubviews: [topStackView, bottomStackView])
            stackView.axis = .vertical
            stackView.spacing = 7
            
            mainStackView = stackView
            
            self.view.addSubview(mainStackView)
            
            var edgesConstraintsConstant: CGFloat
            
            switch count {
            case 7, 8:
                edgesConstraintsConstant = 36
            case 9, 10:
                edgesConstraintsConstant = 23
            case 11, 12:
                edgesConstraintsConstant = 3
            default: return
            }
            
            let leadingConstraint = stackView.leadingAnchor.constraint(equalTo: fruitsMenuView.leadingAnchor, constant: edgesConstraintsConstant)
            let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: fruitsMenuView.trailingAnchor, constant: -edgesConstraintsConstant)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([leadingConstraint,
                                         trailingConstraint])
        default: return
        }
        
        mainStackView.topAnchor.constraint(equalTo: fruitsMenuView.topAnchor, constant: 21).isActive = true
    }
    
    func addGameFruits() {
        switch FruitsGameViewController.levelNumber {
        case 1:
            let fruitsTypes: [Fruits] = [.broccoli, .banana, .tomato]
            for _ in 0..<8 {
                let gameFruitView = fruitsTypes.randomElement()?.getFruitView(width: 40, height: 40)
                self.gameFruits.append(gameFruitView!)
            }
            
            let stackView = UIStackView(arrangedSubviews: self.gameFruits)
            stackView.axis = .horizontal
            stackView.spacing = 2
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(stackView)
            
            NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                         stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)])
        default:
            return
        }
    }
    
    func editStarsStackView(rate: Int) {
        var stars = [UIImage]()
        
        for _ in 0..<rate {
            stars.append(#imageLiteral(resourceName: "БольшаяЗолотаяЗвезда"))
        }
        
        for _ in 0..<5 - rate {
            stars.append(#imageLiteral(resourceName: "БольшаяПустаяЗвезда"))
        }
        
        self.stars.enumerated().forEach { (index, view) in
            view.image = stars[index]
        }
    }
}

// MARK: - FruitsViewsCore

extension FruitsGameViewController {
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
            let bottomConstraint   = view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 15)
            let leadingConstraint  = view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0)
            let widthConstraint    = mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width)
            let heightConstraint   = mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height)
            
            NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint, widthConstraint, heightConstraint])
        }
    }
}

// MARK: - Gesture Function

extension FruitsGameViewController {
    func addTapGesture(for view: UIView, fruitName: String) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(lol(_:)))
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }
    
    @objc func lol(_ fruitView: UIView) {
        var lol = UIView()
        lol = fruitView
        lol.frame = CGRect(x: 50, y: 50, width: 59, height: 59)
        self.view.addSubview(lol)
    }
    
    func lolol() {
        print("asdasdasd")
    }
}
