//Class shop - contains name and menu
import Foundation

class Shop {
    var name: String
    var menu: [Menu]
    
    init(name: String, menu: [Menu]) {
        self.name = name
        self.menu = menu
    }
}
