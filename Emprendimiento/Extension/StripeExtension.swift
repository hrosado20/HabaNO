//
//  StripeExtension.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 13/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import Foundation
import Stripe

class PaymentCardEditorField: STPPaymentCardTextField {
    func setExistingCard(card: STPCardParams) {
        replaceField(memberName: "numberField", withValue: card.number!)
        replaceField(memberName: "expirationField", withValue: String(format: "%02d/%02d", card.expMonth, (card.expYear % 100)))
        replaceField(memberName: "cvcField", withValue: card.cvc!)
    }
    
    func replaceField(memberName: String, withValue value: String) {
        let field = self.value(forKey: memberName) as! UITextField
        let delegate = self as! UITextFieldDelegate
        let len = field.text?.characters.count
        if delegate.textField!(field, shouldChangeCharactersIn: NSMakeRange(0, len!), replacementString: value) {
            field.text = value
        }
    }
}
