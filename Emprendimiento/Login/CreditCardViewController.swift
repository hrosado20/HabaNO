//
//  CreditCardViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 13/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit
import Stripe
import CreditCardForm

class CreditCardViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var saveCreditCardButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    let paymentTextField = STPPaymentCardTextField()
    let creditCardForm = CreditCardFormView()
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Buttons
        
        
        // MARK: CreditCard
//        let creditCard: MFCardView = MFCardView(withViewController: self)
//        creditCard.delegate = self
//        creditCard.autoDismiss = false
//        creditCard.toast = true
//        creditCard.cardImage = #imageLiteral(resourceName: "world_map")
//        creditCard.frontChromeColor = UIColor.init(hexString: "7DC330").withAlphaComponent(0.9)
//        creditCard.backTape = UIColor.brown
//        creditCard.backChromeColor = UIColor.blue
//        self.creditCardView.addSubview(creditCard)
        
        self.creditCardForm.frame = CGRect(x: self.creditCardView.bounds.minX, y: self.creditCardView.bounds.minY, width: self.creditCardView.bounds.width, height: 200)
        self.creditCardView.addSubview(creditCardForm)
        
        self.paymentTextField.frame = CGRect(x: self.creditCardView.bounds.minX, y: self.creditCardView.bounds.minY, width: self.creditCardView.bounds.width - 30, height: 44)
        self.paymentTextField.delegate = self
        self.paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        self.paymentTextField.borderWidth = 1
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.paymentTextField.frame.size.height - width, width:  self.paymentTextField.frame.size.width, height: self.paymentTextField.frame.size.height)
        border.borderWidth = width
        self.paymentTextField.layer.addSublayer(border)
        self.paymentTextField.layer.masksToBounds = true

        
        self.creditCardView.addSubview(paymentTextField)
        
        NSLayoutConstraint.activate([
            self.paymentTextField.topAnchor.constraint(equalTo: creditCardForm.bottomAnchor, constant: 10),
            self.paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.paymentTextField.widthAnchor.constraint(equalToConstant: self.creditCardView.bounds.width - 20),
            self.paymentTextField.heightAnchor.constraint(equalToConstant: 44)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCreditCardAction(_ sender: UIButton) {
        guard self.paymentTextField.cardNumber != nil, self.paymentTextField.formattedExpirationMonth != nil, self.paymentTextField.formattedExpirationYear != nil, self.paymentTextField.cvc != nil else {
            return
        }
        
        self.modelStore.addCreditCard(owner: "", cardNumber: self.paymentTextField.cardNumber!, expirationMonth: self.paymentTextField.expirationMonth.hashValue, expirationYear: self.paymentTextField.expirationYear.hashValue, cvc: self.paymentTextField.cvc!)
        let destinationVC = AppStoryboard.Main.initialViewController()
        self.present(destinationVC!, animated: true, completion: nil)
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        let destinationVC = AppStoryboard.Main.initialViewController()
        self.present(destinationVC!, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension CreditCardViewController: MFCardDelegate {
//    func cardDoneButtonClicked(_ card: Card?, error: String?) {
//        // MARK: Make an action
//        var r = 2
//    }
//    
//    func cardTypeDidIdentify(_ cardType: String) {
//        // MARK: Make an action
//    }
//    
//    func cardDidClose() {
//        // MARK: Make an action
//    }
//    
//    
//}
extension CreditCardViewController: STPPaymentCardTextFieldDelegate {
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        self.creditCardForm.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: textField.expirationYear, expirationMonth: textField.expirationMonth, cvc: textField.cvc)
    }
    
    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        self.creditCardForm.paymentCardTextFieldDidEndEditingExpiration(expirationYear: textField.expirationYear)
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        self.creditCardForm.paymentCardTextFieldDidBeginEditingCVC()
    }
    
    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        self.creditCardForm.paymentCardTextFieldDidEndEditingCVC()
    }
}
