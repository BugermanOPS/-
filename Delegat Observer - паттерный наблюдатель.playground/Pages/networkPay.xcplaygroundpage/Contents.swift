//: [Previous](@previous)

import Foundation
/*                       Задача - телефонная сотовая сеть.
 При изменении тарифа сотовой сети, данные отправляются всем клиентам данной сети.
 - Данные это тариф, минуты, гигабайты.
 - Kлиенты это фирмы, частное лицо и так далее.*/


//1. Создайте класс Mts для хранения информации о тарифе. В этом классе будут свойства, такие как стоимость, минуты, гигабайт и т.д.
class Tariff {
    var cost: Int = 0
    var min: Int = 0
    var gb: Int = 0
    
    init(cost: Int, min: Int, gb: Int) {
        self.cost = cost
        self.min = min
        self.gb = gb
    }
}

//2. Создайте протокол с методом TariffObserver, который будет вызываться при обновлении данных о тарифе.
protocol TariffObserver: AnyObject {
    func update (_ tariff: Tariff)
}

//3. Создайте класс OperatorSubject (субъект - Subject), который будет отслеживать данные о тарифе и уведомлять зарегистрированных наблюдателей о каждом изменении. В этом классе будут методы для регистрации и удаления наблюдателей, а также методы для обновления данных о тарифе.

class OperatorSubject {
    // создание наблюдателей подписанные под протокол "protocol TariffObserverв" массиве.
    private var observers: [TariffObserver] = []
    
    var newTariff: Tariff = .init(cost: 0, min: 0, gb: 0) {
        didSet {
            notification(newTariff)
        }
    }
    
    // добавление наблюдателей в общий массив для дальнейшей рассылки им данных.
    func addObserver(_ observer: TariffObserver) {
        observers.append(observer)
        print("subscribed")
    }
    
    // удаление наблюдателя из общего массива рассылок данных.
    func removeObserver(_ observer: TariffObserver) {
        // поиск наблюдателя в массиве через индекс самого массива.
        if let index = observers.firstIndex(where: {$0 === observer}) {
            // при найденном наблюдатели в массиве, мы удаляем его из этого массива по индексу.
            observers.remove(at: index)
        }
        print("unsubscribed")
    }
    
    // делаем уведомления всем наблюдателям из массива.
    func notification(_ message: Tariff) {
        observers.forEach{ $0.update(message)}
    }
}

class fizLico: TariffObserver {
    let name: String
    let account: Int
    
    init(name: String, account: Int) {
        self.name = name
        self.account = account
    }
    
    func update(_ tariff: Tariff) {
        if account < tariff.cost {
            print("\(name), y меня нет денег, на этот тариф.")
        }
        else {
            print("\(name), я готов оплатить, этот тариф.")
        }
    }
}


class urLico: TariffObserver {
    let companyName: String
    
    init(companyName: String) {
        self.companyName = companyName
    }
    
    func update(_ tariff: Tariff) {
        guard tariff.cost < 200 else {
            print ("\(companyName) cлишком дорого.")
            return
        }
        switch tariff.cost {
        case 0..<100: print("\(companyName), мы готовы оплатить 100 аккаунтов.")
        case 100..<150: print("\(companyName), мы готовы оплатить 50 аккаунтов.")
        case 150..<200: print("\(companyName), мы готовы оплатить 10 аккаунтов.")
        default:
            break
        }
    }
}

let mts = OperatorSubject()

let bob = fizLico(name: "Bob", account: 100)
let jon = fizLico(name: "Jon", account: 10)

let gazprom = urLico(companyName: "Gazprom")
let beeline = urLico(companyName: "Beeline")

mts.addObserver(bob)

let tariffOne = Tariff(cost: 100, min: 1000, gb: 5)
let tariffTwo = Tariff(cost: 50, min: 500, gb: 1)
let tariffThree = Tariff(cost: 500, min: 5000, gb: 10)

mts.addObserver(gazprom)

mts.notification(tariffOne)
