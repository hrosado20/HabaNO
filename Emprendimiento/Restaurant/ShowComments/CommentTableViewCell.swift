//
//  CommentTableViewCell.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 17/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static var reuseIdentifier: String = "commentViewCell"
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userImageView.layer.cornerRadius = self.userImageView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
