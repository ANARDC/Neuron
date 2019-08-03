//
//  DesignableExtension.swift
//  Neuron
//
//  Created by Anar on 17/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

// MARK: - IBInspectable properties of UIView
extension UIView {
    
    // Радиус скругления
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    
    // Ширина границы
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    // Цвет границы
    @IBInspectable var borderColor: CGColor? {
        set { layer.borderColor = newValue  }
        get { return layer.borderColor! }
    }
    
    // Смещение тени
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
    
    // Прозрачность тени
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    
    // Радиус блура тени
    @IBInspectable var shadowRadius: CGFloat {
        set { layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    
    // Цвет тени
    @IBInspectable var shadowColor: CGColor {
        set { layer.shadowColor = newValue }
        get { return layer.shadowColor! }
    }
    
    // Отсекание по границе
    @IBInspectable var _clipsToBounds: Bool {
        set { clipsToBounds = newValue }
        get { return clipsToBounds }
    }
}

// MARK: - Extension of UIScrollView to work touchesBegan method
extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}

// MARK: - Design of NavigationBar
final class BarDesign {
    func customizeNavBar(navigationController: UINavigationController?, navigationItem: UINavigationItem?) {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Назад")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Назад")
        navigationItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func makeNavigationBarTranslucent(navigationController: UINavigationController?) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
