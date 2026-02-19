/*
Shop menu - displays menu items from a specific shop
Users can add items to their cart
*/

import Foundation

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
