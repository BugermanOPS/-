//: [Previous](@previous)

import Foundation

//MARK: Cоздаем класс в котором описываем переменные для передачи данных.
class HomeWork {
    let toDoHomeWork: String = ""
}

//MARK: Cоздаем протокол который будет передавать данные.
protocol ToDo: AnyObject {
    func update(_ homeWork: String)
}

//MARK: Cоздаем субъект который отвечает за передачу добавления и удаление наблюдателей.
class Subject{
    var observers: [ToDo] = []
    
    var toDoHomeWork = String() {
        didSet {notification (toDoHomeWork)}
    }
    
    func addObserver (_ observer: ToDo) {
        observers.append(observer)
        print("Добавлен новый наблюдатель:")
    }
    
    func removeObserver (_ observer: ToDo) {
        if let index = observers.firstIndex(where: {$0 === observer})
            {observers.remove(at: index)}
        print("Ударение наблюдателя из списка наблюдателей.")
    }
    
    func notification (_ toDoHomeWork: String) {
            observers.forEach {$0.update(toDoHomeWork)
            }
        print("В списке наблюдателей состоит: \(observers.count) человек.")
    }
}
//
//class Teacher {
//    let name: String
//    let subject: String
//    let homeWork: String = ""
//    
//    init(name: String, subject: String) {
//        self.name = name
//        self.subject = subject
//    }
//}

class Student: ToDo {
    let name: String
    let age: Int
    let course: Int // год обучения, то есть седьмой год обучения.
    init(name: String, age: Int, course: Int) {
        self.name = name
        self.age = age
        self.course = course
    }
    
    func update(_ homeWork: String) {
        print("\(name): Я делаю домашнее задание по теме: \(homeWork)")
    }
}

let math = Subject()

let jon = Student(name: "Jon", age: 20, course: 2)
let stive = Student(name: "Stive", age: 18, course: 3)
let olga = Student(name: "Olga", age: 21, course: 3)

math.addObserver(jon)
math.notification("Dari mira.")

print("")
math.addObserver(olga)
math.notification("Grani kvadrata.")






