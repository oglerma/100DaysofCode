import UIKit
/******************************************************
 * OPTIONALS
 ******************************************************/
/******************************************************
 *
 ******************************************************/





/******************************************************
 * IF LET AND GUARD LET
 ******************************************************/
/******************************************************
 * FACTS ABOUT GAURD STATMENTS
 *      - You can reuse the constant created in the gaurd statement
 *              outside the guard statment once it has been unwrapped.
 *      - When you "return" from the guard statement it will excit the function.
 *      - You can return a type in the else statment part of the the guard, as
 *              long as you have a return statement and it conforms to the
 *              return value of the function.
 ******************************************************/


var score: Int? = nil
score = 556
if let playerScore = score {
    print("You scored \(playerScore) points.")
}


var menuItems: [String]? = ["Pizza", "Pasta"]
menuItems?.count
menuItems?.append("heelo")
if let items = menuItems {
    print("There are \(String(describing: menuItems?.count)) items to choose from. \(items.count)")
    
    for i in items{
        print("This is items \(i)")
    }
}



func test(number: Int?) {
    guard let number = number else { return }
    print("Number is \(number)")
}
test(number: 42)
test(number: nil)


func uppercase(string: String?) -> String? {
    guard let stringChanged = string else {
        return nil
    }
    
    return stringChanged.uppercased()
}
if let result = uppercase(string: "Hello") {
    print(result)
}


func someStatment(fakename name: String?){
    guard let myNewName = name else { return }
    print("YOur new name is \(myNewName)")
    
}

someStatment(fakename: "Chicky fellow")





/******************************************************
 * OPTIONAL CHAINING
 ******************************************************/
/******************************************************
 *  Review Optional chaining
 *      - Optional chaining allows you to go in deeper into
 *              properties in order for it to allow you to
 *              use different properties created.
 *      - Optional chaining only happens with optionals. This is
 *              common sense but i still make that mistake.
 *      - You can start using the ".someProperty" methods to navigate
 *              through some porperties but when the property that you
 *              need is an optional, it will include a Question Mark "?".
 *              THE REASON:
 *                      So what the question mark is
 *                      doing is checking to see if there is a value to return from
 *                      the Optional. If it sees a value it will return it, unwrappped,
 *                      and move on to the next thing in the chain. Else it will
 *                      return a nil and it won't finish the optional chaining. It
 *                      will make the result nil, but it won't crash your app.
 ******************************************************/


let racers = ["Hamilton", "Verstappen", "Vettel"]
let winnerWasVE = racers.first?.hasPrefix("Ha")

let capitals = ["Scotland": "Edinburgh", "Wales": "Cardiff"]
let scottishCapital = capitals["Scotland"]?.uppercased()

let shoppingList = ["eggs", "tomatoes", "grapes"]
let firstItem = shoppingList.first?.appending(" are on my shopping list")

// Notice that captain Array isn't an optional
// Since we are trying to count the last string we first use .last
// .last is an optional: So what the program is doing is looking for
// a .last, if there is one it will return it unwrapped, if there isn't then
// it will return nil and not continue to count.
let captains = ["Archer", "Lorca", "Sisko"]
let lengthOfBestCaptain = captains.last?.count


let songs: [String]? = [String]()
let finalSong = songs?.last?.uppercased()



/******************************************************
 * NIL COALESCING
 ******************************************************/
/******************************************************
 * FACTS ABOUT NIL COALESCING
 *      - It is a shortcut to the ternary conditional statment (in a sense)
 *      - It unwraps an optional
 *      - Cuts down on using if let statments
 *      - What it does is that it uses the current optional you are trying
 *              to unwrapp and if it has a value inside of it it will return
 *              the value unwrapped. Otherwise, it will return the value of the
 *              type on the right side of the "??", which has to be of the same
 *              tpe as the optional.
 *      - The Left side of the "??" has to be an optional
 *      - The right side of the "??" has to be of the type of the optional on
 *              your left hand side. That way if the optional is nil and can't be
 *              unwrapped, the function would return the right side.
 ******************************************************/


let roomDescription: String? = "You have a bad room"
let roomResult = roomDescription ?? "You have a cool room"
print(roomResult)


// Why not use Guard let and use optional chaining
var value: String? = "hello world"
func getValue(_ value: String?) -> Int {
    guard let value = value else {return 0}
    return value.count
}
print(getValue(value))

// OR YOU CAN DO NIL COALESCING
var otherValue: String? = "Hello world again"
var newvalue = otherValue?.count ?? 0

var powerUsage = "0.1"
let convertedPowerUsage = Double(powerUsage)!
print(4.0 * convertedPowerUsage)


/******************************************************
 * FAILABLE INITIALIZER
 ******************************************************/
