import UIKit

/***********************************************************
 *  PROTOCOLS
 ************************************************************/
/***********************************************************
 *  FACTS ABOUT PROTOCOLS
 *      - Great link explaining protocols:
 *              https://www.youtube.com/watch?v=QZjz2PL9IS8
 *      -
 ************************************************************/

protocol Identifiable {
    var id: String { get set}
    func identify()
}


struct User: Identifiable {
    func identify() {
        print("This is my stirng id: \(id)")
    }
    
    var id: String

}


func displayId(thing: Identifiable){
    print(thing.id)
}


/***********************************************************
 *  PROTOCOL EXTENSION
 ************************************************************/
/***********************************************************
 *  FACTS ABOUT PROTOCOL EXTENSION
 *      - Great Link explaining protocol extension:
 *              - https://www.youtube.com/watch?v=oqr8Wvn8tCo
 *      - You can use a protocol extension to clearly write
 *              down in the extension how you want the method
 *              or property implemented. You don't have to use
 *              an extension. An extension won't give you an
 *              error if you don't conform to the protocol because
 *              with the extension you are only adding "shortcuts"
 *              in a sense. The error you would get is that if you were
 *              to use the protocol name for a class, struct, or enum it
 *              would ask you to conform to the protocol and write a solution
 *              for each of the things that you have in the protocol.
 ************************************************************/

// Only adding functionality for the function and letting whoever
// uses this protocol too implement the protocol stubs.
protocol Anime {
    var availableLanguages: [String] { get set }
    func watch(in language: String)
}
extension Anime {
    func watch(in language: String) {
        if availableLanguages.contains(language) {
            print("Now playing in \(language)")
        } else {
            print("Unrecognized language.")
        }
    }
}

//  S








//Sets and Array's both conform to a protocol called collection.
// So we can write an extension and add more functionality.
let pyhtons = ["Eric", "Ociel", "Gerardo", "lerma"]
let aSetofPythons = Set(["First", "Second", "Third"])
extension Collection {
    func summarize() {
        print("There are a total of \(self.count) of us")
        for name in self {
            print(name)
        }
    }
}

pyhtons.summarize()



/***********************************************************
 *  EXTENSIONS
 ************************************************************/
/***********************************************************
 *  FACTS ABOUT EXTENSIONS
 *      - Swift doesn’t let you add stored properties in extensions,
 *              so you must use computed properties instead.
 *      - s
 ************************************************************/

protocol Buyable {
    var cost: Int {get set}
}
protocol Sellable {
    func findBuyers() -> [String]
}
protocol FineArt: Buyable, Sellable { }

class Asdf: Buyable {
    var numberToReturn: Int = 0
    var cost: Int {
        get{
            return numberToReturn
        }
        set(newNumber){
            numberToReturn = newNumber
        }
    }
  
    init(cost: Int) {
        numberToReturn = cost
    }
    
}

var asdf = Asdf(cost: 45)
print(asdf.cost )
asdf.cost = 34

asdf.cost


// Since string is a struct you have to mark it as mutating in
// order to change itself.
extension String {
    mutating func appendasdf(_ other: String...) {
        for i in other {
            self += i
        }
    }
}


var hello = "Hello"
hello.appendasdf("Other String", "Dude ")


// You can compare your current value with this property by adding
// a .compareCurrentIntegerWithTheValueOf42 next to the value you
// are comparing.
extension Int {
    var compareCurrentIntegerWithTheValueOf42: Bool {
        return self == 42
    }
}

42.compareCurrentIntegerWithTheValueOf42



extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}

var stringer = "hello"

stringer.withPrefix("hil")

if (5 > 4) {
    print("true")
}else {
    print("False")
}


protocol Adjustable {
    mutating func adjustValue(by amount: Int)
}

