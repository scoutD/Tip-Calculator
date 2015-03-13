//
//  ViewController.swift
//  tip calculator
//
//  Created by Susannah on 2/11/15.
//  Copyright (c) 2015 Susannah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    
    //NSDecimalNumber constants used in the calculateTip method
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Select inputTextField so keypad displays when the view loads
        inputTextField.becomeFirstResponder()
        
    }
    
    
    
    
    
    @IBAction func calculateTip(sender: AnyObject){
        let inputString = inputTextField.text //get user input
        
        //convert slider value to an NSDecimalNumber
        let sliderValue = NSDecimalNumber(integer: Int(customTipPercentageSlider.value))
        
        //divide sliderValue by decimal100 (100.0) to get tip %
        let customPercent = sliderValue / decimal100
        
        //did customTipPercentageSlider generate the event?
        if sender is UISlider {
            //thumb moved so update the Labels with new custom percent
            customTipPercentLabel1.text = NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: NSNumberFormatterStyle.PercentStyle)
            customTipPercentLabel2.text = customTipPercentLabel1.text
        }
        
        //if there is a bill amount, calculate tips and totals
        if !inputString.isEmpty {
            //convert to NSDecimalNumber and insert decimal point
            let billAmount = NSDecimalNumber(string: inputString) / decimal100
            
            //did inputTextField generate the event?
            if sender is UITextField {
                //update billAmountLabel with currency-formatted total
                billAmountLabel.text = " " + formatAsCurrency(billAmount)
                
                //calculate and display the 15% tip and total
                let fifteenTip = billAmount * decimal15Percent
                tip15Label.text = formatAsCurrency(fifteenTip)
                total15Label.text = formatAsCurrency(billAmount + fifteenTip)
            
            }
            
            //calculate custom tip and display custom tip and total
            let customTip = billAmount * customPercent
            tipCustomLabel.text = formatAsCurrency(customTip)
            totalCustomLabel.text = formatAsCurrency(billAmount + customTip)
        }
        
        else {
         //clear all labels
            billAmountLabel.text = ""
            tip15Label.text = ""
            total15Label.text = ""
            tipCustomLabel.text = ""
            totalCustomLabel.text = ""
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//convert a nummeric vlaue to localized currency string
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

//overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

//overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

//overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}
