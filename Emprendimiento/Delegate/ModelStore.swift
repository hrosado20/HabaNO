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
import AlamofireImage

class ModelStore {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func populateDatabase() -> Void {
        // MARK: User and Login
        self.addUser(creditCard: nil, email: "admin", password: "admin", fullName: "Hugo Rosado", name: "Hugo", lastName: "Rosado", twitter: "@hugoand", profileImage: #imageLiteral(resourceName: "user_image"), backgroundImage: #imageLiteral(resourceName: "background_image"), followingCount: 0, followersCount: 0)
        self.addUser(creditCard: nil, email: "dana@hotmail.com", password: "123456", fullName: "Dana Annie", name: "Dana", lastName: "Annie", twitter: "@dannie", profileImage: #imageLiteral(resourceName: "user_image"), backgroundImage: #imageLiteral(resourceName: "background_image"), followingCount: 0, followersCount: 0)
        self.addUser(creditCard: nil, email: "renzo@gmail.com", password: "123456", fullName: "Renzo Alegre", name: nil, lastName: nil, twitter: "@renzop", profileUrl: URL(string: "https://eabiawak.com/wp-content/uploads/2017/07/photo.png")!, backgroundUrl: URL(string: "https://i.ytimg.com/vi/bEPAbS-SRlg/maxresdefault.jpg")!, followingCount: 0, followersCount: 0)
        
        // MARK: Followers and Followings
        self.addFollowerOrFollowing(follower: self.findAllUsers()[0], following: self.findAllUsers()[1])
        self.addFollowerOrFollowing(follower: self.findAllUsers()[0], following: self.findAllUsers()[2])
        self.addFollowerOrFollowing(follower: self.findAllUsers()[1], following: self.findAllUsers()[0])
        self.addFollowerOrFollowing(follower: self.findAllUsers()[1], following: self.findAllUsers()[2])
        
        // MARK: Restaurants
        self.addRestaurant(title: "Rosa Náutica", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/2b/e3/2be38cd3103909e801f65adbac68c494.jpg")!, workDays: "Lunes a sábado", createdAt: nil, state: "Abierto")
        self.addRestaurant(title: "El Hornero", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/f2/45/f245068ccb80f25aa4f96944fffb0d57.jpg")!, workDays: "Lunes a viernes", createdAt: nil, state: "Abierto")
        self.addRestaurant(title: "Pollería Hikari", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/c2/16/c216e8a0efcab2cb7cced7f45f51639a.jpg")!, workDays: "Lunes a sábado", createdAt: nil, state: "Abierto")
        self.addRestaurant(title: "Bembos", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/30/04/30043a61ee90fda2800ade32b941ff92.jpg")!, workDays: "Lunes a viernes", createdAt: nil, state: "Cerrado")
        self.addRestaurant(title: "Chilli's", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/8c/dc/8cdc70dbec2c1c4de4458667ea213a6c.jpg?output-quality=75&output-format=progressive-jpeg&interpolation=lanczos-none&downsize=1020:*")!, workDays: "Lunes a viernes", createdAt: nil, state: "cerrado")
        self.addRestaurant(title: "Heladería Laritza", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/dd/c7/ddc71ea4c68b575944add2df300be4b8.jpg?output-quality=75&output-format=progressive-jpeg&interpolation=lanczos-none&downsize=700:*")!, workDays: "Lunes a viernes", createdAt: nil, state: "Abierto")
        self.addRestaurant(title: "Manduca", description: "Un buen restaurante.", imageUrl: URL(string: "https://imgs-akamai.mnstatic.com/c0/68/c06881242a278dafed5db52163ae0346.jpg")!, workDays: "Lunes a viernes", createdAt: nil, state: "Abierto")
        self.addRestaurant(title: "Papachos", description: "Un buen restaurante.", imageUrl: URL(string: "https://media-cdn.tripadvisor.com/media/photo-o/03/3d/99/48/papacho.jpg")!, workDays: "Lunes a viernes", createdAt: nil, state: "Abierto")
        self.addRestaurant(title: "Tom Davis", description: "Un buen restaurante.", imageUrl: URL(string: "https://media-cdn.tripadvisor.com/media/photo-p/14/b3/b0/40/coman-con-calma-pero.jpg")!, workDays: "Lunes a sábado", createdAt: nil, state: "Cerrado")
        self.addRestaurant(title: "Pardo's Chicken", description: "Un buen restaurante.", imageUrl: URL(string: "https://media-cdn.tripadvisor.com/media/photo-o/11/f4/ce/0f/pardo-s-chicken.jpg")!, workDays: "Lunes a sábado", createdAt: nil, state: "Abierto")
//        self.addRestaurant(title: "Norky's", description: "Un buen restaurante.", imageUrl: URL(string: "https://media-cdn.tripadvisor.com/media/photo-o/0c/f8/cd/12/entrada-del-restaurante.jpg")!, workDays: "Todos los días", createdAt: nil, state: "Abierto")
        
        // MARK: Dishes
        self.addDish(privateId: "000001", title: "Arroz con pollo", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/arroz-con-pollo-peruano.jpg")!, createdAt: nil)
        self.addDish(privateId: "000002", title: "Causa a la limeña", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/causa-a-la-limencc83a.jpg")!, createdAt: nil)
        self.addDish(privateId: "000003", title: "Ceviche", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/tres-tipos-de-ceviche-peruano.jpg")!, createdAt: nil)
        self.addDish(privateId: "000004", title: "Lomo Saltado", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/lomo-saltado-tipico-de-peru.jpg")!, createdAt: nil)
        self.addDish(privateId: "000005", title: "Pachamanca a la olla", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/pachamanca-a-la-olla.jpg")!, createdAt: nil)
        self.addDish(privateId: "000006", title: "Papa a la huancaína", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/papa-a-la-huancaina.jpg")!, createdAt: nil)
        self.addDish(privateId: "000007", title: "Carapulcra y sopa seca", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://www.viajejet.com/wp-content/viajes/carapulcra-y-sopa-seca-chinchana.jpg")!, createdAt: nil)
        self.addDish(privateId: "000008", title: "Ají de Gallina", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://libroderecetas.com/files/recetas/aji-de-gallina.jpg")!, createdAt: nil)
        self.addDish(privateId: "000009", title: "Bistec a lo pobre", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://libroderecetas.com/files/recetas/bistec-a-lo-pobre.jpg")!, createdAt: nil)
        self.addDish(privateId: "000010", title: "Caldo de gallina", info: "Uno de los platos más consumidos.", price: nil, imageUrl: URL(string: "https://libroderecetas.com/files/recetas/caldo-de-gallina_0.jpg")!, createdAt: nil)
        
        // MARK: Menus
        self.addMenu(restaurant: self.findAllRestaurants()[0], price: 13.00, initialHour: "11:00", finalHour: "22:00")
        self.addMenu(restaurant: self.findAllRestaurants()[1], price: 10.00, initialHour: "10:00", finalHour: "22:00")
        self.addMenu(restaurant: self.findAllRestaurants()[2], price: 15.00, initialHour: "11:00", finalHour: "22:00")
        self.addMenu(restaurant: self.findAllRestaurants()[3], price: 12.50, initialHour: "11:00", finalHour: "22:00")
        self.addMenu(restaurant: self.findAllRestaurants()[4], price: 13.00, initialHour: "11:00", finalHour: "22:00")
        self.addMenu(restaurant: self.findAllRestaurants()[5], price: 11.00, initialHour: "13:00", finalHour: "22:00")
        
        // MARK: MenuDetail
        self.addMenuDetail(dish: self.findAllDishes()[0], menu: self.findAllMenus()[0], quantity: 1)
        self.addMenuDetail(dish: self.findAllDishes()[0], menu: self.findAllMenus()[1], quantity: 2)
        self.addMenuDetail(dish: self.findAllDishes()[0], menu: self.findAllMenus()[2], quantity: 1)
        self.addMenuDetail(dish: self.findAllDishes()[1], menu: self.findAllMenus()[0], quantity: 1)
        self.addMenuDetail(dish: self.findAllDishes()[2], menu: self.findAllMenus()[0], quantity: 1)
        self.addMenuDetail(dish: self.findAllDishes()[3], menu: self.findAllMenus()[3], quantity: 3)
        
        // MARK: Order
        self.addOrder(user: self.findAllUsers()[0], menuDetail: self.findAllMenuDetails()[0], payOnline: true, creditCardType: "visa", createdAt: nil, expiresAt: nil, state: Constants.state.activeInSpanish)
        self.addOrder(user: self.findAllUsers()[0], menuDetail: self.findAllMenuDetails()[1], payOnline: true, creditCardType: "visa", createdAt: nil, expiresAt: nil, state: Constants.state.takenInSpanish)
        self.addOrder(user: self.findAllUsers()[1], menuDetail: self.findAllMenuDetails()[2], payOnline: false, creditCardType: "visa", createdAt: nil, expiresAt: nil, state: Constants.state.takenInSpanish)
        self.addOrder(user: self.findAllUsers()[1], menuDetail: self.findAllMenuDetails()[3], payOnline: false, creditCardType: "mastercard", createdAt: nil, expiresAt: nil, state: Constants.state.activeInSpanish)
        self.addOrder(user: self.findAllUsers()[2], menuDetail: self.findAllMenuDetails()[4], payOnline: true, creditCardType: "mastercard", createdAt: nil, expiresAt: nil, state: Constants.state.activeInSpanish)
        self.addOrder(user: self.findAllUsers()[2], menuDetail: self.findAllMenuDetails()[5], payOnline: true, creditCardType: "mastercard", createdAt: nil, expiresAt: nil, state: Constants.state.activeInSpanish)
        UserDefaults.standard.set(true, forKey: Constants.keys.didPopulateDatabase)
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
    
    func addUser(creditCard: CreditCard?, email: String, password: String, fullName: String, name: String?, lastName: String?, twitter: String, profileUrl: URL, backgroundUrl: URL, followingCount: Int, followersCount: Int) -> Void {
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
        let profileData = try! Data(contentsOf: profileUrl)
        user.profileImage = UIImagePNGRepresentation(UIImage(data: profileData)!)
        let backgroundData = try! Data(contentsOf: backgroundUrl)
        user.backgroundImage = UIImagePNGRepresentation(UIImage(data: backgroundData)!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addFollowerOrFollowing(follower: User, following: User) -> Void {
        let follow = Follow(context: self.context)
        follow.follower = follower
        follow.following = following
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addDish(privateId: String, title: String, info: String, price: Float?, image: UIImage, createdAt: Date?) -> Void {
        let dish = Dish(context: self.context)
        dish.privateId = privateId
        dish.title = title
        dish.info = info
        dish.price = (price == nil) ? 0.000 : price!
        dish.image = UIImagePNGRepresentation(image)
        dish.createdAt = (createdAt == nil) ? Date() : createdAt!
    }
    
    func addDish(privateId: String, title: String, info: String, price: Float?, imageUrl: URL, createdAt: Date?) -> Void {
        let dish = Dish(context: self.context)
        dish.privateId = privateId
        dish.title = title
        dish.info = info
        dish.price = (price == nil) ? 0.000 : price!
        let data = try! Data(contentsOf: imageUrl)
        dish.image = UIImagePNGRepresentation(UIImage(data: data)!)
        dish.createdAt = (createdAt == nil) ? Date() : createdAt!
    }
    
    func addRestaurant(title: String, description: String, image: UIImage, workDays: String, createdAt: Date?, state: String) -> Void {
        let restaurant = Restaurant(context: self.context)
        restaurant.title = title
        restaurant.info = description
        restaurant.image = UIImagePNGRepresentation(image)
        restaurant.createdAt = (createdAt == nil) ? Date() : createdAt!
        restaurant.state = state
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addRestaurant(title: String, description: String, imageUrl: URL, workDays: String, createdAt: Date?, state: String) -> Void {
        let restaurant = Restaurant(context: self.context)
        restaurant.title = title
        restaurant.info = description
        let data = try! Data(contentsOf: imageUrl)
        restaurant.image = UIImagePNGRepresentation(UIImage(data: data)!)
        restaurant.createdAt = (createdAt == nil) ? Date() : createdAt!
        restaurant.state = state
        
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
    
    func addMenu(restaurant: Restaurant, price: Float, initialHour: String, finalHour: String) -> Void {
        let menu = Menu(context: self.context)
        menu.restaurant = restaurant
        menu.price = price
        menu.initialHour = initialHour
        menu.finalHour = finalHour
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addMenuDetail(dish: Dish, menu: Menu, quantity: Int) -> Void {
        let menuDetail = MenuDetail(context: self.context)
        menuDetail.dish = dish
        menuDetail.menu = menu
        menuDetail.quantity = Int32(quantity)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addOrder(user: User, menuDetail: MenuDetail, payOnline: Bool, creditCardType: String, createdAt: Date?, expiresAt: Date?, state: String) -> Void {
        let order = Order(context: self.context)
        order.user = user
        order.menuDetail = menuDetail
        order.payOnline = payOnline
        order.creditCardType = creditCardType
        order.createdAt = (createdAt == nil) ? Date() : createdAt!
        order.expiresAt = (expiresAt == nil) ? Date().addingTimeInterval(2.0 * 60.0) : expiresAt!
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
        } catch {
            print("Error fecthing user data with objectId")
        }
        
        return user
    }
    
    func findAllFollows() -> [Follow] {
        var follows: [Follow] = []
        do {
            follows = try self.context.fetch(Follow.fetchRequest())
        } catch {
            print("Error fetching follow data")
        }
        
        return follows
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
    
    func findFollowings(userId: URL) -> [User] {
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
    
    func findAllRestaurants() -> [Restaurant] {
        var restaurants: [Restaurant] = []
        do {
            restaurants = try self.context.fetch(Restaurant.fetchRequest())
        } catch {
            print("Error fecthing restaurant data")
        }
        
        return restaurants
    }
    
    func findRestaurant(restaurantId: URL) -> Restaurant {
        var restaurant: Restaurant = Restaurant(context: self.context)
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let restaurantObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: restaurantId)
        do {
            let object = try self.context.existingObject(with: restaurantObjectId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            restaurant = try self.context.fetch(fetchRequest)[0]
        } catch {
            print("Error fetching restaurant data with objectId")
        }
        
        return restaurant
    }
    
    func findAllDishes() -> [Dish] {
        var dishes: [Dish] = []
        do {
            dishes = try self.context.fetch(Dish.fetchRequest())
        } catch {
            print("Error fecthing dish data")
        }
        
        return dishes
    }
    
    func findDish(dishId: URL) -> Dish {
        var dish: Dish = Dish(context: self.context)
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
        let dishObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: dishId)
        do {
            let object = try self.context.existingObject(with: dishObjectId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            dish = try self.context.fetch(fetchRequest)[0]
        } catch {
            print("Error fetching dish data with objectId")
        }
        
        return dish
    }
    
    func getThreeDishes() -> [Dish] {
        let dishes = self.findAllDishes()
        return [
            dishes[arc4random_uniform(UInt32(dishes.count)).hashValue],
            dishes[arc4random_uniform(UInt32(dishes.count)).hashValue],
            dishes[arc4random_uniform(UInt32(dishes.count)).hashValue]
        ]
    }
    
    func findAllMenus() -> [Menu] {
        var menus: [Menu] = []
        do {
            menus = try self.context.fetch(Menu.fetchRequest())
        } catch {
            print("Error fetching menu data")
        }
        
        return menus
    }
    
    func findMenu(menuId: URL) -> Menu {
        var menu: Menu = Menu(context: self.context)
        let fetchRequest: NSFetchRequest<Menu> = Menu.fetchRequest()
        let menuObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: menuId)
        do {
            let object = try self.context.existingObject(with: menuObjectId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            menu = try self.context.fetch(fetchRequest)[0]
        } catch {
            print("Error fetching menu data with objectId")
        }
        
        return menu
    }
    
    func findAllMenuDetails() -> [MenuDetail] {
        var menuDetails: [MenuDetail] = []
        do {
            menuDetails = try self.context.fetch(MenuDetail.fetchRequest())
        } catch {
            print("Error fetching menu detail data")
        }
        
        return menuDetails
    }
    
    func findMenuDetail(menuDetailId: URL) -> MenuDetail {
        var menuDetail: MenuDetail = MenuDetail(context: self.context)
        let fetchRequest: NSFetchRequest<MenuDetail> = MenuDetail.fetchRequest()
        let menuDetailObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: menuDetailId)
        do {
            let object = try self.context.existingObject(with: menuDetailObjectId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            menuDetail = try self.context.fetch(fetchRequest)[0]
        } catch {
            print("Error fetching Menu Detail data with objectId")
        }
        
        return menuDetail
    }
    
    func findAllOrders() -> [Order] {
        var orders: [Order] = []
        do {
            orders = try self.context.fetch(Order.fetchRequest())
        } catch {
            print("Error fetching order data")
        }
        
        return orders
    }
    
    func findOrder(orderId: URL) -> Order {
        var order: Order = Order(context: self.context)
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        let orderObjectId = self.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: orderId)
        do {
            let object = try self.context.existingObject(with: orderObjectId!)
            fetchRequest.predicate = NSPredicate(format: "self == %@", object)
            
            order = try self.context.fetch(fetchRequest)[0]
        } catch {
            print("Error fetching order data with objectId")
        }
        
        return order
    }
}
