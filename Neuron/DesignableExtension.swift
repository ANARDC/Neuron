//
//  DesignableExtension.swift
//  Neuron
//
//  Created by Anar on 17/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Радиус скругления
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    
    /// Ширина границы
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    /// Цвет границы
    @IBInspectable var borderColor: CGColor? {
        set { layer.borderColor = newValue  }
        get { return layer.borderColor! }
    }
    
    /// Смещение тени
    @IBInspectable var shadowOffset: CGSize {
        set { layer.shadowOffset = newValue  }
        get { return layer.shadowOffset }
    }
    
    /// Прозрачность тени
    @IBInspectable var shadowOpacity: Float {
        set { layer.shadowOpacity = newValue }
        get { return layer.shadowOpacity }
    }
    
    /// Радиус блура тени
    @IBInspectable var shadowRadius: CGFloat {
        set { layer.shadowRadius = newValue }
        get { return layer.shadowRadius }
    }
    
    /// Цвет тени
    @IBInspectable var shadowColor: CGColor {
        set { layer.shadowColor = newValue }
        get { return layer.shadowColor! }
    }
    
    /// Отсекание по границе
    @IBInspectable var _clipsToBounds: Bool {
        set { clipsToBounds = newValue }
        get { return clipsToBounds }
    }
}
