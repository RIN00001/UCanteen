import Foundation

// MARK: - Menu Class
//class menu contains name, price, and description of a menu item
class Menu {
    var name: String
    var price: Double
    var description: String
    
    init(name: String, price: Double, description: String) {
        self.name = name
        self.price = price
        self.description = description
    }
}

// MARK: - Keranjang Class
//Class keranjang (shopping cart) - contains list of items in the cart and total price
class Keranjang {
    var items: [Menu]
    var totalPrice: Double
    
    init(items: [Menu], totalPrice: Double) {
        self.items = items
        self.totalPrice = totalPrice
    }
    
    func addItem(item: Menu) {
        items.append(item)
        totalPrice += item.price
    }
    
    func removeItem(item: Menu) {
        if let index = items.firstIndex(where: { $0.name == item.name }) {
            items.remove(at: index)
            totalPrice -= item.price
        }
    }
}

// MARK: - Shop Class
//Class shop - contains name and menu
class Shop {
    var name: String
    var menu: [Menu]
    
    init(name: String, menu: [Menu]) {
        self.name = name
        self.menu = menu
    }
}

// MARK: - User Class
/*
Class user - contains keranjang (shopping cart) and functions to checkout.
Also be able to check order history
*/
class User {
    var keranjang: Keranjang
    var orderHistory: [Keranjang]
    
    init(keranjang: Keranjang, orderHistory: [Keranjang]) {
        self.keranjang = keranjang
        self.orderHistory = orderHistory
    }
    
    func checkout(payment: Double) -> Bool {
        if payment >= keranjang.totalPrice && payment > 0 {
            orderHistory.append(keranjang)
            keranjang = Keranjang(items: [], totalPrice: 0)
            return true
        } else {
            return false
        }
    }
    
    func checkOrderHistory() -> [Keranjang] {
        return orderHistory
    }
}

// MARK: - Cart Checkout Function
/*
For paying all the item that is in the keranjang (shopping cart)
User inputs payment amount which must be positive and greater than or equal to total price
If payment is insufficient, checkout fails
*/
func cartCheckout(user: User) {
    if user.keranjang.items.isEmpty {
        print("Your cart is empty! Cannot checkout.")
        return
    }
    
    let totalPrice = user.keranjang.totalPrice
    
    print("\n=== Checkout ===")
    print("Total Amount: Rp \(Int(totalPrice))")
    print("\nEnter payment amount: Rp ", terminator: "")
    
    guard let input = readLine(), let payment = Double(input) else {
        print("Invalid amount! Please enter a valid number.")
        return
    }
    
    if payment <= 0 {
        print("Payment must be positive!")
        return
    }
    
    if user.checkout(payment: payment) {
        let change = payment - totalPrice
        print("\n✓ Payment successful!")
        if change > 0 {
            print("Your change: Rp \(Int(change))")
        }
        print("Thank you for your purchase!")
    } else {
        print("\n✗ Payment failed!")
        print("Payment amount (Rp \(Int(payment))) is insufficient.")
        print("Total amount needed: Rp \(Int(totalPrice))")
    }
    
    print("\nPress Enter to continue...")
    _ = readLine()
}

// MARK: - Cart Menu Helper Functions
func removeItemFromCart(user: User) {
    if user.keranjang.items.isEmpty {
        print("Your cart is empty!")
        return
    }
    
    print("\nSelect item to remove:")
    for (index, item) in user.keranjang.items.enumerated() {
        print("\(index + 1). \(item.name) - Rp \(Int(item.price))")
    }
    print("\(user.keranjang.items.count + 1). Cancel")
    
    print("\nEnter item number: ", terminator: "")
    
    guard let input = readLine(), let choice = Int(input) else {
        print("Invalid input!")
        return
    }
    
    if choice >= 1 && choice <= user.keranjang.items.count {
        let removedItem = user.keranjang.items[choice - 1]
        user.keranjang.removeItem(item: removedItem)
        print("\n✓ \(removedItem.name) removed from cart!")
    } else if choice == user.keranjang.items.count + 1 {
        return
    } else {
        print("Invalid choice!")
    }
}

func viewOrderHistory(user: User) {
    print("\n=== Order History ===")
    
    if user.orderHistory.isEmpty {
        print("No order history yet.")
        return
    }
    
    for (index, order) in user.orderHistory.enumerated() {
        print("\nOrder #\(index + 1):")
        for item in order.items {
            print("  - \(item.name) - Rp \(Int(item.price))")
        }
        print("  Total: Rp \(Int(order.totalPrice))")
    }
    
    print("\nPress Enter to continue...")
    _ = readLine()
}

