//
//  LoginViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 12/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginScrollView: UIScrollView!
    var email: String = ""
    var password: String = ""
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        // MARK: ScrollView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
       
        // MARK: Textfields
        for textField in self.textFields {
            if textField == self.emailTextField {
                Utils.addIconToTextField(textField: textField, icon: #imageLiteral(resourceName: "email_gray"), widthMargin: 7.0, heightMargin: 0.0, padding: 5)
            } else if textField == self.passwordTextField {
                Utils.addIconToTextField(textField: textField, icon: #imageLiteral(resourceName: "lock_gray"), widthMargin: 7.0, heightMargin: 0.0, padding: 5)
            }
            textField.delegate = self
            textField.layer.borderWidth = 0.2
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = textField.frame.size.height / 2
            textField.clipsToBounds = true
            textField.inputAccessoryView = toolbar
        }
        
        // MARK: SignInButton
        self.signInButton.layer.cornerRadius = self.signInButton.frame.size.height / 2
        self.signInButton.backgroundColor = CustomColor.theme.value
        
        // MARK: Validation
        if !email.isEmpty {
            self.emailTextField.text = email
        }
        if !password.isEmpty {
            self.passwordTextField.text = password
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        guard !self.emailTextField.text!.isEmpty, !self.passwordTextField.text!.isEmpty else {
            return
        }
        
        let users = self.modelStore.findAllUsers()
        print("user: \(users)")
        
        if self.modelStore.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!) {
            if UserDefaults.standard.bool(forKey: "showStartCreditCard") {
                let vc = AppStoryboard.Login.viewController(viewControllerClass: CreditCardViewController.self)
                self.present(vc, animated: true, completion: nil)
            } else {
                let destinationVC = AppStoryboard.Main.initialViewController()
                self.present(destinationVC!, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Error al iniciar sesión", message: "Credenciales incorrectas.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            showDetailViewController(alertController, sender: nil)
        }
    }
    
    @objc func doneAction() {
        self.view.endEditing(true)
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) -> Void {
        self.view.endEditing(true)
    }
    
    func addObservers() -> Void {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func keyboardWillShow(notification: Notification) -> Void {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        self.loginScrollView.contentInset = contentInset
    }
    func keyboardWillHide(notification: Notification) -> Void {
        self.loginScrollView.contentInset = UIEdgeInsets.zero
    }
    
    func removeObservers() -> Void {
        NotificationCenter.default.removeObserver(self)
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
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let supposedWord = "\(textField.text!)\(string)"
        
        if self.emailTextField.isFirstResponder {
            // MARK: emailTextField
            let arguments = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailValidate = NSPredicate(format: "SELF MATCHES %@", arguments)
            self.emailTextField.layer.borderWidth = 1.0
            guard !supposedWord.isEmpty && supposedWord == "admin" || emailValidate.evaluate(with: supposedWord) else {
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                return true
            }
            self.emailTextField.layer.borderColor = CustomColor.theme.value.cgColor
        } else {
            // MARK: passwordTextField
            self.passwordTextField.layer.borderWidth = 1.0
            guard !supposedWord.isEmpty && supposedWord.count >= 4 else {
                self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                return true
            }
            self.passwordTextField.layer.borderColor = CustomColor.theme.value.cgColor
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = CustomColor.theme.value.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
