import UIKit

/*******************************************************
 * STRUCTS - DEFINITION
 *******************************************************/

/*******************************************************
 * FACTS ABOUT STRUCTS
 *      - You don't need to build an initializer since it
 *                  automatically comes with one.
 *      - If your properties and methods are set to "private"
 *                  then you can't call them from the outside.
 *      - If you initialized a property inside the struct it won't
 *                  appear when you create an instance of the struct.
 *      - Structs are of Value type
 *      - Structs cannot inherit from other Structs
 *      - You can use the keyword "fileprivate" on properties and
 *                  you will have the use of the property only
 *                  within the file it is written on, with "private"
 *                  you don't have access of the property outside of the
 *                  struct. Inside the struct you can use it though.
 *      - All properties have to be initialized before creating an object.
 *                  You can do this by either using the default initializer
 *                  or giving the properties a value inside the initializer
 *                  or when you write it inside of the Struct.
 *      - If your property is the same name as the parameter (which is what
 *                  you should aim for) then use "self" before your
 *                  property in order to assign the new parameter to the
 *                  struct property. If the parameter is a different name
 *                  because you made an initializer with the parameter that
 *                  it should return, then you don't need to use the self.
 *                  Xcode will know what property you are using at the
 *                  moment.
 *******************************************************/



struct Sport {
    
    public var nameofSport: String
    public var numberOfCompetitors: Int
    public let isItgood: Bool
    fileprivate var dog: String
    
    
    // Computed property
    var sportStats: String {
        if isItgood {
            return "This is the sport you want: \(nameofSport) and this is the number of copetitiors: \(numberOfCompetitors)"
        } else {
            return "You sport \(nameofSport) is \(dog) not very good"
        }
    }
    
    var printHello: String {return "Hello dude \(dog)"}
}



var theSportILike = Sport(nameofSport: "daf", numberOfCompetitors: 4,
                          isItgood: true, dog: "doggie woo wo")


/*******************************************************
 * COMPUTED PROPERTIES
 *******************************************************/
/*******************************************************
 * FACTS ABOUT COMPUTED PROPERTIES
 *      - They cannot be constants(let) only var
 *      - The do not have an "=" sign when declaring them
 *              Ex:
 *                  Correct:   var printHello: String   { return "hello"}
 *                  Incorrect: var printHello: String = { return "hello"}
 *                  Incorrect: var printHello =         { return "hello"}
 *      - You MUST WRITE a data type when creating a computed property.
 *      - Computed properties returns a value computed from other variable
 *                  or properties inside the struct/file and does not store the
 *                  value in memory.
 *******************************************************/

struct Candle {
    var burnLength: Int
    var alreadyBurned = 0
    
    // Computed property, treated more as a function with a return type
    // than a variable. Hence, we don't add a value to it or pass it anything.
    // It uses the current properties to return a specific value.
    var burnRemaining: Int {
        return burnLength - alreadyBurned
    }
}

var myCandle = Candle(burnLength: 25, alreadyBurned: 6)
myCandle.burnRemaining

struct Dog {
    var breed: String
    var cuteness: Int
    var rating: Void {
        if cuteness < 3 {
            print("That's a cute dog!")
        } else if cuteness < 7 {
            print("That's a really cute dog!")
        } else {
            print("That a super cute dog!")
        }
    }
}
let luna = Dog(breed: "Samoyed", cuteness: 2)



/*******************************************************
 * PROPERTY OBSERVERS
 *******************************************************/
/*******************************************************
 * FACTS ABOUT PROPERTY OBSERVERS
 *      - They are set similar to computed properties
 *              except the keyword used inside the curly
 *              brackets is didSet{} in order to observe
 *              the variable. Everytime the variable changes,
 *              it will call the didset{} method inside
 *              itself and perform whatever is inside.
 *      - They are a variable in which you can store information
 *              but they also have a stored in property that is
 *              called didset{} that has nothing to do with the info
 *              you save inside of your variable.
 *      - willSet and didSet both have a default parameters
 *              newValue and oldValue.
 *      - willSet and didSet will never get called on setting
 *              the initial value of the property.
 *      - willSet and didSet do not have return types.
 *******************************************************/

struct Progress {
    var task: String
    
