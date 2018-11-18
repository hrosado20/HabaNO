//
//  ProfileViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 13/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var followsSegmentedControl: UISegmentedControl!
    var modelStore: ModelStore {
        get {
            return (UIApplication.shared.delegate as! AppDelegate).modelStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: NavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // MARK: ImageView
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height / 2
        
        let user = self.modelStore.findUser(id: UserDefaults.standard.url(forKey: Constants.keys.userId)!)
        self.backgroundImageView.image = UIImage(data: user.backgroundImage!)
        self.profileImageView.image = UIImage(data: user.profileImage!)
        self.fullNameLabel.text = user.fullName
        self.twitterLabel.text = user.twitter
        
        // MARK: SegmentedControl
        let viewController = self.childViewControllers.last as! FollowTableViewController
        viewController.users = self.modelStore.findFollowers(userId: UserDefaults.standard.url(forKey: Constants.keys.userId)!)
        viewController.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTabChanged(_ sender: UISegmentedControl) {
        switch self.followsSegmentedControl.selectedSegmentIndex {
        case 0:
            let viewController = self.childViewControllers.last as! FollowTableViewController
            viewController.loadUsers(users: self.modelStore.findFollowers(userId: UserDefaults.standard.url(forKey: Constants.keys.userId)!))
            break
        case 1:
            let viewController = self.childViewControllers.last as! FollowTableViewController
            viewController.loadUsers(users: self.modelStore.findFollowings(userId: UserDefaults.standard.url(forKey: Constants.keys.userId)!))
            break
        default:
            break
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
