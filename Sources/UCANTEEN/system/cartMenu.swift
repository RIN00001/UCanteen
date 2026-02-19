/*
They can view the items in their keranjang (shopping cart) and the total price of the items in the keranjang
They have two options, either to checkout or to remove items from the keranjang
*/

import Foundation

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
