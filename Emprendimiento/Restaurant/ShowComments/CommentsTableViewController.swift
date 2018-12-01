//
//  CommentsTableViewController.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 17/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase

class CommentsTableViewController: UITableViewController {
    @IBOutlet var emptyView: UIView!
    var comments: [Comment] = []
    var image: UIImage!
    var restaurantFirebaseId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadComments(toFirst first: Int, toLast last: Int) -> Void {
        let database = Database.database().reference().child("Restaurants").child(self.restaurantFirebaseId).child("Comments").queryLimited(toFirst: UInt(last))
        database.observe(.value) { (snapshot) in
            self.comments.append(contentsOf: Comment.buildCollection(fromFirebaseSnapshot: snapshot))
            self.tableView.reloadData()
        }
    }
    
    func loadFirstComment() -> Void {
        let database = Database.database().reference().child("Restaurants").child(self.restaurantFirebaseId).child("Comments").queryLimited(toLast: 1)
        database.observeSingleEvent(of: .value) { (snapshot) in
            self.comments = Comment.buildCollection(fromFirebaseSnapshot: snapshot)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.comments.count == 0 {
            self.tableView.separatorStyle = .none
            self.tableView.backgroundView = self.emptyView
            return 0
        }
        self.tableView.separatorStyle = .singleLine
        self.tableView.backgroundView = UIView()
        return self.comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = self.comments[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as? CommentTableViewCell {
            cell.setObject(with: comment)
            
            return cell
        }

        return UITableViewCell()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
