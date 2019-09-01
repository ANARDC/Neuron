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
    
    var gameFruits          = [Fruits]()
    var gameFruitsViews     = [UIView]()
    var menuFruits          = [UIView]()
    var gameFruitsStackView = UIStackView()
    
    var timer        = Timer()
    var minutes      = 0
    var seconds      = 0
    var milliseconds = 0
    
    var currentFruitIndex = 0
}

// MARK: - FruitsGameViewController Life Cycle

extension FruitsGameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignRestartButtonImage()
        self.fruitsMenuViewUserInteractionEnable()
        self.addNavBarTitle()
        self.addMenuElements(count: 3+Int((FruitsGameViewController.levelNumber-1)/5))
        self.addGameFruits(typesCount: 3+Int((FruitsGameViewController.levelNumber-1)/5))
        self.makeFruitMenuView()
        self.appearTimerLabel()
        self.editStarsStackView(rate: 5)
        self.startTimer()
        
    }
}

// MARK: - Customize Functions

extension FruitsGameViewController {
    
    func appearTimerLabel() {
        self.timerLabel.textColor = UIColor(red: 0.92, green: 0.34, blue: 0.34, alpha: 0.9)
        self.seconds = 30
    }
    
    func startTimer() {
        self.seconds = 3
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSelectorMethod), userInfo: nil, repeats: true)
    }
    
    @objc func timerSelectorMethod() {
        self.seconds -= 1
        self.timerLabel.text = "00.0\(seconds).00"
        
        if seconds == 0 {
            self.timer.invalidate()
            
            addGrayCross()
        }
    }
    
    func addGrayCross() {
        self.gameFruitsViews.forEach { (fruit) in
            let unsolvedFruitView = UIImageView()
            unsolvedFruitView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            unsolvedFruitView.image = #imageLiteral(resourceName: "Неразгаданный фрукт")
            
            fruit.backgroundColor = .clear
            fruit.shadowOpacity   = 0
            fruit.borderWidth     = 0
            fruit.subviews.last?.isHidden = true
            fruit.addSubview(unsolvedFruitView)
        }
    }
    
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
            addTapGesture(for: fruit, fruit: Fruits.allCases[index])
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
    
    // FIXME: - Take in Fruits enum
    func addGameFruits(typesCount: Int) {
        let fruitsTypes: [Fruits] = Array(Fruits.allCases[0..<typesCount])
        
        let preFruitsCount = FruitsGameViewController.levelNumber + 7
        let fruitsCount = preFruitsCount <= 53 ? preFruitsCount : 53
        
        let gameFruitsList = self.getGameFruitsList() // [8, 1, 8, 1, 5]
        
        var mainStackViewArrangedSubviews = [UIStackView]() // [gameFruitsStackSubviews]
        
        for i in gameFruitsList {
            var intermediateGameFruits = [UIView]()
            
            // Create fruits views
            for _ in 0..<i {
                let gameFruit = fruitsTypes.randomElement()
                let gameFruitView = gameFruit?.getFruitView(width: 40, height: 40)
                self.gameFruits.append(gameFruit!)
                self.gameFruitsViews.append(gameFruitView!)
                intermediateGameFruits.append(gameFruitView!)
            }
            
            // Create gameFruitsStackSubview
            let gameFruitsStackSubview = UIStackView(arrangedSubviews: intermediateGameFruits)
            gameFruitsStackSubview.axis = .horizontal
            gameFruitsStackSubview.spacing = 2
            
            // Add gameFruitsStackSubview in mainStackViewArrangedSubviews
            mainStackViewArrangedSubviews.append(gameFruitsStackSubview)
        }
        
        var groupedMainStackViewArrangedSubviews = [UIStackView]()
        
        
        // FIXME: - Take out in a separate function
        if fruitsCount % 9 == 0 {
            var alignment = UIStackView.Alignment.trailing
            
            for i in stride(from: 0, to: mainStackViewArrangedSubviews.count, by: 2) {
                let groupedStackView = UIStackView(arrangedSubviews: [mainStackViewArrangedSubviews[i], mainStackViewArrangedSubviews[i+1]])
                groupedStackView.axis = .vertical
                groupedStackView.alignment = alignment
                groupedStackView.spacing = 2
                
                groupedMainStackViewArrangedSubviews.append(groupedStackView)
                alignment = alignment == .trailing ? .leading : .trailing
            }
        } else {
            groupedMainStackViewArrangedSubviews.append(mainStackViewArrangedSubviews.first!)
            
            var alignment = UIStackView.Alignment.trailing
            
            for i in stride(from: 1, to: mainStackViewArrangedSubviews.count, by: 2) {
                let groupedStackView = UIStackView(arrangedSubviews: [mainStackViewArrangedSubviews[i], mainStackViewArrangedSubviews[i+1]])
                groupedStackView.axis = .vertical
                groupedStackView.alignment = alignment
                groupedStackView.spacing = 2
                
                groupedMainStackViewArrangedSubviews.append(groupedStackView)
                alignment = alignment == .trailing ? .leading : .trailing
            }
        }
        
        let mainStackView = UIStackView(arrangedSubviews: groupedMainStackViewArrangedSubviews)
        mainStackView.axis = .vertical
        mainStackView.spacing = 2
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     mainStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20)])
    }
    
    func getGameFruitsList() -> [Int] {
        var gameFruitsList = [Int]()
        let preFruitsCount = FruitsGameViewController.levelNumber + 7
        var fruitsCount = preFruitsCount <= 53 ? preFruitsCount : 53
        while fruitsCount >= 9 {
            fruitsCount -= 9
            gameFruitsList.append(contentsOf: [8, 1])
        }
        guard fruitsCount > 0 else { return gameFruitsList }
        gameFruitsList.append(fruitsCount)
        
        return gameFruitsList
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
            let bottomConstraint   = view.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 14)
            let leadingConstraint  = view.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0)
            let widthConstraint    = mainView.widthAnchor.constraint(equalToConstant: mainView.frame.width)
            let heightConstraint   = mainView.heightAnchor.constraint(equalToConstant: mainView.frame.height)
            
            NSLayoutConstraint.activate([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint, widthConstraint, heightConstraint])
        }
    }
}

