//
//  RestaurantCollectionViewCell.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 16/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "restaurantViewCell"
    @IBOutlet weak var restaurantView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func setupView() -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, self.gradientView.backgroundColor!.cgColor]
        self.gradientView.backgroundColor = UIColor.clear
        gradient.locations = [0.3, 1.0]
        self.gradientView.layer.insertSublayer(gradient, at: 0)
        
        self.restaurantView.layer.cornerRadius = 20
        self.restaurantImageView.alpha = 0.8
    }
    
    func setObject(with restaurant: Restaurant) -> Void {
        self.setupView()
        self.restaurantImageView.image = UIImage(data: restaurant.image!)
        self.nameLabel.text = restaurant.title
        self.statusLabel.text = restaurant.state
    }
}
