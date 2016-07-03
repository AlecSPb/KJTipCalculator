//
//  InterfaceController.swift
//  KJTipCalculator-Watch Extension
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var subtotalButton: WKInterfaceButton!
    @IBOutlet var tipPercentagePicker: WKInterfacePicker!
    @IBOutlet var numberInPartyPicker: WKInterfacePicker!
    @IBOutlet var tipLabel: WKInterfaceLabel!
    @IBOutlet var totalLabel: WKInterfaceLabel!

    private var subtotal = 20.00
    private var tipPercentage = 18
    private var numberInParty = 1

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let tipPercentageItems: [WKPickerItem] = (1...50).map { n in
            let item = WKPickerItem()
            item.title = "\(n)%"
            item.caption = "Tip %"
            return item
        }
        tipPercentagePicker.setItems(tipPercentageItems)
        tipPercentagePicker.setSelectedItemIndex(tipPercentage - 1)

        let numberInPartyItems: [WKPickerItem] = (1...20).map { n in
            let item = WKPickerItem()
            item.title = "\(n)"
            item.caption = "Party of"
            return item
        }
        numberInPartyPicker.setItems(numberInPartyItems)
        numberInPartyPicker.setSelectedItemIndex(numberInParty - 1)
    }

    override func willActivate() {
        super.willActivate()
        updateOutput()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    func updateOutput() {
        let tipCalculation = TipCalculation(subtotal: subtotal,
                                            tipPercentage: tipPercentage,
                                            numberInParty: numberInParty)
        subtotalButton.setTitle(formatValue(subtotal))
        tipLabel.setText("Tip: \(formatValue(tipCalculation.tip))")
        if numberInParty == 1 {
            totalLabel.setText("Total: \(formatValue(tipCalculation.total))")
        }
        else {
            totalLabel.setText("\(formatValue(tipCalculation.total)) / \(formatValue(tipCalculation.perPerson))")
        }
    }

    override func contextForSegueWithIdentifier(segueIdentifier: String) -> AnyObject? {
        switch segueIdentifier {
        case "Subtotal":
            return SubtotalInterfaceController.Context(subtotal: subtotal, delegate: self)
        default:
            NSLog("Unknown segue identifier")
            return nil
        }
    }

    @IBAction func tipPercentageWasPicked(value: Int) {
        tipPercentage = value + 1
        updateOutput()
    }

    @IBAction func numberInPartyWasPicked(value: Int) {
        numberInParty = value + 1
        updateOutput()
    }

    private func formatValue(value: Double) -> String {
        return String(format: "%01.2f", value)
    }
}

extension InterfaceController: SubtotalInterfaceControllerDelegate {
    func subtotalInterfaceController(controller: SubtotalInterfaceController, didUpdateSubtotal subtotal: Double) {
        self.subtotal = subtotal
        updateOutput()
    }
}
