//
//  LevelsCollectionViewCell.swift
//  Neuron
//
//  Created by Anar on 05/08/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

class LevelsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellAppearance(self)
        addLevelLabel(self)
        addFruitsStackView(self, FruitsStartViewController.levelNumber)
        addStarsStackView(self, rate: FruitsStartViewController.levelNumber % 5 + 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Appearance Functions

extension LevelsCollectionViewCell {
    
    // MARK: - Cell Appearance
    func cellAppearance(_ cell: UICollectionViewCell) {
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        
        cell.layer.shadowColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        cell.layer.shadowRadius = 14
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize(width: 0, height: 11)
        
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        
        cell.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    }
    
    // MARK: - Adding levelsLabel
    func addLevelLabel(_ cell: UICollectionViewCell) {
        let label = UILabel()
        label.text = String(FruitsStartViewController.levelNumber)
        label.textColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
        label.font = UIFont(name: "NotoSans-Bold", size: 25)
        label.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: cell.topAnchor, constant: 2),
                                     label.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 7)])
    }
    
    // MARK: - Adding fruitsStackView
    func addFruitsStackView(_ cell: UICollectionViewCell, _ levelNumber: Int) {
        func stackViewAppearance(_ cell: UICollectionViewCell, _ fruitsCount: Int) {
            let fruits = ["Брокколи", "Банан", "Томат", "Виноград", "Яблоко", "Арбуз", "Кукуруза", "Апельсин", "Лимон", "Груша", "Морковь", "Лук"]
            var fruitsViews = [UIImageView]()
            
            for index in 0..<fruitsCount {
                let fruitView = UIImageView()
                fruitView.image = UIImage(named: fruits[index])
                fruitsViews.append(fruitView)
            }
            
            switch fruitsCount {
            case ..<5:
                let stackView = UIStackView(arrangedSubviews: fruitsViews)
                stackView.axis = .horizontal
                stackView.distribution = .fillEqually
                
                // autolayout constraint
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                
                addSubview(stackView)
                
                NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 13),
                                             stackView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -8)])
            default:
                let distribution = UIStackView.Distribution.equalSpacing
                
                //                print("let firstStackView = UIStackView(arrangedSubviews: Array(fruitsViews[0...\(fruitsCount - Int(fruitsCount/2) - 1)])")
                
                let firstStackView = UIStackView(arrangedSubviews: Array(fruitsViews[0...fruitsCount - Int(fruitsCount/2) - 1]))
                firstStackView.axis = .horizontal
                firstStackView.distribution = distribution
                firstStackView.spacing = 1
                
                //                print("let secondStackView = UIStackView(arrangedSubviews: Array(fruitsViews[\(fruitsCount - Int(fruitsCount/2))...\(fruitsCount - 1)])")
                let secondStackView = UIStackView(arrangedSubviews: Array(fruitsViews[fruitsCount - Int(fruitsCount/2)...fruitsCount - 1]))
                secondStackView.axis = .horizontal
                secondStackView.distribution = distribution
                secondStackView.spacing = 2
                
                //            secondStackView.size
                
                let stackView = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
                stackView.axis = .vertical
                stackView.distribution = distribution
                stackView.alignment = .trailing
                
                
                // autolayout constraint
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                
                addSubview(stackView)
                
                NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 3),
                                             stackView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -8)])
            }
        }
        
        switch levelNumber {
        case 1...5:
            stackViewAppearance(cell, 3)
        case 6...9:
            stackViewAppearance(cell, 4)
        case 10...15:
            stackViewAppearance(cell, 5)
        case 16...20:
            stackViewAppearance(cell, 6)
        case 21...25:
            stackViewAppearance(cell, 7)
        case 26...30:
            stackViewAppearance(cell, 8)
        case 31...35:
            stackViewAppearance(cell, 9)
        case 36...40:
            stackViewAppearance(cell, 10)
        case 41...45:
            stackViewAppearance(cell, 11)
        default:
            stackViewAppearance(cell, 12)
        }
    }
    
    // MARK: - Adding starsStackView
    func addStarsStackView(_ cell: UICollectionViewCell, rate: Int) {
        var stars = [UIImageView]()
        for _ in 0..<rate {
            let goldStar = UIImageView()
            goldStar.image = UIImage(named: "ЗолотаяЗвезда")
            stars.append(goldStar)
        }
        
        for _ in 0..<5 - rate {
            let emptyStar = UIImageView()
            emptyStar.image = UIImage(named: "ПустаяЗвезда")
            stars.append(emptyStar)
        }
        
        let stackView = UIStackView(arrangedSubviews: stars)
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -6.11),
                                     stackView.centerXAnchor.constraint(equalTo: cell.centerXAnchor)])
    }
}
