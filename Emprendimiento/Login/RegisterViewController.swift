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
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        var users: [User] = []
        users = self.modelStore.findAllUsers()
        print(users)
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