// MARK: - Gesture Function

extension FruitsGameViewController {
    func addTapGesture(for view: UIView, fruit: Fruits) {
        var gestureAction: Selector? = nil
        
        switch fruit {
        case .apple:      gestureAction = #selector(appleSelector)
        case .banana:     gestureAction = #selector(bananaSelector)
        case .broccoli:   gestureAction = #selector(broccoliSelector)
        case .carrot:     gestureAction = #selector(carrotSelector)
        case .corn:       gestureAction = #selector(cornSelector)
        case .grape:      gestureAction = #selector(grapeSelector)
        case .lemon:      gestureAction = #selector(lemonSelector)
        case .onion:      gestureAction = #selector(onionSelector)
        case .orange:     gestureAction = #selector(orangeSelector)
        case .pear:       gestureAction = #selector(pearSelector)
        case .tomato:     gestureAction = #selector(tomatoSelector)
        case .watermelon: gestureAction = #selector(watermelonSelector)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: gestureAction)
        gesture.numberOfTapsRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
    }
    
    @objc func appleSelector() {
        fillGameFruits(for: .apple)
    }
    
    @objc func bananaSelector() {
        fillGameFruits(for: .banana)
    }
    
    @objc func broccoliSelector() {
        fillGameFruits(for: .broccoli)
    }
    
    @objc func carrotSelector() {
        fillGameFruits(for: .carrot)
    }
    
    @objc func cornSelector() {
        fillGameFruits(for: .corn)
    }
    
    @objc func grapeSelector() {
        fillGameFruits(for: .grape)
    }
    
    @objc func lemonSelector() {
        fillGameFruits(for: .lemon)
    }
    
    @objc func onionSelector() {
        fillGameFruits(for: .onion)
    }
    
    @objc func orangeSelector() {
        fillGameFruits(for: .orange)
    }
    
    @objc func pearSelector() {
        fillGameFruits(for: .pear)
    }
    
    @objc func tomatoSelector() {
        fillGameFruits(for: .tomato)
    }
    
    @objc func watermelonSelector() {
        fillGameFruits(for: .watermelon)
    }
    
    func fillGameFruits(for fruit: Fruits) {
        // Проверяем верно ли тапнул юзер
        guard gameFruits[self.currentFruitIndex] == fruit else {
            addRedCross()
            changeTimerLabel()
            return
        }
        
        let currentGameFruit = self.gameFruitsViews[self.currentFruitIndex]
        
        currentGameFruit.subviews.last?.removeFromSuperview()
        currentGameFruit.subviews.last?.isHidden = false
        currentGameFruit.shadowOpacity = 1
        currentGameFruit.borderWidth = 1
        
        self.currentFruitIndex += 1
    }
    
    func addRedCross() {
        self.gameFruitsViews[self.currentFruitIndex...].forEach { (fruit) in
            let errorFruitView = UIImageView()
            errorFruitView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            errorFruitView.image = #imageLiteral(resourceName: "Неправильный фрукт")
            
            fruit.subviews.last?.removeFromSuperview()
            fruit.addSubview(errorFruitView)
        }
    }
    
    func changeTimerLabel() {
        self.timerLabel.text = "Error!"
    }
}
