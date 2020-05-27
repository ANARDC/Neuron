//
//  FruitsGamePresenter.swift
//  Neuron
//
//  Created by Anar on 16/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

// MARK: - PresenterDelegate
protocol FruitsGamePresenterDelegate: class {
  func viewDidLoad()
  func viewDidDisappear()
  func fillGameFruits(for fruit: Fruits)
  func restartGame()
  func startNextLevel()
  func startNewGame(choosenLevelNumber: Int)
}

// MARK: - FruitsGamePresenter
final class FruitsGamePresenter: FruitsGamePresenterDelegate {
  var view: FruitsGameViewDelegate?
  var model: FruitsGameModel?

  init(view: FruitsGameViewDelegate, model: FruitsGameModel) {
    self.view = view
    self.model = model
  }

  // MARK: viewDidLoad()
  func viewDidLoad() {
    self.view?.makeRestartButtonImage()
    self.view?.makeNavBarTitle()
    self.view?.makeMenuFruits(typesCount: 3+Int((FruitsGameViewController.levelNumber-1)/5))
    self.view?.makeGameFruits(typesCount: 3+Int((FruitsGameViewController.levelNumber-1)/5))
    self.view?.makeFruitMenuView()
    self.view?.makeTimerLabel()
    self.view?.makeStarsStackView(rate: 5)
    self.view?.startTimer(seconds: 4)
    /*
     * Пока фрукты у нас не скрыты
     * мы не даем доступа к фруктам
     * меню для пользователя
     */
    self.view?.switchMenuFruitsViewsUserInteractionState(for: self.view!.menuFruitsViews)
    self.model?.fruitsDataCore.getFruitsGameData().forEach({ (session) in
      print(session)
    })
  }
  
  func viewDidDisappear() {
    if let visualEffectNavBarView = self.view!.visualEffectNavBarView {
      visualEffectNavBarView.constraints.forEach { $0.isActive = false }
      visualEffectNavBarView.removeFromSuperview()
    }
  }
  
  // MARK: - fillGameFruits()
  func fillGameFruits(for fruit: Fruits) {
    var localCurrentFruitIndex = 0
    
    // Корректируем значение указателя (currentFruitIndex) так чтобы можно было двигаться по фруктам справа налево
    // Проверяем входит ли индекс текущего фрукта в диапазоны [9...16], [27...34], [45...52]
    if [9, 27, 45].contains(self.view!.globalCurrentFruitIndex - 7 + self.view!.gameFruitsFillingTerm) {
      // В зависимости от оставшегося количества фруктов задаем размер прыжка
      if [9, 27, 45].contains(self.view!.globalCurrentFruitIndex) {
        let preFruitsCount = FruitsGameViewController.levelNumber + 7
        let fruitsCount = preFruitsCount <= 53 ? preFruitsCount : 53
        let lastFruitsCount = fruitsCount - self.view!.globalCurrentFruitIndex
        
        self.view!.gameFruitsFillingJump = lastFruitsCount > 8 ? 7 : lastFruitsCount - 1
      }
      // Присваиваем currentFruitIndex нужное значение
      localCurrentFruitIndex = self.view!.globalCurrentFruitIndex + self.view!.gameFruitsFillingJump
      // Уменьшаем шаг на 2 во всех случаях
      self.view!.gameFruitsFillingJump -= 2
      // Чтобы не выходить за рамки [9...16], [27...34], [45...52] останавливаем вычитание в проверке выше
      self.view!.gameFruitsFillingTerm -= self.view!.gameFruitsFillingTerm > 0 ? 1 : 0
    } else if [17, 35].contains(self.view!.globalCurrentFruitIndex) {
      // Присваиваем currentFruitIndex нужное значение
      localCurrentFruitIndex = self.view!.globalCurrentFruitIndex
      // Установка значений
      self.view!.gameFruitsFillingJump = 7
      self.view!.gameFruitsFillingTerm = 7
    } else {
      // Присваиваем currentFruitIndex нужное значение
      localCurrentFruitIndex = self.view!.globalCurrentFruitIndex
    }
    
    // Проверяем верно ли тапнул юзер
    guard self.view!.gameFruits[localCurrentFruitIndex] == fruit else {
      self.view!.invalidateTimer()
      self.view!.changeTimerLabel()
      /*
       * Когда юзер ошибся
       * выключаем доступ
       * к меню фруктов
       */
      self.view!.switchMenuFruitsViewsUserInteractionState(for: self.view!.menuFruitsViews)
      self.view!.gamePassed = false
      
      // Получаем текущий фрукт в змейке (!!!)
      let currentGameFruit = self.view!.gameFruitsViews[localCurrentFruitIndex]
      
      let errorFruitView = UIImageView()
      errorFruitView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
      errorFruitView.image = #imageLiteral(resourceName: "Неправильный фрукт")
      
      // Меняем серый крестик на красный
      currentGameFruit.subviews.last?.removeFromSuperview()
      currentGameFruit.addSubview(errorFruitView)
      
      /*
       * Так как сюда мы попадаем только если
       * пользователь неправильно ввел фрукт, то
       * нам необходимо довыполнить необходимую
       * операцию self.globalCurrentFruitIndex += 1
       */
      self.view!.globalCurrentFruitIndex += 1
      // Меняем оставшиеся фрукты на красные крестики
      self.view!.makeRedCrosses()
      return
    }
    // Так как проверка пройдена, мы можем увеличить переменную filledFruitsCount
    self.view!.filledFruitsCount += 1
    
    // Получаем текущий фрукт в змейке (!!!)
    let currentGameFruit = self.view!.gameFruitsViews[localCurrentFruitIndex]
    
    // Убираем с него серую звезду
    currentGameFruit.subviews.last?.removeFromSuperview()
    currentGameFruit.subviews.last?.isHidden = false
    currentGameFruit.shadowOpacity = 1
    currentGameFruit.borderWidth = 1
    
    // Находим количество фруктов на данном уровне
    let preFruitsCount = FruitsGameViewController.levelNumber + 7
    let fruitsCount = preFruitsCount <= 53 ? preFruitsCount : 53
    
    // Если фрукт равен последнему в змейке (!!!), то заканчиваем
    switch fruitsCount {
    case 10...17: if currentGameFruit == self.view!.gameFruitsViews[9]   { self.finishGame() }
    case 28...35: if currentGameFruit == self.view!.gameFruitsViews[27]  { self.finishGame() }
    case 46...53: if currentGameFruit == self.view!.gameFruitsViews[45]  { self.finishGame() }
    default:      if currentGameFruit == self.view!.gameFruitsViews.last { self.finishGame() }
    }
    
    self.view!.globalCurrentFruitIndex += 1
  }
  
