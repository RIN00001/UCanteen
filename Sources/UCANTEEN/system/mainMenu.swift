/*mainMenu - contains the main menu of the canteen, which is a list of shops
If any miss input happens, they will be redirected to the main menu again
*/

import Foundation

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
