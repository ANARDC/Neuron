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
    @IBOutlet weak var starsStackView: UIStackView!
    
    static var levelNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.image = UIImage(named: "Рестарт")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        addNavBarTitle()
        addStarsStackView(rate: 5)
    }
}

// MARK: - Customize Functions

extension FruitsGameViewController {
    func addNavBarTitle() {
        self.navigationItem.title = "Level \(FruitsGameViewController.levelNumber)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSans-Bold", size: 23)!, NSAttributedString.Key.foregroundColor: UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)]
    }
    
    func addStarsStackView(rate: Int) {
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
        
        if let myView = starsStackView.subviews.first {
            starsStackView.removeArrangedSubview(myView)
            starsStackView.setNeedsLayout()
            starsStackView.layoutIfNeeded()
            
            starsStackView.insertArrangedSubview(myView, at: starsStackView.subviews.count - 1)
            starsStackView.setNeedsLayout()
        }
    }
}
