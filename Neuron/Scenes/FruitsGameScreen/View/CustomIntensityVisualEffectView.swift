//
//  CustomIntensityVisualEffectView.swift
//  Neuron
//
//  Created by Anar on 22/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class CustomIntensityVisualEffectView: UIVisualEffectView {
  /* Создание вида визуального эффекта с заданным эффектом и его интенсивностью
   *
   * - Параметры:
   *   - effect: визуальный эффект, например: UIBlurEffect(style: .dark)
   *   - intensity: пользовательская интенсивность
   *                от 0.0 (без эффекта) до 1.0 (полный эффект)
   *                с использованием линейной шкалы
   */
  init(effect: UIVisualEffect, intensity: CGFloat) {
    super.init(effect: nil)
    animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in self.effect = effect }
    animator.fractionComplete = intensity
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  // MARK: Private
  private var animator: UIViewPropertyAnimator!
}
