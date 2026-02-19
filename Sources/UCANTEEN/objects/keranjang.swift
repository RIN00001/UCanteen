//Class keranjang (shopping cart) - contains list of items in the cart and total price
import Foundation

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