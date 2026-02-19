/*
For paying all the item that is in the keranjang (shopping cart)
User inputs payment amount which must be positive and greater than or equal to total price
If payment is insufficient, checkout fails
*/

import Foundation

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

