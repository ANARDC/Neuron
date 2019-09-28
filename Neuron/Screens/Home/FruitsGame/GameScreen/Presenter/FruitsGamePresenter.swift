//
//  FruitsGamePresenter.swift
//  Neuron
//
//  Created by Anar on 16/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol FruitsGamePresenterDelegate: class {
  func viewDidLoad()
  func viewDidDisappear()
  func fillGameFruits(for fruit: Fruits)
}

final class FruitsGamePresenter: FruitsGamePresenterDelegate {
  var view: FruitsGameViewDelegate?

  init(view: FruitsGameViewDelegate) {
    self.view = view
  }

  func viewDidLoad() {
    view?.makeRestartButtonImage()
    view?.makeNavBarTitle()
    view?.makeMenuElements(typesCount: 3+Int((FruitsGameViewController.levelNumber-1)/5))
    view?.makeGameFruits(typesCount: 3+Int((FruitsGameViewController.levelNumber-1)/5))
    view?.makeFruitMenuView()
    view?.makeTimerLabel()
    view?.makeStarsStackView(rate: 5)
    view?.startTimer(seconds: 1)
    view?.switchMenuFruitsViewsUserInteractionState(for: view!.menuFruitsViews)
  }
  
  func viewDidDisappear() {
    view!.visualEffectNavBarView.constraints.forEach { $0.isActive = false }
    view!.visualEffectNavBarView.removeFromSuperview()
  }
  
  func fillGameFruits(for fruit: Fruits) {
    
    view?.makeBlur()
    var localCurrentFruitIndex = 0
    
    // Корректируем значение указателя (currentFruitIndex) так чтобы можно было двигаться по фруктам справа налево
    // Проверяем входит ли индекс текущего фрукта в диапазоны [9...16], [27...34], [45...52]
    if [9, 27, 45].contains(view!.globalCurrentFruitIndex - 7 + view!.gameFruitsFillingTerm) {
      // В зависимости от оставшегося количества фруктов задаем размер прыжка
      if [9, 27, 45].contains(view!.globalCurrentFruitIndex) {
        let preFruitsCount = FruitsGameViewController.levelNumber + 7
        let fruitsCount = preFruitsCount <= 53 ? preFruitsCount : 53
        let lastFruitsCount = fruitsCount - view!.globalCurrentFruitIndex
        
        view!.gameFruitsFillingJump = lastFruitsCount > 8 ? 7 : lastFruitsCount - 1
      }
      // Присваиваем currentFruitIndex нужное значение
      localCurrentFruitIndex = view!.globalCurrentFruitIndex + view!.gameFruitsFillingJump
      // Уменьшаем шаг на 2 во всех случаях
      view!.gameFruitsFillingJump -= 2
      // Чтобы не выходить за рамки [9...16], [27...34], [45...52] останавливаем вычитание в проверке выше
      view!.gameFruitsFillingTerm -= view!.gameFruitsFillingTerm > 0 ? 1 : 0
    } else if [17, 35].contains(view!.globalCurrentFruitIndex) {
      // Присваиваем currentFruitIndex нужное значение
      localCurrentFruitIndex = view!.globalCurrentFruitIndex
      // Установка значений
      view!.gameFruitsFillingJump = 7
      view!.gameFruitsFillingTerm = 7
    } else {
      // Присваиваем currentFruitIndex нужное значение
      localCurrentFruitIndex = view!.globalCurrentFruitIndex
    }
    
    //        print(localCurrentFruitIndex)
    
    
    // Проверяем верно ли тапнул юзер
    guard view!.gameFruits[localCurrentFruitIndex] == fruit else {
      view?.invalidateTimer()
      view?.changeTimerLabel()
      view?.switchMenuFruitsViewsUserInteractionState(for: view!.menuFruitsViews)
      
      // Меняем текущий фрукт на красный крестик
      let currentGameFruit = view!.gameFruitsViews[localCurrentFruitIndex]
      
      let errorFruitView = UIImageView()
      errorFruitView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
      errorFruitView.image = #imageLiteral(resourceName: "Неправильный фрукт")
      
      currentGameFruit.subviews.last?.removeFromSuperview()
      currentGameFruit.addSubview(errorFruitView)
      
      
      /* Так как сюда мы попадаем только если
       * пользователь неправильно ввел фрукт, то
       * нам необходимо довыполнить необходимую
       * операцию self.globalCurrentFruitIndex += 1
       */
      view!.globalCurrentFruitIndex += 1
      // Меняем оставшиеся фрукты на красные крестики
      view?.makeRedCrosses()
      return
    }
    
    let currentGameFruit = view!.gameFruitsViews[localCurrentFruitIndex]
    
    currentGameFruit.subviews.last?.removeFromSuperview()
    currentGameFruit.subviews.last?.isHidden = false
    currentGameFruit.shadowOpacity = 1
    currentGameFruit.borderWidth = 1
    
    
    let preFruitsCount = FruitsGameViewController.levelNumber + 7
    let fruitsCount = preFruitsCount <= 53 ? preFruitsCount : 53
    
    switch fruitsCount {
    case 10...17:
      if currentGameFruit == view!.gameFruitsViews[9] {
        view?.invalidateTimer()
        view?.makeBlur()
        view?.switchMenuFruitsViewsUserInteractionState(for: view!.menuFruitsViews)
      }
    case 28...35:
      if currentGameFruit == view!.gameFruitsViews[27] {
        view?.invalidateTimer()
        view?.makeBlur()
        view?.switchMenuFruitsViewsUserInteractionState(for: view!.menuFruitsViews)
      }
    case 46...53:
      if currentGameFruit == view!.gameFruitsViews[45] {
        view?.invalidateTimer()
        view?.makeBlur()
        view?.switchMenuFruitsViewsUserInteractionState(for: view!.menuFruitsViews)
      }
    default:
      if currentGameFruit == view!.gameFruitsViews.last {
        view?.invalidateTimer()
        view?.makeBlur()
        view?.switchMenuFruitsViewsUserInteractionState(for: view!.menuFruitsViews)
      }
    }
    
    view!.globalCurrentFruitIndex += 1
  }
}
