import UIKit

//Exercise 1

class Post {
    var author: String
    var content: String
    var likes: Int
    
    init(author: String, content: String, likes: Int) {
        self.author = author
        self.content = content
        self.likes = likes
    }
    
    func display() -> String {
        "\"\(content)\" Posted by: \(author) Likes: \(likes)"
        
    }
    
}

let conspiracyTheoryPost = Post(author: "Your Crazy Uncle", content: "Did you know that birds are actually government drones used to spy on us? Wake up, sheeple!", likes: 0)

let overSharingPost = Post(author: "Your Attention-seeking Friend", content: "I'm having spaghetti for dinner! Although I'm still full from the lunch I posted about four hours ago!", likes: 1)

conspiracyTheoryPost.display()
overSharingPost.display()





//Exercise 2

protocol DiscountStrategy {
    var discount: Bool { get set }
}

class NoDiscountStrategy {
    var discount = false
}

class PercentageDiscountStrategy {
    var discount = true
    var price: Double
    
    init(price: Double) {
        self.price = price
    }
  
    func percentOffPrice (priceWithoutDiscount price: Double, percentOff percent: Double) -> Double {
        var decimal: Double = percent/100
        var moneyOff: Double = price*decimal
        var newPrice: Double = price-moneyOff
        return newPrice
    }
}

class Product {
    var name: String
    var price: Double
    var quantity: Int
    
    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

final class ShoppingCartSingleton {
    nonisolated(unsafe) static let singletonCart = ShoppingCartSingleton()
    var shoppingCart: [Product]
    
    private init() {
        self.shoppingCart = []
        
    }
    static func createInstance() -> ShoppingCartSingleton {
        return ShoppingCartSingleton()
       }
    
    func addProduct(product: Product) {
            shoppingCart.append(product)
        }
    func removeProduct(product: Product) {
        shoppingCart.removeAll(where: {
            $0.name == product.name })
        
    }
    func clearCart () {
        shoppingCart.removeAll()
    }
    
    func getTotalPrice() -> Double {
        let prices = shoppingCart.map { $0.price }
        print(prices)
        let totalPrice = prices.reduce(0, +)
        return totalPrice
    }
    
    
}

var yourShoppingCart = ShoppingCartSingleton.createInstance()
var expensiveShirt = Product(name: "shirt", price: 200, quantity: 1)
var packOfGum = Product(name: "Chewing Gum", price: 2, quantity: 1)
var slinky = Product(name: "Slinky", price: 4, quantity: 1)


yourShoppingCart.addProduct(product: expensiveShirt)
yourShoppingCart.addProduct(product: packOfGum)
yourShoppingCart.getTotalPrice()
yourShoppingCart.clearCart()
yourShoppingCart.addProduct(product: slinky)
yourShoppingCart.getTotalPrice()






var shirt = PercentageDiscountStrategy(price: 100)
shirt.percentOffPrice(priceWithoutDiscount: 25, percentOff: 15)






//Exercise 3

protocol PaymentProcessor {
    func processPayment(amount: Double, validCreditCard: Bool?, amountGiven: Double?) throws
}

enum PaymentError: Error {
    case insufficientFunds(String)
    case invalidCreditCard(String)
}

class CreditCardProcessor: PaymentProcessor {
    func processPayment(amount: Double, validCreditCard: Bool?, amountGiven: Double?) throws {
            if validCreditCard == false {
                throw PaymentError.invalidCreditCard("Invalid credit card")
            } else {
                print("Enjoy your purchase!")
            }
    
    }
}

class CashProcessor: PaymentProcessor {
    func processPayment(amount: Double, validCreditCard: Bool?, amountGiven: Double?) throws {
        guard let  unwrappedAmountGiven = amountGiven else {
            return
        }
        if amount > unwrappedAmountGiven {
            throw PaymentError.insufficientFunds("Not enough money")
        } else {
            var change = unwrappedAmountGiven - amount
                    print("Here's your change of $\(change)!")
        }
        
    }
}

do{
    var shirtPurchase = CashProcessor()
    try shirtPurchase.processPayment(amount: 21.99, validCreditCard: nil, amountGiven: 20)
}
catch {
    print("You did not give enough cash for this product.")
}

do{
    var socksPurchase = CreditCardProcessor()
    try socksPurchase.processPayment(amount: 6.99, validCreditCard: false, amountGiven: nil)
}
catch {
    print("Your credit card has been denied.")
}