  // MARK: - finishGame()
  func finishGame() {
    // Сохраняем данные так как игра пройдена
    self.saveGameSession()
    
    self.view?.invalidateTimer()
    self.view?.makeBlur()
    /*
     * Когда игра закончена
     * выключаем доступ юзеру
     * к меню фруктов
     */
    self.view?.switchMenuFruitsViewsUserInteractionState(for: self.view!.menuFruitsViews)
    self.view?.gamePassed = true
    /*
     * Игра пройдена - значит
     * необходимо увеличить уровень доступа
     * если был пройден последний уровень
     */
    let fruitsGameAccessLevel = UserDefaults.standard.integer(forKey: "fruitsGameAccessLevel")
    if fruitsGameAccessLevel == FruitsGameViewController.levelNumber && fruitsGameAccessLevel <= 50 {
      self.view!.increaseAccessLevel()
    }
  }
  
  private func saveGameSession() {
    let gameSessionTime: Int32 = {
      let milliseconds          = self.view!.milliseconds
      let secondsToMilliseconds = 1_000 * self.view!.seconds
      let minutesToMilliseconds = 60_000 * self.view!.minutes
      return Int32(milliseconds + secondsToMilliseconds + minutesToMilliseconds)
    }()
    
    let filledFruits = self.view!.filledFruitsCount
    
    let fruitsTypes: Int16 = Int16(3+Int((FruitsGameViewController.levelNumber-1)/5))
    
    let rate = self.view!.rate
    
    let levelNumber = Int16(FruitsGameViewController.levelNumber)
    
    let currentDate: String = {
      let date             = Date()
      let formatter        = DateFormatter()
      formatter.dateFormat = "H:m:s.d.M.yyyy" // "18:35:10.17.10.2019"
      let currentDate      = formatter.string(from : date)
      
      return currentDate
    }()

    let fruitsGameSessionModel = FruitsGameSessionModel(time: gameSessionTime,
                                                        filledFruits: filledFruits,
                                                        fruitsTypes: fruitsTypes,
                                                        rate: rate,
                                                        levelNumber: levelNumber,
                                                        date: currentDate)
    self.model?.fruitsDataCore.saveFruitsGameData(fruitsGameSessionModel: fruitsGameSessionModel)
    print(fruitsGameSessionModel)
  }
  
  
  // MARK: - restartGame()
  func restartGame() {
    UIView.animate(withDuration: 0.6, animations: {
      if let gamePassed = self.view!.gamePassed, gamePassed {
        self.view!.hidePopUp()
      }
    }, completion: { finished in
      self.view!.returnTimerValues()
      self.view!.returnFillingValues()
      self.view!.clearFruits()
      self.view!.removeFruits()
      self.view!.makeFruits()
      self.view!.makeStarsStackView(rate: 5)
      self.view!.filledFruitsCount = 0
      
      // Логика рестарта
      if let gamePassed = self.view!.gamePassed {
        switch gamePassed {
        case true:
          /*
           * Если игра пройдена, то
           * убираем PopUp и Blur
           * перезагружаем таймер
           * TODO: - сохраняем данные
           * меняем gamePassed с true на nil
           */
          self.view!.clearPopUp()
          self.view!.makeTimer()
          self.view!.gamePassed = nil
          self.view!.fruitsIsHidden = false
        case false:
          /*
           * Если был нажат неверный фрукт, то
           * перезагружаем таймер
           * TODO: - сохраняем данные
           * меняем gamePassed с false на nil
           */
          self.view!.makeTimer()
          self.view!.gamePassed = nil
          self.view!.fruitsIsHidden = false
        }
      } else {
        switch self.view!.fruitsIsHidden {
        case true:
          /*
           * Если фрукты спрятаны, то
           * меняем свойство fruitsIsHidden
           * делаем таймер красным
           * ставим дефолтные значения измерений таймера
           */
          self.view!.fruitsIsHidden = false
          self.view!.makeTimerLabel()
          self.view!.minutes = 0
          self.view!.seconds = 4
          self.view!.milliseconds = 0
        case false:
          /*
           * Если фрукты еще видны, то
           * ставим дефолтные значения измерений таймера
           */
          self.view!.seconds = 4
          self.view!.milliseconds = 0
        }
      }
      
      /*
       * Так как доступ к меню
       * для пользователя чередуется,
       * то необходимо тут выключать
       * доступ перед рестартом
       */
      self.view!.disableMenuFruitsViews()
    })
  }
  
