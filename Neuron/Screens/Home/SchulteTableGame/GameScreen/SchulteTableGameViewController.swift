//
//  SchulteTableGameViewController.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol SchulteTableGameViewControllerDelegate {
  var settingsData : SchulteTableGameSettings! { get set }
  
  var currentCellIndex: Int { get set }
  
  var tableCollectionViewCellsData             : [tableCollectionViewCellData]! { get set }
  var tableCollectionViewCellsDataInRightOrder : [tableCollectionViewCellData]! { get set }
  
  var tableCollectionView : UICollectionView! { get set }
  
  func makeRestartButtonImage()
  func makeTimerLabel()
  func makeTableCollectionViewSize()
  func makeTableCollectionView()
  func makeNavBarTitle(for cellData: tableCollectionViewCellData)
  func returnNavBarTitle()
  func startTimer()
  func clearPopUp()
  func hidePopUp()
  func returnTimerValues()
  func makeTimer()
  
  func collectionViewSetting()
}

final class SchulteTableGameViewController: UIViewController, SchulteTableGameViewControllerDelegate {
  var configurator : SchulteTableGameConfigurator!
  var presenter    : SchulteTableGamePresenterDelegate!
  
  var settingsData : SchulteTableGameSettings!
  
  var tableCollectionViewCellsData              : [tableCollectionViewCellData]!
  var tableCollectionViewCellsDataInRightOrder  : [tableCollectionViewCellData]!
  static var currentTableCollectionViewCellData : tableCollectionViewCellData!
  
  var currentCellIndex = 0
  
  var cellsNumbers : [Int]!
  
  var timer        : Timer!
  var minutes      : Int!
  var seconds      : Int!
  var milliseconds : Int!
  
  var popUp                  : FluidCardView?                   = nil
  var visualEffectNavBarView : CustomIntensityVisualEffectView? = nil
  var visualEffectView       : CustomIntensityVisualEffectView? = nil
  
  @IBOutlet weak var timerLabel          : UILabel!
  @IBOutlet weak var restartButton       : UIBarButtonItem!
  @IBOutlet weak var tableCollectionView : UICollectionView!
  @IBOutlet var stars                    : [UIImageView]!
  
  @IBOutlet weak var tableCollectionViewTrailingConstraint : NSLayoutConstraint!
  @IBOutlet weak var tableCollectionViewLeadingConstraint  : NSLayoutConstraint!
}

// MARK: - Life Cycle

extension SchulteTableGameViewController {
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = SchulteTableGameConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidload()
  }
  
  // MARK: - viewWillAppear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.viewWillAppear()
  }
  
  // MARK: - willMove
  override func willMove(toParent parent: UIViewController?) {
    super.willMove(toParent: parent)
    /*
     * Из-за того, что эта
     * функция вызывается до
     * инициализации класса,
     * то презентера еще не
     * существует и поэтому логика
     * не может быть вынесена в него
     */
    self.returnNavBarTitle()
    
    let visualEffectNavBarView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 0.2)
    self.navigationController?.navigationBar.addSubview(visualEffectNavBarView)
  }
}

// MARK: - Timer

extension SchulteTableGameViewController {
  
  // MARK: - startTimer
  func startTimer() {
    self.minutes      = 0
    self.seconds      = 0
    self.milliseconds = 0
    self.timer        = Timer.scheduledTimer(timeInterval : 1/10,
                                             target       : self,
                                             selector     : #selector(self.timerSelectorMethod),
                                             userInfo     : nil,
                                             repeats      : true)
  }
  
