//
//  ModelStore.swift
//  Emprendimiento
//
//  Created by Hugo Andres on 11/11/18.
//  Copyright © 2018 Own. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ModelStore {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func populateDatabase() -> Void {
        // MARK: User and Login
        self.addUser(creditCard: nil, email: "admin", password: "admin", fullName: "Hugo Rosado", name: "Hugo", lastName: "Rosado", twitter: "@hugoand", profileImage: #imageLiteral(resourceName: "user_image"), backgroundImage: #imageLiteral(resourceName: "background_image"), followingCount: 0, followersCount: 0)
        
        // MARK: Restaurants
//        self.addRestaurant(title: "Rosa Náutica", description: "Un buen restaurante.", image: <#T##UIImage#>, createdAt: nil)
        
        // MARK: Orders
        
    }
    
    // MARK: Add functions
    func addUser(creditCard: CreditCard?, email: String, password: String, fullName: String, name: String?, lastName: String?, twitter: String, profileImage: UIImage, backgroundImage: UIImage, followingCount: Int, followersCount: Int) -> Void {
        let login = Login(context: self.context)
        login.email = email
        login.password = password
        
        let user = User(context: self.context)
        user.creditCard = creditCard
        user.login = login
        user.fullName = fullName
        user.name = name
        user.lastName = lastName
        user.twitter = twitter
        user.profileImage = UIImagePNGRepresentation(profileImage)
        user.backgroundImage = UIImagePNGRepresentation(backgroundImage)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addFollowerOrFollowing(follower: User, following: User) -> Void {
        let follow = Follow(context: self.context)
        follow.follower = follower
        follow.following = following
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addDish(privateId: String, title: String, info: String, price: Float, image: UIImage, createdAt: Date?) -> Void {
        let dish = Dish(context: self.context)
        dish.privateId = privateId
        dish.title = title
        dish.info = info
        dish.price = price
        dish.image = UIImagePNGRepresentation(image)
        dish.createdAt = (createdAt == nil) ? Utils.getTimeNow() : createdAt
    }
    
    func addRestaurant(title: String, description: String, image: UIImage, createdAt: Date?) -> Void {
        let restaurant = Restaurant(context: self.context)
        restaurant.title = title
        restaurant.info = description
        restaurant.image = UIImagePNGRepresentation(image)
        restaurant.createdAt = (createdAt == nil) ? Utils.getTimeNow() : createdAt
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addCreditCard(owner: String, cardNumber: String, expirationMonth: Int, expirationYear: Int, cvc: String) -> Void {
        let creditCard = CreditCard(context: self.context)
        creditCard.owner = owner
        creditCard.cardNumber = cardNumber
        creditCard.expirationMonth = Int32(expirationMonth)
        creditCard.expirationYear = Int32(expirationYear)
        creditCard.cvc = cvc
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addMenu(restaurant: Restaurant, price: Float, initialDate: Date, finalDate: Date) -> Void {
        let menu = Menu(context: self.context)
        menu.restaurant = restaurant
        menu.price = price
        menu.initialDate = initialDate
        menu.finalDate = finalDate
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addMenuDetail(dish: Dish, menu: Menu, quantity: Int) -> Void {
        let menuDetail = MenuDetail(context: self.context)
        menuDetail.dish = dish
        menuDetail.menu = menu
        menuDetail.quantity = Int32(quantity)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addOrder(user: User, menuDetail: MenuDetail, payOnline: Bool, createdAt: Date?, expiresAt: Date?, state: String) -> Void {
        let order = Order(context: self.context)
        order.user = user
        order.menuDetail = menuDetail
        order.payOnline = payOnline
        order.createdAt = (createdAt == nil) ? Utils.getTimeNow() : createdAt
        order.expiresAt = expiresAt
        order.state = state
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    // MARK: Get functions
    func signIn(email: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<Login> = Login.fetchRequest()
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "email == %@", email),
            NSPredicate(format: "password == %@", password)
            ])
        
        do {
            let result = try self.context.fetch(fetchRequest)
            if !result.isEmpty {
                print("My response: \(result[0].user!.objectID)")
                UserDefaults.standard.set(result[0].user!.objectID.uriRepresentation(), forKey: Constants.keys.userId)
                return true
            } else {
                return false
            }
        } catch {
            print("Error fecthing user data")
            return false
        }
    }
    
    func findAllUsers() -> [User] {
        var users: [User] = []
        do {
            users = try self.context.fetch(User.fetchRequest())
        } catch {
            print("Error fecthing user data")
        }
        
        return users
    }
    
    func findUser(id: URL) -> User {
        var user: User = User(context: self.context)
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let userId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: id)
        do {
            let object = try self.context.existingObject(with: userId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            user = try self.context.fetch(fetchRequest)[0]
            
            print("user: \(user)")
        } catch {
            print("Error fecthing user data with objectId")
        }
        
        return user
    }
    
    func findFollowers(userId: URL) -> [User] {
        var followers: [User] = []
        let fecthRequest: NSFetchRequest<Follow> = Follow.fetchRequest()
        let userObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: userId)
        do {
            let object = try self.context.existingObject(with: userObjectId!)
            fecthRequest.predicate = NSPredicate(format: "self.following == %@", object)
            let follows = try self.context.fetch(fecthRequest)
            for follow in follows {
                followers.append(follow.follower!)
            }
        } catch {
            print("Error fetching followers data")
        }
        
        return followers
    }
    
    func dinfFollowings(userId: URL) -> [User] {
        var followings: [User] = []
        let fetchRequest: NSFetchRequest<Follow> = Follow.fetchRequest()
        let userObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: userId)
        do {
            let object = try self.context.existingObject(with: userObjectId!)
            fetchRequest.predicate = NSPredicate(format: "self.follower == %@", object)
            let follows = try self.context.fetch(fetchRequest)
            for follow in follows {
                followings.append(follow.following!)
            }
        } catch {
            print("Error fetching followings data")
        }
        
        return followings
    }
}