// MARK: - Cart Menu Function
/*
They can view the items in their keranjang (shopping cart) and the total price of the items in the keranjang
They have two options, either to checkout or to remove items from the keranjang
*/
func cartMenu(user: User) {
    while true {
        print("\n=== Shopping Cart ===")
        
        if user.keranjang.items.isEmpty {
            print("Your cart is empty!")
            print("\n1. Back to Main Menu")
            
            print("\nSelect an option: ", terminator: "")
            if let _ = readLine() {
                break
            }
            continue
        }
        
        print("Items in cart:")
        for (index, item) in user.keranjang.items.enumerated() {
            print("\(index + 1). \(item.name) - Rp \(Int(item.price))")
        }
        print("\nTotal Price: Rp \(Int(user.keranjang.totalPrice))")
        
        print("\nOptions:")
        print("1. Checkout")
        print("2. Remove Item")
        print("3. View Order History")
        print("4. Back to Main Menu")
        
        print("\nSelect an option: ", terminator: "")
        
        guard let input = readLine(), let choice = Int(input) else {
            print("Invalid input! Please enter a number.")
            continue
        }
        
        switch choice {
        case 1:
            cartCheckout(user: user)
        case 2:
            removeItemFromCart(user: user)
        case 3:
            viewOrderHistory(user: user)
        case 4:
            break
        default:
            print("Invalid choice! Please try again.")
            continue
        }
        
        if choice == 4 {
            break
        }
    }
}

// MARK: - Shop Menu Function
/*
Shop menu - displays menu items from a specific shop
Users can add items to their cart
*/
func shopMenu(shop: Shop, user: User) {
    while true {
        print("\n=== \(shop.name) ===")
        print("Menu:")
        for (index, item) in shop.menu.enumerated() {
            print("\(index + 1). \(item.name) - Rp \(Int(item.price))")
            print("   \(item.description)")
        }
        print("\(shop.menu.count + 1). Back to Main Menu")
        
        print("\nSelect an item to add to cart (or go back): ", terminator: "")
        
        guard let input = readLine(), let choice = Int(input) else {
            print("Invalid input! Please enter a number.")
            continue
        }
        
        if choice >= 1 && choice <= shop.menu.count {
            let selectedItem = shop.menu[choice - 1]
            user.keranjang.addItem(item: selectedItem)
            print("\n✓ \(selectedItem.name) added to cart!")
            print("Current cart total: Rp \(Int(user.keranjang.totalPrice))")
        } else if choice == shop.menu.count + 1 {
            break
        } else {
            print("Invalid choice! Please try again.")
        }
    }
}

// MARK: - Create Shops Function
func createShops() -> [Shop] {
    // Create sample menu items for Shop 1
    let shop1Menu = [
        Menu(name: "Nasi Goreng", price: 15000, description: "Fried rice with vegetables"),
        Menu(name: "Mie Goreng", price: 13000, description: "Fried noodles"),
        Menu(name: "Ayam Goreng", price: 18000, description: "Fried chicken with rice")
    ]
    
    // Create sample menu items for Shop 2
    let shop2Menu = [
        Menu(name: "Soto Ayam", price: 12000, description: "Chicken soup"),
        Menu(name: "Bakso", price: 10000, description: "Meatball soup"),
        Menu(name: "Gado-Gado", price: 11000, description: "Vegetable salad with peanut sauce")
    ]
    
    // Create sample menu items for Shop 3
    let shop3Menu = [
        Menu(name: "Es Teh", price: 3000, description: "Iced tea"),
        Menu(name: "Es Jeruk", price: 5000, description: "Orange juice"),
        Menu(name: "Kopi", price: 4000, description: "Coffee")
    ]
    
    return [
        Shop(name: "Warung Makan Ibu Siti", menu: shop1Menu),
        Shop(name: "Kantin Pak Budi", menu: shop2Menu),
        Shop(name: "Minuman Segar", menu: shop3Menu)
    ]
}

// MARK: - Main Menu Function
/*mainMenu - contains the main menu of the canteen, which is a list of shops
If any miss input happens, they will be redirected to the main menu again
*/
func mainMenu(user: User) {
    // Create sample shops with menus
    let shops = createShops()
    
    while true {
        print("\n=== UCanteen Main Menu ===")
        print("Available Shops:")
        for (index, shop) in shops.enumerated() {
            print("\(index + 1). \(shop.name)")
        }
        print("\(shops.count + 1). View Cart")
        print("\(shops.count + 2). Exit")
        
        print("\nSelect an option: ", terminator: "")
        
        guard let input = readLine(), let choice = Int(input) else {
            print("Invalid input! Please enter a number.")
            continue
        }
        
        if choice >= 1 && choice <= shops.count {
            shopMenu(shop: shops[choice - 1], user: user)
        } else if choice == shops.count + 1 {
            cartMenu(user: user)
        } else if choice == shops.count + 2 {
            print("Thank you for using UCanteen!")
            break
        } else {
            print("Invalid choice! Please try again.")
        }
    }
}

// MARK: - Main Execution
// Initialize user with empty cart and order history
let user = User(keranjang: Keranjang(items: [], totalPrice: 0), orderHistory: [])

// Call main menu
mainMenu(user: user)