  // MARK: - @objc timer
  @objc func timerSelectorMethod() {
    self.milliseconds += 100
    
    if self.milliseconds / 100 == 10 {
      self.seconds += 1
      self.milliseconds = 0
    }
    
    if self.seconds == 60 {
      self.minutes += 1
      self.seconds = 0
    }
    
    if self.minutes == 60 {
      self.invalidateTimer(for: .error)
    }
    
    let minutes      = self.minutes < 10 ? "0\(self.minutes!)" : "\(self.minutes!)"
    let seconds      = self.seconds < 10 ? "0\(self.seconds!)" : "\(self.seconds!)"
    let milliseconds = self.milliseconds / 100
    
    self.timerLabel.text = "\(minutes).\(seconds).\(milliseconds)"
    self.timerLabel.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
  }
  
  // MARK: - invalidateTimer
  func invalidateTimer(for gameFinishState: schulteTableGameFinishStates) {
    switch gameFinishState {
    case .error:
      self.timer.invalidate()
      self.changeTimerLabel()
    case .finish:
      self.timer.invalidate()
    }
  }
  
  enum schulteTableGameFinishStates {
    case error
    case finish
  }
}

// MARK: - UI Making Functions

extension SchulteTableGameViewController {
  
  // MARK: - makeRestartButtonImage
  func makeRestartButtonImage() {
    self.restartButton.image = #imageLiteral(resourceName: "Рестарт").withRenderingMode(.alwaysOriginal)
  }
  
