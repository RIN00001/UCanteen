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