// Initialize user with empty cart and order history
let user = User(keranjang: Keranjang(items: [], totalPrice: 0), orderHistory: [])

// Call main menu
mainMenu(user: user)
