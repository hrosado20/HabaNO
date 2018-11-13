//
//  RegisterViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 13/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signUpScrollView: UIScrollView!
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func registerAction(_ sender: UIButton) {
        guard !self.fullNameTextField.text!.isEmpty, !self.emailTextField.text!.isEmpty, !self.passwordTextField.text!.isEmpty, !self.repeatPasswordTextField.text!.isEmpty else {
            return
        }
        
        self.modelStore.addUser(email: self.emailTextField.text!, password: self.passwordTextField.text!, name: self.fullNameTextField.text!, lastName: "", twitter: "", profileImage: #imageLiteral(resourceName: "user_image"), backgroundImage: #imageLiteral(resourceName: "background_image"), followingCount: 0, followersCount: 0)
        
        let destinationVC = AppStoryboard.Login.viewController(viewControllerClass: LoginViewController.self)
        destinationVC.email = self.emailTextField.text!
        destinationVC.password = self.passwordTextField.text!
        self.present(destinationVC, animated: true, completion: nil)
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
        self.signUpScrollView.contentInset = contentInset
    }
    func keyboardWillHide(notification: Notification) -> Void {
        self.signUpScrollView.contentInset = UIEdgeInsets.zero
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
