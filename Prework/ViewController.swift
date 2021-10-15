//
//  ViewController.swift
//  Prework
//
//  Created by Nhan Nguyen on 10/10/21.
//  Copyright © 2021 Nhan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var customTipToggleControl: UISegmentedControl!
    @IBOutlet weak var customTipSlider: UISlider!
    @IBOutlet weak var customTipLabel: UILabel!
    
    let numberFormatter = NumberFormatter()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the title in Navigation Bar
        self.title = "Tip Calculator"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        
        tipControl.isHidden = false
        customTipSlider.isHidden = true;
        customTipLabel.isHidden = true;
        let customTipValue = Double(customTipSlider.value) * 100
        customTipLabel.text = numberFormatter.string(from: NSNumber(value: customTipValue))! + "%"
        updateLabels(tip: 0, total: 0)
        navigationController!.overrideUserInterfaceStyle = defaults.bool(forKey: "darkMode") ? .dark : .light
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func calculateTip(_ sender: Any) {
        applySuggestedTip()
    }
    
    @IBAction func customTipToggle(_ sender: Any) {
        if (customTipToggleControl.selectedSegmentIndex == 1) {
            tipControl.isHidden = true
            customTipSlider.isHidden = false;
            customTipLabel.isHidden = false;
            applyCustomTip()
        } else {
            tipControl.isHidden = false
            customTipSlider.isHidden = true;
            customTipLabel.isHidden = true;
            applySuggestedTip()
        }
    }
    @IBAction func customTipSliderHandler(_ sender: Any) {
        applyCustomTip()
    }
    
    func applySuggestedTip() {
        // Get bill amount from text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get total tip by multiplying tip with tipPercentage
        let tipPercentages = [0.15, 0.18, 0.2]

        let tip = calculateTotal(bill: bill, tipPercentage: tipPercentages[tipControl.selectedSegmentIndex]).tip
        let total = calculateTotal(bill: bill, tipPercentage: tipPercentages[tipControl.selectedSegmentIndex]).total
        updateLabels(tip: tip, total: total)
    }
    
    func applyCustomTip() {
        let customTipValue = Double(customTipSlider.value)
        customTipLabel.text = numberFormatter.string(from: NSNumber(value: customTipValue * 100))! + "%"
        
        let bill = Double(billAmountTextField.text!) ?? 0

        let tip = calculateTotal(bill: bill, tipPercentage: customTipValue).tip
        let total = calculateTotal(bill: bill, tipPercentage: customTipValue).total
        
        updateLabels(tip: tip, total: total)
    }
    
    func calculateTotal(bill: Double, tipPercentage: Double) -> (total: Double, tip: Double) {
        let tip = bill * tipPercentage
        
        return (bill + tip, tip)
    }
    
    func updateLabels(tip: Double, total: Double) {
        // Update tip amount label
        tipAmountLabel.text = String(format: "%.2f", tip)
        // Update total amount
        totalLabel.text = String(format: "%.2f", total)
    }
}

