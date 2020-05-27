//
//  File.swift
//  Neuron
//
//  Created by Anar on 02/08/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class AddNoteCellButton: UIButton {
  
  // MARK: - Class Properties
  @IBInspectable var fillColor: UIColor = UIColor.clear
  var isAddButton: Bool = true
  
  // MARK: - Customize functions
  // Adding dashed border
  func addDashedBorder(_ rect: CGRect) {
    let color = UIColor.lightGray.cgColor
    
    let shapeLayer: CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    //        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
    let shapeRect = rect
    
    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6, 3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 15).cgPath
    
    self.layer.addSublayer(shapeLayer)
  }
  
  // Here drawing of plus
  private struct Constants {
    static let plusLineWidth: CGFloat = 3.0
    static let plusButtonScale: CGFloat = 0.3
    static let halfPointShift: CGFloat = 0.5
  }
  
  private var halfWidth: CGFloat {
    return bounds.width / 2
  }
  
  private var halfHeight: CGFloat {
    return bounds.height / 2
  }
  
  func addPlus(_ rect: CGRect) {
    let path = UIBezierPath(ovalIn: rect)
    fillColor.setFill()
    path.fill()
    
    // set up the width and height variables
    // for the horizontal stroke
    let plusWidth: CGFloat = min(bounds.width, bounds.height) * Constants.plusButtonScale
    let halfPlusWidth = plusWidth / 2
    
    // create the path
    let plusPath = UIBezierPath()
    
    // set the path's line width to the height of the stroke
    plusPath.lineWidth = Constants.plusLineWidth
    
    // move the initial point of the path
    //to the start of the horizontal stroke
    plusPath.move(to: CGPoint(
      x: halfWidth - halfPlusWidth + Constants.halfPointShift,
      y: halfHeight + Constants.halfPointShift))
    
    // add a point to the path at the end of the stroke
    plusPath.addLine(to: CGPoint(
      x: halfWidth + halfPlusWidth + Constants.halfPointShift,
      y: halfHeight + Constants.halfPointShift))
    
    if isAddButton {
      // Vertical stroke
      plusPath.move(to: CGPoint(
        x: halfWidth + Constants.halfPointShift,
        y: halfHeight - halfPlusWidth + Constants.halfPointShift))
      
      plusPath.addLine(to: CGPoint(
        x: halfWidth + Constants.halfPointShift,
        y: halfHeight + halfPlusWidth + Constants.halfPointShift))
    }
    
    //set the stroke color
    UIColor.lightGray.setStroke()
    plusPath.stroke()
  }
  
  override func draw(_ rect: CGRect) {
    addDashedBorder(rect)
    addPlus(rect)
  }
}
