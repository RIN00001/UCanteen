/*
Class user - contains money, keranjang (shopping cart) and functions to add money and checkout.
Also be able to check order history
*/
class User {
    var money: Double
    var keranjang: Keranjang
    var orderHistory: [Keranjang]
    
    init(money: Double, keranjang: Keranjang, orderHistory: [Keranjang]) {
        self.money = money
        self.keranjang = keranjang
        self.orderHistory = orderHistory
    }
    
    func addMoney(amount: Double) {
        money += amount
    }
    
    func checkout() -> Bool {
        if money >= keranjang.totalPrice {
            money -= keranjang.totalPrice
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