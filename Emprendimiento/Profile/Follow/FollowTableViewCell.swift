//
//  FollowTableViewCell.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 16/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class FollowTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    public static var reuseIdentifier: String = "followViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.cornerRadius = self.userImageView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setObject(with follow: User) -> Void {
        self.userImageView.image = UIImage(data: follow.profileImage!)
        self.fullNameLabel.text = follow.fullName
        self.twitterLabel.text = follow.twitter
    }

}
