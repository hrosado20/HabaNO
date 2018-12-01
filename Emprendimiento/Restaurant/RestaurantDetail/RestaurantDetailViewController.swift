//
//  RestaurantDetailViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 18/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit
import Firebase

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var restaurantView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var workDaysLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var dishesImageViews: [UIImageView]!
    var restaurantId: URL!
    var restaurantFirebaseId: String!
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.verifyRestaurantInFirebase()
        let restaurant = self.modelStore.findRestaurant(restaurantId: self.restaurantId)
        self.restaurantImageView.image = UIImage(data: restaurant.image!)
        self.nameLabel.text = restaurant.title
        self.workDaysLabel.text = restaurant.workDays
        self.descriptionLabel.text = restaurant.info
        
        let dishes = self.modelStore.getThreeDishes()
        for i in 0..<self.dishesImageViews.count {
            self.dishesImageViews[i].layer.cornerRadius = self.dishesImageViews[i].bounds.height / 2
            self.dishesImageViews[i].image = UIImage(data: dishes[i].image!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() -> Void {
        self.restaurantView.layer.cornerRadius = 20
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, self.gradientView.backgroundColor!.cgColor]
        self.gradientView.backgroundColor = UIColor.clear
        gradient.locations = [0.3, 1.0]
        self.gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    func verifyRestaurantInFirebase() -> Void {
        let database = Database.database().reference().child("Restaurants")
        let reference = database.queryOrdered(byChild: Constants.keys.restaurantId).queryEqual(toValue: self.restaurantId.absoluteString)
        reference.observeSingleEvent(of: .value) { (snapshot) in
            guard (snapshot.value as? NSDictionary) != nil else {
                let dict : NSDictionary = [
                    Constants.keys.restaurantId: self.restaurantId.absoluteString
                ]
                self.restaurantFirebaseId = database.childByAutoId().key
                database.childByAutoId().setValue(dict, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error!)
                    }
                    else {
                        self.loadChildViewControllers()
                        print("Restaurant saved successfully!")
                    }
                })
                return
            }
            
            print((snapshot.children.nextObject() as! DataSnapshot).key)
            self.restaurantFirebaseId = (snapshot.children.nextObject() as! DataSnapshot).key
            self.loadChildViewControllers()
        }
    }
    
    func loadChildViewControllers() -> Void {
        let commentTableViewController = self.childViewControllers.first as! CommentsTableViewController
        commentTableViewController.restaurantFirebaseId = self.restaurantFirebaseId
        commentTableViewController.loadFirstComment()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCommentDetail" {
            let destinationVC = segue.destination as! CommentViewController
            destinationVC.restaurantFirebaseId = self.restaurantFirebaseId
            destinationVC.image = self.restaurantImageView.image
        }
    }

}
