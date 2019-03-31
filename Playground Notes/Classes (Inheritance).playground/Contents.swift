import UIKit


/*********************************************
 * CLASS
 *********************************************/
/*********************************************
 * FUN FACT ABOUT CLASSES
 *      - When using inheritance, the child class
 *              needs to initialize the Parent class that
 *              it is creating. You can do this by using the
 *              super.init() function to override your parent class.
 *              You will write this super.init() inside your child
 *              class init().
 *      - You cannot use the same name of a class twice.
 *      - YOu cannot use "Circular inheriance", which means that if Class A
 *              inherits from Class B, then Class B cannot inherit form Class A.
 *      - You can override a function from the parent class by simply
 *              creating a new function, in Child Class, exactly like the one
 *              in the parent Class and adding override to the beginning. This
 *              will override whatever it was suppose to do, and add your own
 *              personal solution to the function.
 *      - Classes cannot inherit from Structs
 *      - If you create a Class and you write the Keyword "final" in front
 *              of it, that means that no one can inherit from that class.
 *              So no other class can have the final class as an inheritance
 *              parameter.
 *      - You cannot inherit mulitple classes.
 *********************************************/

class Food {
    var name: String
    var nutritionRating: Int
    init(name: String, nutritionRating: Int) {
        self.name = name
        self.nutritionRating = nutritionRating
    }
}

class Pizza: Food {
    init() {
        super.init(name: "Pizza", nutritionRating: 3)
    }
}


// OVERRIDES IN INHERITANCE
//          IF there are two function with the same name and you don't
//          override them, there will be an erro in xcode.
class Appliance {
    func start() {
        print("Starting...")
    }
}
class Oven: Appliance {
    override func start() {
        print("Not starting")
    }
}
let oven = Oven()
oven.start()



// DEINIT- De- Initializer
// They don't have () like init does.
class Lightsaber{
    deinit {
        print("Fssshhp!")
    }
}



