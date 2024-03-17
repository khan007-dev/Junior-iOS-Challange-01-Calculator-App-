//
//  Calculator.swift
//  CalculatorApp
//
//  Created by Khan on 17.03.2024.
//

import Foundation


class Calculator: ObservableObject {
    
    // Update the UI
    @Published var displayValue = "100"
    
    // Store the Current Operator
    var currrentOp: Operator?
    
    // Current number selected
    var currentNumber: Double? = 0
    
    // previous number selected
    var previousNumber: Double? = 0
    
    // Flag for equal press
    var equaled = false
    
    // How many decimal places have been typed
    var decimalPlace = 0
    
    
    // selects the appropriate function based on the label of the button pressed
    
    func buttonPressed(lable: String) {
        
        if lable == "CE" {
            displayValue =  ""
            reset()
        } else if lable == "=" {
            equalsClicked()
        } else if lable == "." {
            decimalclicked()
        } else if let value = Double(lable) {
            
            numberPressed(value: value)
        } else {
            operatorPressed(op: Operator(lable))
        }
    }
    
    func setDisplayValue( number: Double) {
        
        
        // Don't display a decimal if the number is an integer
        
        if number == floor(number) {
            displayValue = "\(Int(number))"
            
            // Otherweise, display the decimal
        } else {
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(10, decimalPlaces)) / pow(10,decimalPlaces))"
        }
      
        
    }
    // reset the state of the calculator
    func reset() {
        
        currrentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
   
        
    }
    // returns true if division 0 could happen
    func checkForDevision()  -> Bool{
        
        if currrentOp!.isDivision && (currentNumber == nil && previousNumber == 0) || currentNumber == 0{
            
            displayValue = "Error"
            reset()
            return true
        }
        return false
    }
    
    func equalsClicked() {
        
        
        // Check if we have an operation to perfom
        
        if currrentOp != nil {
            
            // Reset the decimal place for th current number
            decimalPlace = 0
            
            // Guard for division by 0
            
            if  checkForDevision() {
                return
            }
            
            // Check if we have at least one operand
            if currentNumber != nil || previousNumber != nil {
                
                // Compute the total
                let total = currrentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                // Update the first operatnd
                if currentNumber == nil {
                    currentNumber = previousNumber
                }
                // Update the second operand
                previousNumber = total
                
                // set the equaled flag
                equaled = true
                // Update the UI
                
                setDisplayValue(number: total)
            }
        }
    }
    
    func decimalclicked() {
        
        // if equals was pressed, reset the current numbers
        
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        // if a "." was typed fires, wet the current number
        if currentNumber == nil {
            currentNumber = 0
        }
        
        // set the decimal place
        decimalPlace = 1
        
        // update the UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    
    func numberPressed(value: Double) {
        
        if equaled  {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        // If there is no current number, set it to the value
        
        if currentNumber == nil {
            
            currentNumber  = value / pow(10, decimalPlace)
            // Otherwise, add the value to the current number
        } else {
            // if no decimal was typed, add the value as the last digit of the number
            
            if  decimalPlace == 0  {
                currentNumber = currentNumber! * 10 + value
                
                // Otherwise, add the value as the last decimal of th number
            } else {
                currentNumber = currentNumber! + value / pow(10, decimalPlace)
                decimalPlace += 1
            }
        }
      
        // Update the UI
        
        setDisplayValue(number: currentNumber!)
    }
    
    func operatorPressed(op: Operator) {
        
        // Reset the decimal
        decimalPlace = 0
        
        // if equals was pressed, reset the current number
        
        if equaled {
            currentNumber = nil
            equaled = false
        }
        
        // if we have two operand, comput sum
        
        if currentNumber != nil && previousNumber != nil {
            if checkForDevision() { return }
            let total = currrentOp!.op(previousNumber!, currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            // Update the UI
            setDisplayValue(number: total)
            
            // if only one number has been given, move it to the second operand
        } else if  previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }
        
        currrentOp = op
    }
    
}

func pow(_ base: Int, _ exp: Int) -> Double {
    
    return pow(Double(base), Double(exp))
    
}