  #warning("Положи эти две функции в одну используя enum для states нажатия")
  // MARK: - startNextLevel()
  func startNextLevel() {
    /*
     * Эта функция срабатывает
     * только с окна PopUp,
     * поэтому убираем PopUp и Blur
     * перезагружаем таймер
     * TODO: - сохраняем данные
     * меняем gamePassed с true на nil,
     * но при этом еще меняем
     * уровень доступа
     */
    UIView.animate(withDuration: 0.6, animations: {
      self.view!.hidePopUp()
    }, completion: { finished in
      self.view!.returnTimerValues()
      self.view!.returnFillingValues()
      self.view!.clearFruits()
      self.view!.removeFruits()
      FruitsGameViewController.levelNumber += 1
      self.view!.makeFruits()
      self.view!.makeStarsStackView(rate: 5)
      self.view!.clearPopUp()
      self.view!.makeTimer()
      self.view!.makeNavBarTitle()
      self.view!.gamePassed = nil
      self.view!.fruitsIsHidden = false
      self.view!.disableMenuFruitsViews()
    })
  }
  
  // MARK: - startNewGame()
  func startNewGame(choosenLevelNumber: Int) {
    /*
     * Эта функция срабатывает
     * только с окна PopUp,
     * поэтому убираем PopUp и Blur
     * перезагружаем таймер
     * TODO: - сохраняем данные
     * меняем gamePassed с true на nil
     */
    UIView.animate(withDuration: 0.6, animations: {
      self.view!.hidePopUp()
    }, completion: { finished in
      self.view!.returnTimerValues()
      self.view!.returnFillingValues()
      self.view!.clearFruits()
      self.view!.removeFruits()
      FruitsGameViewController.levelNumber = choosenLevelNumber
      self.view!.makeFruits()
      self.view!.makeStarsStackView(rate: 5)
      self.view!.clearPopUp()
      self.view!.makeTimer()
      self.view!.makeNavBarTitle()
      self.view!.gamePassed = nil
      self.view!.fruitsIsHidden = false
      self.view!.disableMenuFruitsViews()
    })
  }
}