    // OBSERVER - Treated as a variable. You can save info and use
    // the same variable inside of the didset.
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
    
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

/*******************************************************
 * MUTATING METHODS
 *******************************************************/
/*******************************************************
 * FACTS ABOUT MUTATING METHODS
 *      - First thing to know is that you can't change the
 *              value of a property once it is set inside the
 *              struct. If you want to do this then you have to
 *              make a mutating function in order for this to happen.
 *              It can't happen indivdually, you have use a function
 *              with the keyword "mutating" which tell Xcode that
 *              anything inside the function is now able to be changed.
 *      - If there is a variable that you want to change inside of
 *              your struct, you have the set the object that you just
 *              created into a Variable and not a Let (Constant).
 *******************************************************/


struct Stack {
    var items = [Int]()    // Empty items array (initialized)
    
    // var notItem: [Int]  // Not initialized therefore it would
                           // be required to give this parameter
                           // when creating an instance of Stack.
    
    
    mutating func push(_ item: Int) {
        items.append(item)
        
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    init() {
        items.append(6)
    }
}

var stack = Stack()
stack.push(4)
stack.push(78)
stack.items // [4, 78]
stack.pop()
stack.items // [4]

// LETS VS VARS IN MUTATING PROPERTIES AND METHODS

struct Kindergarten {
    var numberOfScreamingKids = 30
    mutating func handOutIceCream() {
        numberOfScreamingKids = 0
    }
}

// This "kindergardten variable has to be set to Var and not a Let.
// This error pops up when you leave as a constant: "Cannot use mutating member
//                      on immutable value: 'kindergarten' is a 'let' constant"
//
var kindergarten = Kindergarten()
kindergarten.handOutIceCream()


/*******************************************************
 * STRING MANIPULATION
 *          GREAT LINK ON MANIPULATION OF STRINGS
 *          https://useyourloaf.com/blog/swift-string-cheat-sheet/
 *******************************************************/
// .CONTAINS
let word = "chicy bowie wow"
word.contains("bow")                    // true - finds the exact letters

// .REMOVE, .COUNT, .INSERT & .APPEND
var heights = [1.0, 1.2, 1.15, 1.39]
heights.remove(at: 0)                   // removes from wherever i want
heights.count == 3                      // return amount of item in array
heights.insert(6.1, at: 0)              // inserts value where i want
heights.append(9.0)                     // inserts value at end of array


// .HASPREFIX AND .HASSUFFIX
let line = "0001 Some test data here %%%%"
line.hasPrefix("0001")    // true
line.hasSuffix("%%%%")    // true

// .SORTED
var fibonacci = [1, 1, 2, 3, 5, 8]
fibonacci.sorted() == [1, 2, 3, 5, 8]   // sorts all items, doesn't delete



// .INDEX(OF:)
let movies = ["A New Hope", "Empire Strikes Back",
              "Return of the Jedi", "Ankin"]
movies.index(of: "A New Hope") == 1     // Finds the text and returns
                                        // the index number of the text.



struct Person {
    fileprivate var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
        return "My social security number is \(id)"
    }
}

var ed = Person(id: "23345")
ed.id
ed.identify()

var assdfasd = Person(id: "ad")
assdfasd.identify()



struct Country {
    var name: String
    var usesImperialMeasurements: Bool
    init(name: String) {
        self.name = name
        let imperialCountries = ["Liberia", "Myanmar", "USA"]
        if imperialCountries.contains(name) {
            usesImperialMeasurements = true
        } else {
            usesImperialMeasurements = false
        }
    }
}

var myCountry = Country(name: "catville")



struct Media {
    var type: String
    var users: Int
    init() {
        type = "Hello"
        users = 3
    }
    init(type: String) {
        self.type = type
        users = 3
    }
    init(a: String, b: Int) {
        type = a
        users = b
    }
 
}

var asdfei = Media()




struct Language {
    var nameEnglish: String
    var nameLocal: String
    var speakerCount: Int
    init(english: String, local: String, speakerCount: Int) {
        self.nameEnglish = english
        self.nameLocal = local
        self.speakerCount = speakerCount
    }
}
let french = Language(english: "French", local: "français", speakerCount: 220_000_000)


