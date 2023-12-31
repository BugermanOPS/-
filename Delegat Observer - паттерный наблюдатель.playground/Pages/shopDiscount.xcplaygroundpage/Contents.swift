//: [Previous](@previous)

// Задачa.

/*    Дан продукт который имеют свойство это название продукта, цена, скидка. Eсть oптовик который готов продать этот продукт клиенту. Оптовик рассылают сообщения клиентам где указывает сам продукт цену и скидку. Клиент делает выбор и решает покупать или нет. */

import Foundation

class Product {
    let nameProduct: String
    let priceProduct: Int
    let discoutnProduct: Int
    
    init(nameProduct: String, priceProduct: Int, discoutnProduct: Int) {
        self.nameProduct = nameProduct
        self.priceProduct = priceProduct
        self.discoutnProduct = discoutnProduct
    }
}

protocol ProductDiscount: AnyObject {
    func update (_ sales: Product)
}

class SabjectProduct {
    var observers: [ProductDiscount] = []
    
    var currentMessage: Product = .init(nameProduct: "", priceProduct: 0, discoutnProduct: 0) {
        didSet {notification(sentMessage: currentMessage)}
    }
    
    func addObserver(_ observer: ProductDiscount) {
        //TODO: как вывести имя нового клиента?
        observers.append(observer)
        print("Добавлен новый клиент, \(observer)")
    }
    
    func removeObserver(_ observer: ProductDiscount) {
        if let index = observers.firstIndex(where: {$0 === observer})
        { observers.remove(at: index) }
        print("Kлиент \(observer) удалён из списка рассылок.")
    }
    
    func notification (sentMessage: Product) {
        observers.forEach{$0.update(sentMessage)}
    }
}

class Client: ProductDiscount {
    let name: String
    let phone: Int
    let account: Int
    
    init(name: String, phone: Int, account: Int) {
        self.name = name
        self.phone = phone
        self.account = account
    }
    
    func update(_ sales: Product) {
        if sales.priceProduct < 100 {
            print("Я готов купить продукт.")
        }
    }
}

//TODO: создание альтернативного класса клиент?

let flowers = Product(nameProduct: "flowers", priceProduct: 120, discoutnProduct: 10)
let orange = Product(nameProduct: "orage", priceProduct: 111, discoutnProduct: 50)
let cola = Product(nameProduct: "Cola", priceProduct: 10, discoutnProduct: 10)

let magnit = SabjectProduct()

let jon = Client(name: "Jon", phone: 12345, account: 23)
let bob = Client(name: "Bob", phone: 2345, account: 11)

magnit.notification(sentMessage: flowers)

magnit.addObserver(jon)
magnit.addObserver(bob)

magnit.notification(sentMessage: flowers)
magnit.notification(sentMessage: cola)
