//
//  FruitsGamePopUpTopView.swift
//  Neuron
//
//  Created by Anar on 15/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class FruitsGamePopUpTopView: UIView {
  var presenter   : FruitsGamePresenterProtocol?
  var accessLevel : Int!
  
  @IBOutlet weak var statusLabel   : UILabel!
  @IBOutlet var stars              : [UIImageView]!
  @IBOutlet weak var timerLabel    : UILabel!
  @IBOutlet weak var separatorView : UIView!
  @IBOutlet weak var retryButton   : UIButton!
  @IBOutlet weak var nextButton    : UIButton!
  
  @IBAction func retryButton(_ sender: UIButton) {
    self.presenter?.restartGame()
  }
  
  @IBAction func nextButton(_ sender: UIButton) {
    self.presenter?.startNextLevel()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    let view = loadFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    self.addSubview(view)
    
    self.separatorView.cornerRadius = 2
  }
  
  func loadFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "FruitsGamePopUpTopView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
}