/******************************************************
 * FACTS ABOUT FAILABLE INITIALIZER
 *      - Remember first of all that initializer don't have
 *              a return section. You can use "throw" but not "return" with
 *              an intitializer. You can do it in Obj C but not Swift.
 *      - The only exception of return value is that it's possible
 *              to return nil in failable initializers. Meaning that if we
 *              passed an argument to struct when we first initialize it
 *              but the argument was not what we wanted or doesn't conform
 *              to the requirement we set, then we can return a nil instead,
 *              of an object.
 ******************************************************/

// RETURNS NIL
struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
var newPerson = Person(id: "mark")


// CREATES AN OBJECT, DOEST NOT RETURN ANYTHING.
struct Language {
    var code: String
    init?(code: String) {
        if code.hasPrefix("en-") {
            self.code = code
        } else {
            print("Sorry, only English variants are supported." )
            return nil
        }
    }
}
let language = Language(code: "en-GB")

// IF IT IS HARD FOR THE COMPUTER TO DEDUCE WHAT IT SHOULD
// CAST A VARIABLE TOO, THEN IT WILL SET IT TO NIL.

//EXAMPLE 1: RETURNS NIL (BECAUSE IT IS HARD TO DEDUCE)
var rating = "5 STARS"
let convertedRating = Int(rating)

//EXAMPLE 2: RETURNS SETS(BECAUSE IT IS EASIER TO DEDUCE)
//           IT IS STILL AN OPTIONAL, SO WE HAVE TO UNWRAP IT
//           IN ORDER TO USE IT AS AN INT.
var examResult = "100"
let convertedExamResult = Int(examResult)
print(convertedExamResult!)                  // PRINTS OPTIONAL

var enabled = "false"
let convertedEnabled = Bool(enabled)


/******************************************************
 * TYPE CASTING
 ******************************************************/
/******************************************************
 * FACTS ABOUT TYPE CASTING
 *      - With type casting you treat an object as one of another type. The
 *              underlying object doesn’t change, merely the type you use
 *              to describe that object.
 *      - There is a few types of casting. They are:
 *              "UPCASTING AND DOWNCASTING".
 *      - You can DOWNCAST in two ways:
 *              * Optional Downcasting (as?), recommended way
 *              * Force Downcasting    (as!), not recommended
 *      - You can UPCAST in one way and it will always work. Basically,
 *              it is assigning a type to an already exisiting type.
 *              EXAMPLE: var typeCastVariable = "Hello" as Any .
 *              In this example we see a type of Any not a type String.
 *      - Casting really means "COVERTING to a different TYPE" meaning
 *              you can make a variable of type ..  lets say String,
 *              and mark it with an "as Any(or some other type)" and Xcode
 *              will know that from now on what you just created, even though
 *              it looks like a type String (could be any type) it will be of the
 *              type you just assigned it (in this case type Any)
 *      - Great link for Type Casting:
 *              Link: https://learnappmaking.com/type-casting-swift-how-to/
 ******************************************************/

// CREATING A PROTOCOL AND EXTENSION TO THE PROTOCOL
//  THIS IS TO INCORPORATE LEARNING OF:
//              CLASS OVERRIDES OF PROTOCOLS
//              USE OF PROTOCOL STUBS, IF NEEDED
//              USE OF PROTOCOL DEFAULT VALUES
//              DIFFERENTIATE BETWEEN PROTOCOL AND INHERITANCE
protocol Size {
//    var isSmall: Bool {get set}
    func isTheAnimalSmall() -> String
}

extension Size {
    //var isSmall: Bool { get{ return true } set {}}
    func isTheAnimalSmall() -> String {
        return "size is relative!"
    }
    
}

// ANIMAL CLASS
//      TAKES IN A PROTOCOL
class Animal: Size {
    var type: String
    var legs: Int?
    func noiseItMakes(){
        print("Nothing so far")
    }
    
    func isFurry(isFurry: Bool) -> String {
        return isFurry ? "You are so Hairy" : "You bald things"
    }
    
    init(legs: Int?, type: String) {
        self.legs = legs
        self.type = type
    }
    
    
}

// DOG CLASS
//      INHERITS FROM ANIMAL
class Dog: Animal{
    override func noiseItMakes() {
        print("I am a dog so I go .. Bark.. Bark")
    }
    
    func isTheAnimalSmall() -> String {
        return "This dog is as big as a horse"
    }
    var iAmFurry: Bool
    
    init(n: Int, nameType: String){
        self.iAmFurry = true
        super.init(legs: n, type: nameType)
        
    }
    
}

// CAT CLASS
//      INHERITS FROM ANIMAL
class Cat: Animal{
    override func noiseItMakes() {
        print("I am a cat so i go.. Meow.. Meow")
    }
    var iAmFurry: Bool
    