  // MARK: - makeTimerLabel
  func makeTimerLabel() {
    self.timerLabel.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9)
  }

  // MARK: - makeTableCollectionViewSize
  func makeTableCollectionViewSize() {
    switch UIScreen.main.bounds.height {
    case 568: // iPhone SE
      self.tableCollectionViewLeadingConstraint.constant  = 0
      self.tableCollectionViewTrailingConstraint.constant = 0
    default:
      return
    }
  }
  
  // MARK: - makeTableCollectionView
  func makeTableCollectionView() {
    self.tableCollectionView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
  }
  
  // MARK: - makeNavBarTitle
  func makeNavBarTitle(for cellData: tableCollectionViewCellData) {
    let colors = ["blue": UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1),
                  "green": UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1),
                  "red": UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1)]
    
    let blueShades = [UIColor(red: 0.784, green: 0.839, blue: 0.967, alpha: 1),
                      UIColor(red: 0.176, green: 0.612, blue: 0.859, alpha: 1),
                      UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1),
                      UIColor(red: 0.358, green: 0.467, blue: 0.739, alpha: 1)]
    
    let greenShades = [UIColor(red: 0.788, green: 0.93, blue: 0.765, alpha: 1),
                       UIColor(red: 0.435, green: 0.812, blue: 0.592, alpha: 1),
                       UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1),
                       UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 1)]
    
    let redShades = [UIColor(red: 0.979, green: 0.82, blue: 0.82, alpha: 1),
                     UIColor(red: 1, green: 0.451, blue: 0.451, alpha: 1),
                     UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1),
                     UIColor(red: 0.801, green: 0.265, blue: 0.265, alpha: 1)]
    
    var navBarTitleFontColor: UIColor!
    
    /*
     * Цвет текста title у навбара
     * не должен иметь оттенков,
     * а только яркие основные цвета
     */
    
    if blueShades.contains(cellData.backgroundColor) {
      navBarTitleFontColor = colors["blue"]!
    } else if greenShades.contains(cellData.backgroundColor) {
      navBarTitleFontColor = colors["green"]!
    } else if redShades.contains(cellData.backgroundColor) {
      navBarTitleFontColor = colors["red"]!
    }
    
    let navBarTitleFont = UIFont(name: "NotoSans-Bold", size: 23)!

    self.navigationItem.title = "Looking for \(cellData.labelText)"
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                    NSAttributedString.Key.foregroundColor: navBarTitleFontColor!]
  }
  
  // MARK: - returnNavBarTitle
  func returnNavBarTitle() {
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSans-Bold", size: 23)!,
                                                                    NSAttributedString.Key.foregroundColor: UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9)]
  }
  
  // MARK: - changeTimerLabel
  func changeTimerLabel() {
    self.timerLabel.text      = "Wrong!"
    self.timerLabel.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 0.9)
  }
  
  // MARK: - highlight
  func highlight(cellWithText markedCellText: String) {
    self.tableCollectionView.backgroundColor = self.tableCollectionView.backgroundColor?.withAlphaComponent(0.25)
    
    self.tableCollectionView.visibleCells.forEach { (cell) in
      /*
       * Сначала у каждой ячейки понижаем
       * альфа фонового цвета и
       * цвета границы
       */
      
      cell.backgroundColor = cell.backgroundColor?.withAlphaComponent(0.25)
      cell.borderColor     = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.25).cgColor
      
      cell.subviews.forEach { (view) in
        guard type(of: view) == UILabel.self else { return }
        
        /*
         * Для всех ячеек
         * уменьшаем альфа у лэйбла
         */
        
        let label       = view as! UILabel
        label.textColor = label.textColor.withAlphaComponent(0.25)
        
        guard label.text! == markedCellText else { return }
        
        /*
         * А затем для нужной восстанавливаем
         * значения альфа у фонового цвета и
         * цвета текста лэйбла
         */
        
        cell.backgroundColor = cell.backgroundColor?.withAlphaComponent(1)
        label.textColor      = label.textColor.withAlphaComponent(1)
      }
    }
  }
  
  // MARK: - makeBlur
  func makeBlur() {
    let blurEffect = UIBlurEffect(style: .light)

    // NavBar Blur
    let visualEffectNavBarView = CustomIntensityVisualEffectView(effect: blurEffect, intensity: 0.2)
    visualEffectNavBarView.translatesAutoresizingMaskIntoConstraints = false
    visualEffectNavBarView.alpha = 0

    self.navigationController?.navigationBar.addSubview(visualEffectNavBarView)

    let topNavBarConstraint    = visualEffectNavBarView.topAnchor.constraint(equalTo: self.view.topAnchor)
    let rightNavBarConstraint  = visualEffectNavBarView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
    let bottomNavBarConstraint = visualEffectNavBarView.bottomAnchor.constraint(equalTo: self.navigationController!.navigationBar.bottomAnchor)
    let leftNavBarConstraint   = visualEffectNavBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor)

    NSLayoutConstraint.activate([topNavBarConstraint,
                                 rightNavBarConstraint,
                                 bottomNavBarConstraint,
                                 leftNavBarConstraint])

    self.visualEffectNavBarView = visualEffectNavBarView

    // View Blur Without NavBar
    let visualEffectView = CustomIntensityVisualEffectView(effect: blurEffect, intensity: 0.2)
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    visualEffectView.alpha = 0

    self.view.addSubview(visualEffectView)

    let topViewConstraint    = visualEffectView.topAnchor.constraint(equalTo: self.navigationController!.navigationBar.bottomAnchor)
    let rightViewConstraint  = visualEffectView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
    let bottomViewConstraint = visualEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    let leftViewConstraint   = visualEffectView.leftAnchor.constraint(equalTo: self.view.leftAnchor)

    NSLayoutConstraint.activate([topViewConstraint,
                                 rightViewConstraint,
                                 bottomViewConstraint,
                                 leftViewConstraint])
    
    self.visualEffectView = visualEffectView

    UIView.animate(withDuration: 0.6, animations: {
      visualEffectNavBarView.alpha = 1
      visualEffectView.alpha = 1
    }, completion: { finished in
      self.makePopUp()
    })
  }
  
  // MARK: - makePopUp
  func makePopUp() {
    let popUp = FluidCardView(frame: CGRect(x: 0, y: 0, width: 297, height: 297))
    
    popUp.translatesAutoresizingMaskIntoConstraints = false
    
    let topView    = SchulteTableGamePopUpTopView(frame: CGRect(x: 0, y: 0, width: 297, height: 189))
    let bottomView = SchulteTableGamePopUpBottomView(frame: CGRect(x: 0, y: 0, width: 297, height: 104))
    
    popUp.topContentView    = topView
    popUp.bottomContentView = bottomView
    
    self.configurator.configure(topView)
    self.configurator.configure(bottomView)
    
    self.popUp = popUp
    
    self.view.addSubview(popUp)

    let topViewConstraint     = popUp.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 204)
    let widthViewConstraint   = popUp.widthAnchor.constraint(equalToConstant: 297)
    let centerXViewConstraint = popUp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)

    NSLayoutConstraint.activate([topViewConstraint, widthViewConstraint, centerXViewConstraint])
  }
  
  // MARK: clearPopUp
  func clearPopUp() {
    self.visualEffectNavBarView!.removeFromSuperview()
    self.visualEffectView!.removeFromSuperview()
    self.popUp!.removeFromSuperview()
  }
  
  // MARK: - hidePopUp
  func hidePopUp() {
    self.visualEffectNavBarView!.alpha = 0
    self.visualEffectView!.alpha       = 0
    self.popUp!.alpha                  = 0
  }
  
  // MARK: - returnTimerValues
  func returnTimerValues() {
    self.minutes      = 0
    self.seconds      = 0
    self.milliseconds = 0
  }
  
  // MARK: - makeTimer
  func makeTimer() {
    self.invalidateTimer()
    self.makeTimerLabel()
    self.startTimer()
  }
  
  // MARK: - invalidateTimer
  func invalidateTimer() {
    self.timer.invalidate()
  }
}

