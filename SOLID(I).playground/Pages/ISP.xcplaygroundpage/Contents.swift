//: [Previous](@previous)

/*
 Удаляем полностью класс Bird / замещаем ее на протокол Birds тк оба заставляют дочечние классы реализовывать fly + swim
 */

// MARK: - Birds

//protocol Birds {
//    func fly()
//    func swim()
//}

// MARK: - Flying

protocol Flying {
    func fly()
}

// MARK: - Swimming

protocol Swimming {
    func swim()
}

// MARK: - Duck

class Duck: Flying, Swimming {
    func fly() {
        print("I can fly a lot")
    }

    func swim() {
        print("I can swim a lot")
    }
}

// MARK: - Penguin

class Penguin: Swimming {
    func swim() {
        print("Swimming is my life")
    }
}

let penguin = Penguin()
penguin.swim()

let duck = Duck()
duck.fly()
duck.swim()

// Так же можно создавать коллекции через протокольный тип !!!
// Реализуем это!!!

//: [Next](@next)
