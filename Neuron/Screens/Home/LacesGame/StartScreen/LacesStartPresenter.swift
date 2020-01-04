//
//  Presenter.swift
//  Neuron
//
//  Created by Anar on 02.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

// MARK: - protocol
protocol LacesStartPresenterDelegate {
  func viewDidLoad()
  func viewWillAppear()
  func viewDidLayoutSubviews()
  func startGame()
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
  func startGame() {
    guard self.view!.settingsIsReady else { return }
    self.view?.goToGameScreen()
  }
}
