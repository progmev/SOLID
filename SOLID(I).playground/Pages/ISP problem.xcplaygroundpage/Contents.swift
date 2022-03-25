//: [Previous](@previous)

import UIKit

// MARK: - Bird

class Bird {
    func fly() {}
    func swim() {}
}

let abstractBird = Bird()
abstractBird.fly()
abstractBird.swim()

// MARK: - Duck

class Duck: Bird {
    override func fly() {
        print("I can fly a lot")
    }
    override func swim() {
        print("I can swim a lot")
    }
}

let duck = Duck()
duck.fly()
duck.swim()

// MARK: - Penguin

class Penguin: Bird {
    override func fly() {
        fatalError()
    }

    override func swim() {
        print("Swiming is a life")
    }
}

let penguin = Penguin()
penguin.fly()
penguin.swim()

// попробуем абстракный класс заменить на интерфейс

//: [Next](@next)
