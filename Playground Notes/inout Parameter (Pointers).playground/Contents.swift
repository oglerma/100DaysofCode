import UIKit


var initialNumer = 2

func doubleInPlace(number: inout Int) {
    number *= 2
}

print("This is initial Number before the function: \(initialNumer)")

// We sue an ampersand to follow the inout procedure
// and allow the initialNumber be added in a function without
// returning it to us.
doubleInPlace(number: &initialNumer)

print("This is initial Number after the function: \(initialNumer)")


// We didn't need to store doubleInPlace in the variable that we declared
// we just added there and didn't give it a return value.


func paintWalls(tastefully: Bool, color: inout String) {
    if tastefully {
        color = "cream"
    } else {
        color = "tartan"
    }
}
var color = ""
paintWalls(tastefully: true, color: &color)
