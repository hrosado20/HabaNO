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
    @IBOutlet weak var signInButton: UIButton!
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
    
    @IBAction func signIn(_ sender: UIButton) {
        guard !self.emailTextField.text!.isEmpty, !self.passwordTextField.text!.isEmpty else {
            return
        }
        
        if self.modelStore.signIn(email: self.emailTextField.text!, password: self.passwordTextField.text!) {
            let destinationVC = AppStoryboard.Main.initialViewController()
            let vc = AppStoryboard.Login.viewController(viewControllerClass: CreditCardViewController.self)
            self.present(vc, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error al iniciar sesión", message: "Credenciales incorrectas.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(alertAction)
            showDetailViewController(alertController, sender: nil)
        }
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
