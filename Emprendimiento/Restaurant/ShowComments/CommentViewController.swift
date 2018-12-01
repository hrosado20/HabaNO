//
//  CommentViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 21/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit
import Firebase

class CommentViewController: UIViewController {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var commentContainerView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var upDownButton: UIButton!
    var restaurantFirebaseId: String!
    var user: User!
    var image: UIImage!
    var firstIndex: Int = 1
    var lastIndex: Int = 10
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.verifyRestaurantInFirebase()

        // MARK: ImageView
        self.restaurantImageView.image = self.image
        self.user = self.modelStore.findUser(id: UserDefaults.standard.url(forKey: Constants.keys.userId)!)
        self.userImageView.image = UIImage(data: self.user.profileImage!)
        
        // MARK: Views
        self.commentView.layer.shadowColor = UIColor.gray.cgColor
        self.commentView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.commentView.layer.shadowOpacity = 0.6
        self.commentView.layer.masksToBounds = false
        self.commentView.layer.shadowRadius = 2.0
        
        // MARK: TextFields
        self.commentTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func upDownAction(_ sender: UIButton) {
        if self.upDownButton.tag == 0 {
            UIView.animate(withDuration: 1) {
//                self.commentView.frame.origin.y -= self.commentView.frame.origin.y
//                self.commentContainerView.frame.origin.y -= (self.commentContainerView.frame.origin.y - self.commentView.frame.height)
//                self.commentContainerView.frame.size.height += (self.view.frame.maxY - self.commentContainerView.frame.origin.y)
                
            }
            self.upDownButton.setImage(#imageLiteral(resourceName: "down_icon"), for: .normal)
            self.upDownButton.tag = 1
        } else if self.upDownButton.tag == 1 {
            
            self.upDownButton.setImage(#imageLiteral(resourceName: "up_icon"), for: .normal)
            self.upDownButton.tag = 0
        }
    }
    
    func loadChildViewControllers() -> Void {
        let commentTableViewController = self.childViewControllers.first as! CommentsTableViewController
        commentTableViewController.restaurantFirebaseId = self.restaurantFirebaseId
        commentTableViewController.loadComments(toFirst: firstIndex, toLast: lastIndex)
    }
    
    func verifyRestaurantInFirebase() -> Void {
        let database = Database.database().reference().child("Restaurants").child(self.restaurantFirebaseId)
        database.observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.exists() else {
                return
            }
            
            self.loadChildViewControllers()
        }
    }
    
    func addComment(text: String) -> Void {
        let database = Database.database().reference().child("Restaurants").child(self.restaurantFirebaseId).child("Comments")
        let dictionary : NSDictionary = [
            Constants.firebaseKeys.id: "",
            Constants.firebaseKeys.userImage: self.user.profileImage!.base64EncodedString(),
            Constants.firebaseKeys.userName: self.user.fullName!,
            Constants.firebaseKeys.comment: self.commentTextField.text!
        ]
        database.childByAutoId().setValue(dictionary) { (error, reference) in
            if error != nil {
                print(error!)
            }
            else {
                print("Comment saved successfully!")
            }
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
extension CommentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.addComment(text: textField.text!)
        textField.text = ""
        return true
    }
}
