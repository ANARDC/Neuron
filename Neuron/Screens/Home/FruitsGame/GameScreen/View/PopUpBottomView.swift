//
//  PopUpBottomView.swift
//  Neuron
//
//  Created by Anar on 22/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class PopUpBottomView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    print("I was here, lol --------------")
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func loadFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "BottomView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
  
  func setup() {
    let view = loadFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    addSubview(view)
  }
}