// MARK: - UICollectionView functions

extension SchulteTableGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // MARK: - tableCollectionView Delegate And DataSource
  func collectionViewSetting() {
    self.tableCollectionView.delegate   = self
    self.tableCollectionView.dataSource = self
  }
  
  // MARK: - Number Of Items In Section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    return cellsCount[self.settingsData.levelNumber]!
  }
  
  // MARK: - Cell For Item At
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    SchulteTableGameViewController.currentTableCollectionViewCellData = self.tableCollectionViewCellsData[indexPath.row]
    self.tableCollectionView.register(SchulteTableGameTableCollectionViewCell.self, forCellWithReuseIdentifier: "cell\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell\(indexPath.row)", for: indexPath) as! SchulteTableGameTableCollectionViewCell
    
    /*
     * cell.setup() вызывается потому что
     * по какой-то причине в классе
     * SchulteTableGameTableCollectionViewCell не происходит
     * повторная инициализация при вызове tableCollectionView.reloadData()
     * и необходимо вручную пересоздавать UI каждой ячейки
     */
    
    cell.setup()
    return cell
  }
  
  // MARK: - Cells Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellsDimension: [Int: CGFloat] = [1: 3, 2: 4, 3: 5, 4: 6, 5: 7, 6: 8, 7: 9]
    let tableCollectionViewDimension   = self.tableCollectionView.frame.size.width
    let currentLevelNumber             = self.settingsData.levelNumber
    let currentLevelCellsDimension     = tableCollectionViewDimension / cellsDimension[currentLevelNumber]! - 0.1
    
    return CGSize(width: currentLevelCellsDimension, height: currentLevelCellsDimension)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! SchulteTableGameTableCollectionViewCell
    
    cell.subviews.forEach { (view) in
      guard type(of: view) == UILabel.self else { return }
      
      let label = view as! UILabel
      
      switch label.text! == self.tableCollectionViewCellsDataInRightOrder[self.currentCellIndex].labelText {
      case true:
        self.currentCellIndex += 1
        
        // Обрабатываем indexOutOfRange
        let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
        guard self.currentCellIndex != cellsCount[self.settingsData.levelNumber] else { self.invalidateTimer(for: .finish); self.makeBlur(); return }
        
        self.makeNavBarTitle(for: self.tableCollectionViewCellsDataInRightOrder[self.currentCellIndex])
      case false:
        self.invalidateTimer(for: .error)
        self.highlight(cellWithText: self.tableCollectionViewCellsDataInRightOrder[self.currentCellIndex].labelText)
      }
    }
  }
}
