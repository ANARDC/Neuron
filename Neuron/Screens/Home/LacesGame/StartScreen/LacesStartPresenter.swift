//
//  Presenter.swift
//  Neuron
//
//  Created by Anar on 02.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

// MARK: - protocol
protocol LacesStartPresenterDelegate {
  func viewDidLoad()
  func viewWillAppear()
  func viewDidLayoutSubviews()
  
  func startGame(levelNumber: Int)
  func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

// MARK: - class
final class LacesStartPresenter: LacesStartPresenterDelegate {
  var view: LacesStartViewControllerDelegate?
  
  init(view: LacesStartViewControllerDelegate) {
    self.view = view
  }
  
  // MARK: - viewDidLoad
  func viewDidLoad() {
    self.view?.navBarSetting()
    self.view?.makeNavBarTitle()
    self.view?.makeRulesTitleLabel()
    self.view?.makeRulesTextView()
    self.view?.makeSeparatorView()
    self.view?.makeWarningTextView()
    self.view?.makeLevelsTitleLabel()
    self.view?.makeLevelsCollectionView()
    self.view?.makeChooseBackgroundView()
    self.view?.makeChooseViewLabel()
  }
  
  // MARK: - viewWillAppear
  func viewWillAppear() {
    self.view?.hideTabBar()
  }
  
  // MARK: - viewDidLayoutSubviews
  func viewDidLayoutSubviews() {
    self.view?.raiseTextViewsTextContent()
  }
}

// MARK: - Start Game

extension LacesStartPresenter {
  
  // MARK: - startGame
  func startGame(levelNumber: Int) {
    guard self.view!.settingsIsReady else { return }
    self.view?.goToGameScreen(levelNumber: levelNumber)
  }
  
  // MARK: - prepareSegue
  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "startLacesGameSegue" else { return }
    
    if let levelNumber = sender as? Int {
      let destination = segue.destination as! LacesGameViewController
      destination.levelNumber = levelNumber
    }
  }
}
