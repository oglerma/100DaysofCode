import UIKit
// Examples of closures and explanatioin on what they are.


/************************************************************
 * Definition:
 *
 *
 ************************************************************/
/************************************************************
 * Facts:
 *      1. Closures are called Lambdas in other languages and used
 *                  as Blocks in C and OBj C.
 *      2. Closures don't have external parameters, meaning:
 *                  You can't write (to name: String) you have
 *                  to write (name: String), when writing them.
 *      3. Closures are written inside a variable or constant
 *      4. Closures are a Reference type and are stored in the HEAP
 *      5. Closures are like functions but they:
 *                  a. Don't have the Keyword Func
 *                  b. Don't need a name
 *                  c. Does have a Keyword called "in"
 *      6. Closres are, in a sense, inline statments
 *      7.
 *      8.
 *
 ************************************************************/




//START STUDYING BELOW




/************************************************************
 * Declaring simiple Closure, Steps:
 *      1. Create a Var or let(immutable variable)
 *      2. Inside this variable open/close brackets
 *      3. Open/Close parenthesis and add a paramenter if needed.
 *      4. Next to the Parenthesis start with the keyword "in"
 *      5. Write the meat of the function after the keyword
 *
 ************************************************************/

/**************
* MULTIPLY CLOSURE
**************/
let multiply = {(numberToMulitply: Int) in
    print("This is the square root of \(numberToMulitply):  \(numberToMulitply * 2)")
}
multiply(4)

/**************
 * SUBTRACT CLOSURE
 **************/
let subtract = {() -> Int in
    return 10 - 7
}
let saveResult = subtract()
print(saveResult)

/**************
 * SHORTEND SUBTRACT CLOSURE - INLINE
 **************/
let shortSubtract = {return 235 - 30}
let saveShortSubtResult = shortSubtract()
print(saveShortSubtResult)


/************************************************************
 * CLOSURE AS A PARAMETER INSIDE OF A FUNCTION
 ************************************************************/
// Basic Closure with no parameters
let messageInsideOfClosure = {
    print("\nI am the closure that is being used")
}

func aFunctionToUse(theClosureIPassed: () -> Void) {
    print("\nFirst do this print statement then go to closure")
    theClosureIPassed()
    print("\nDo this Print statment after the closure")
}

aFunctionToUse(theClosureIPassed: messageInsideOfClosure)



/************************************************************
 * TRAILING CLOSURES
 *      Instead of making an extra variable there is a thing we
 *      can do when calling a function that has a closure as a
 *      parameter. The closure has to be the last parameter of the
 *      function in order for this to work.
 *      The way it works is that when you call the function
 *      you can open brackets and SEND the closure. The function will
 *      read this as if it is a closure. It will assume that what you are
 *      passing it is a closure.    VIEW EXAMPLES BELOW
 *
 *
 ************************************************************/
//TRAILING CLOSURE WITH NO PARAMETERS
func assembleToy(instruction: () -> Void) {
    instruction()
    print("It's done!")
}
assembleToy {
    // The function assembleToy assumes that this is the parameter
    // that it will receive.
    print("Grok the glib")
}

// TRAILLING CLOSURE WITH PARAMETERS
func repeatAction(count: Int, action: () -> Void) {
    print("perro")
    for _ in 0..<count {
        action()
    }
}
repeatAction(count: 5) {
    // We can still pass a parameter but sisnce the last parameter
    // is a closure then we can call the function this way.
    print("Hello, world!")
}


// Different ways to use closures
var hello: () -> (String) = {return "Hello!"}
var hello1 = {return "Sup man"}
var otherHello = { (numberOfSpanks: Int) in return "Hello Sonny boy i am giving you \(numberOfSpanks) spankings"}
var evenMoreReduced: (Int) -> String = { return "I am the beast boy \($0) you hear!"}

func printOtherHellow(someOperation: (Int) -> String) {
    
    print("Sup son")
    let savedString = someOperation(5)
    print(savedString)
    
    print("Spanking done")
    
}


printOtherHellow(someOperation: otherHello)
printOtherHellow(someOperation: evenMoreReduced)



func getMeasurement(handler: (Double) -> Void) {
    let measurement = 32.2
    handler(measurement)
}
getMeasurement { (measurement: Double) in
    print("It measures \(measurement).")
}

func createInterface(positioning: ([String]) -> Void) {
    print("Creating some buttons")
    let buttons = [
        "Button 1",
        "Button 2",
        "Button 3"
    ]
    positioning(buttons)
}
createInterface { (buttons: [String]) in
    for button in buttons {
        print("I'll place \(button) here...")
    }
}





/************************************************************
 * THREE Different ways to Make TRAILING CLOSURES TO CALL FUNCTIONS
 ************************************************************/
func getDirections(to destination: String, then travel: ([String]) -> Void) {
    let directions = [
        "Go straight ahead",
        "Turn left onto Station Road",
        "Turn right onto High Street",
        "You have arrived at \(destination)"
    ]
    travel(directions)
}
// DO THE TRAILING CLOSURE ON THE OUTSIDE OF THE PARENTHESIS
// NUMBER 1
getDirections(to: "London") { (directions: [String]) in
    print("I'm getting my car.")
    for direction in directions {
        print(direction)
    }
}
// FOLLOW THE WAY IT IS WRITTEN ON THE FUNCTION
// SINCE THE FUNCTION NEED TO RECIEVE AN ARRAY OF STRINGS
// AND RETURN NOTHING THEN WE CAN USE SHORTHAND SYNTAX.
/************************************************************
 * In the trailing funciton below under the "then" we are receiving
 * a function that takes in a value in this case an Array of Strings and
 * does not return anything.
 ************************************************************/