    init(n: Int, nameType: String, iamFurry: Bool){
        self.iAmFurry = iamFurry
        super.init(legs: n, type: nameType)
        
    }
    
}

// PLAYING WITH TYPECASTING USING CLASSES AND PROTOCOLS CREATED ABOVE
let ArrayOfCatsAndDogsTypeAnimal: [Animal] = [Dog(n: 4, nameType: "doggie1"),
                                              Cat(n: 5, nameType: "kittie1", iamFurry: false),
                                              Dog(n: 3, nameType: "doggie2"),
                                              Cat(n: 5, nameType: "kittie2", iamFurry: false),
                                              Dog(n: 2, nameType: "doggie3"),
                                              Cat(n: 5, nameType:"kittie3", iamFurry: false)]

let ArrayOfCatsAndDogsTypeAny: [Any] = [Dog(n: 4, nameType: "anydoggie1"),
                                        Cat(n: 5, nameType: "anykittie1", iamFurry: false),
                                        Dog(n: 3, nameType: "anydoggie2"),
                                        Cat(n: 5, nameType: "anykittie2", iamFurry: false),
                                        Dog(n: 2, nameType: "anydoggie3"),
                                        Cat(n: 5, nameType:"anykittie3", iamFurry: false)]



let catObject = Cat(n: 5, nameType: "anykittie1", iamFurry: false)

// Even though this works, you can only now use the Animal Class and not the Cat
// class.
if let cat = catObject as? Cat{
    print(cat.isFurry(isFurry: true))
    print(cat.legs!)
    print(cat.noiseItMakes())
    print(cat.iAmFurry)
    print(cat.type)
    print(cat.isTheAnimalSmall())
//    print(cat.iamFurry)
}




// ONLY PRINT DOG BARKS (DownCasting Optional)
for typeAnimal in ArrayOfCatsAndDogsTypeAnimal{
    if let dogAnimal = typeAnimal as? Dog {
        print(dogAnimal.isTheAnimalSmall())
    }
}



// ONLY PRINT CAT MEOWS (DownCasting Optional)
for typeAny in ArrayOfCatsAndDogsTypeAny {
    if let anyCat = typeAny as? Cat {
        print(anyCat.type)
    }
}



// UPCASTING

/* Making two Variable of types Any*/
var notString = "HEllo world" as Any
var notNumber = 10 as Any



// YOu only have the option to use the properties and methods from
// the Animal class and not the Dog class.
// in this scenario you have to Downcast in order to access the Dog class.
let snoopDog: Animal = Dog(n: 5, nameType: "Snoop D O double G")
print(type(of: snoopDog.isTheAnimalSmall()))

/******************************************************
 *      - To override a methods in Class or Struct that was created in a protocol
 *              and that had been set as a default in the extension all you have to
 *              do is name the same function in your class as it is written on your
 *              protocol, and change it to the best way it suits you. Keeping in mind
 *              that the function has to have the same name as the protocol method and
 *              the same parameters and return type. They body of the method can be different.
 *      - If you have an Initializer in the Parent class and no Initializer in the child class (Inheritance),
 *              then when you instantiate the Child class you will get the Initializer from
 *              the Parent class. But if you put one variable that needs to be initialized into the child
 *              class then you need to create an init for the child class and you have to use the
 *              super.init() function for the parent class and pass in the parameters it needs. The
 *              reason for this is because you are inheriting the Parents Class "everything". Which means
 *              that since when you create the child class you have to initialize everything, well the child class
 *              is also calling the parent class and the parent class requires that you initialize everyhting that needs
 *              initializing as well.
 *      - You can only INHERIT from one class at a time, but you can pass as many protocols as you want.
 *      - You first need to initialize all of your child variable before you call the super.init() function for you parent
 *              class. Kinda like in an airplane for you have to help yourself before you can help someone else.
 *      - How To Use “as”, “is”, “as!” And “as?”
 *              You can use 4 different syntaxes for casting in Swift:
 *                    - (as)  for upcasting
 *                    - (is)  for type checking
 *                    - (as!) for force downcasting
 *                    - (as?) for optional downcasting
 ******************************************************/

class Reading {
    var value = 0.0
}
class TemperatureReading: Reading { }

let temperature = TemperatureReading()

if let reading = temperature as? TemperatureReading {
    print("The reading is \(reading.value).")
}

let flavor = "apple and mango"
if let taste = flavor as? String {
    print("We added \(taste).")
}


class Bird {
    var wingspan: Double? = nil
}
class Eagle: Bird { }
let bird = Eagle()
if let eagle = bird as? Eagle {
    if let wingspan = eagle.wingspan {
        print("The wingspan is \(wingspan).")
    } else {
        print("This bird has an unknown wingspan.")
    }
}

