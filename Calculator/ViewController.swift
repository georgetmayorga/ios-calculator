//
//  ViewController.swift
//  Calculator
//
//  Created by George T Mayorga on 7/25/15.
//  Copyright (c) 2015 Friendly Mega Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
//    input from numbers
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
//    define array that will hold memory of inputs...stack
    var operandStack = Array<Double>()
    
//    what happens when you hit enter
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("stack = \(operandStack)")
    }
    
//    this converts the string into a double and sets a double as a string
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
    
//    passing a function (operation) to a function (performOperation), that passed in function named operation takes 2 doubles and returns a double
    func binaryOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func unaryOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

//    we call perform operation and send it anonymous variables somehow, type is inferred
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        let operation = sender.currentTitle!
        switch operation {
        case "×": binaryOperation {$0 * $1}
        case "÷": binaryOperation {$1 / $0}
        case "+": binaryOperation {$1 - $0}
        case "√": unaryOperation { sqrt($0) }
        default: break
        }
    }
}