// NUMBER 2
getDirections(to: "Mexico", then: {for i in $0 {
    print("This is i: \(i)")
    }})

// NUMBER 3
var theThenFunction: ([String]) -> Void = {for i in $0 {print("This is shortway \(i)")}}
getDirections(to: "Argentina", then: theThenFunction)






/************************************************************
 * ANOTHER EXAMPLE OF MULTIPLE WAYS TO DO TRAILING CLOSURES
 * WE USE THE SAME FUNCTION BUT WE CALL IT IN DIFFERENT WAY.
 * WE CALL IT WITH:
 *          * a parameter type defined inside the closure
 *          * using shorthand syntax
 *          * Saving the closure in another variable and passin it.
 *          * using Ternary operations
 *          * using implicit type
 ************************************************************/
func scoreToGrade(score: Int, gradeMapping: (Int) -> String) {
    print("Your score was \(score)%.")
    let result = gradeMapping(score)
    print("That's a \(result).")
}

// ONE WAY - PARAMETER IS DEFINED
scoreToGrade(score: 80) { (grade: Int) in
    if grade < 85 {
        return "Fail"
    }
    return "Pass"
}

print("Next")

// ONE WAY - SHORTHAND SYNTAX
scoreToGrade(score: 90, gradeMapping: {
    if $0 < 85 {
        return "Fail"
    }else {
        return "Pass"
    }
})

// ONE WAY - TERNARY OPERATOR WITH SHORTHAND SYNTAX
scoreToGrade(score: 60, gradeMapping: {return $0 < 85 ? "Fail dude": "Pass Dude"})

// ONE WAY - IMPLICIT TYPE (PARAMETER IS NOT
// DEFINED). IT IMPLIES THAT IT WILL HAVE A
// PARAMENTER OF SOME KIND AND WILL RETURN A STRING.
scoreToGrade(score: 96) { value in
    if value < 85 {
        return "Fail"
    }else {
        return "Pass"
    }
}

// ONE WAY - SAVING CLOSURE INTO A VARIABLE AND THEN
// PASSING THE VARIABLE WHEN CALLING THE FUNCTION ABOVE.
// It doesnt need to see the return type because Xcode infers
// that there will lbe a value given, in this case $0 is the value
// and something will return. In this case we know that when the
// ternary operator makes it's choice it will send something back.
// either Failed boy or Passed man!

let myGrade = {$0 < 85 ? "Failed Boy": "Passed Man!"}
scoreToGrade(score: 67, gradeMapping: myGrade)






func createAgeCheck(strict: Bool) -> (Int) -> Bool {
    if strict {
        return {
            if $0 <= 21 {
                return true
            } else {
                return false
            }
        }
    } else {
        return {
            if $0 <= 18 {
                return true
            } else {
                return false
            }
        }
    }
}
let ageCheck = createAgeCheck(strict: true)
let result = ageCheck(20)
print(result)





func whatIsYourAge(currentAge age: Int, strictAge: (Int)-> String){
    print(strictAge(age))
}
let calculateAge = {$0 >= 21 ? "You are of Age": $0 <= 21 && $0 >= 18 ? "You are cutting it": "YOu are too Young" }

whatIsYourAge(currentAge: 17, strictAge: calculateAge)




// HOW TO WRITE RETURNING CLOSURES FROM FUNCTIONS
// THESE ARE FUNCTIONS THAT ARE MADE TO SPECIFICALLY RETURN
// A CLOSURE SO THAT THE CLOSURE COULD BE USED AT ANOTHER TIME.
// THIS FUNCTIONS JUST BUILD IT IN ORDER TO BE USED LATER.

// ONE WAY - COMPLETLY WRITE THE RETURN.
// THIS FUNCTION RETURNS A FUNCTION. THE FUNCTION THAT
// IS BEING RETURN TAKES AN INT AND RETURNS AN INT.
// HENCE WHY THE TWO RETURNS.
func createDoubler() -> (Int) -> Int {
    return {(thisInt: Int) in
        return thisInt * 2
    }
}
let doubler = createDoubler()
print(doubler(2))

// ONE WAY - SHORTHAND SYNTAX VERSION OF FUNCTION ABOVE
func createDoublerShortHand() -> (Int) -> Int {
    return {
        return $0 * 2
    }
}
let doublerShortHand = createDoublerShortHand()
print(doubler(3))


//CAPTURING VALUES
// WITH CAPTURING VALUES YOU CAN MAINTAIN A COUNT IN THE FUNCTION.
// THIS MEANS THAT WHAT IS INSIDE THE ONE FUNCTION CAN BE USED WITH THE
// RETURN FUNCTION AND IT WILL BE OF REFERENCE TYPE.
func storeTwoValues(value1: String, value2: String) -> (String) -> String {
    var previous = value1
    var current = value2
    return { new in
        let removed = previous
        previous = current
        current = new
        return "Removed \(removed): current is: \(current), Previous is \(previous)"
    }
}
let store = storeTwoValues(value1: "Hello", value2: "World")
let removed = store("Value Three")
print(removed)


// BATTER EXAMPLE
// COUNTING : THIS WOULD BE PERFECT IF WE CREATED A GAME IN WHICH
//            EVERY TIME THE USER MISSED AFTER PRESSING A BUTTON
//            IT WOULD KEEP COUNT AND THE SEND MESSAGE WHEN
//            THE USER MISSES.
func swingBat() -> () -> Void {
    var strikes = 0
    return {
        strikes += 1
        if strikes >= 3 {
            print("You're out!")
        } else {
            print("Strike \(strikes)")
        }
    }
}
let swing = swingBat()
swing()
swing()
swing()



