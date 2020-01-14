//
//  PrefixPostfix.swift
//  Neuron
//
//  Created by Anar on 05.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

public postfix func ++<T: Numeric>(_ value: inout T) { value += 1 }

public postfix func --<T: Numeric>(_ value: inout T) { value -= 1 }

//infix operator +-=: AdditionPrecedence
//public func +-=<T: Numeric> (left: inout T, right: T) { left += right }
