//
//  OrderCollectionViewCell.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 20/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "orderViewCell"
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var visaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func setupView() -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, self.gradientView.backgroundColor!.cgColor]
        self.gradientView.backgroundColor = UIColor.clear
        gradient.locations = [0.3, 1.0]
        self.gradientView.layer.insertSublayer(gradient, at: 0)
        
        self.orderView.layer.cornerRadius = 20
        self.visaView.layer.cornerRadius = 20
        self.orderImageView.alpha = 0.8
    }
    
    func setObject(with order: Order) -> Void {
        self.setupView()
        if let img = order.menuDetail?.dish?.image {
            self.orderImageView.image = UIImage(data: img)
        }
        self.nameLabel.text = order.menuDetail?.dish?.title
        self.statusLabel.text = order.state
        if order.payOnline {
            self.visaImageView.image = (order.creditCardType == "visa") ? #imageLiteral(resourceName: "visa_icon") : #imageLiteral(resourceName: "mastercard_icon")
        } else {
            self.visaView.isHidden = true
        }
    }
}
