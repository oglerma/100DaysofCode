import UIKit


/***************************************************
 * MAP
 * Use map to loop over a collection and apply the same operation
 * to each element in the collection. The map function returns an array
 * containing the results of applying a mapping or transform function
 * to each item.
 
 * When you use .map this will get the value of the collection that you want to
 * map over, in this case our collection is an array of integers, and it will
 * use that value as a parameter. A map looks sort of like this (value) -> T .
 * So you can use the value in the map and return any type, since the return type
 * is a generic function.
 ***************************************************/


//Example for map using Array
//This is how the autocomplete looks: <#T##transform: (Int) throws -> T##(Int) throws -> T#>
let arrayOfInt = [2,3,4,5,4,7,2]
arrayOfInt.map{print("something else \($0)")}
arrayOfInt.map{$0 * 10}


//Example for maps using Dictionary
// This is how the autocomple looks: <#T##transform: ((key: String, value: Double)) throws -> T##((key: String, value: Double)) throws -> T#>
let bookAmount = ["harrypotter": 100.0 , "junglebook": 100.0]
bookAmount.map{
    print("This is my key: \($0) and my price: \($1)")
}

//Example for maps using enumurated
// We will return the index followed by the number. Here i decided to return
// it as a dictionary but we can return it as whatever we want.
//This is how the autocomplete looks: <#T##transform: ((offset: Int, element: Int)) throws -> T##((offset: Int, element: Int)) throws -> T#>
let arrayOfInt2 = [1,2,4,5]

let indexAndNumber = arrayOfInt2.enumerated().map { return [$0:$1]}
print(indexAndNumber)



/***************************************************
 * Filter
 * Use filter to loop over a collection and return an
 * Array containing only those elements that match an
 * include condition.
 
 For filter there is a closure that is being called,
 it is called "IsIncluded".
 ***************************************************/

// Example for filter using array
// This is how the autocomplete looks: <#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>
let arrayofIntegers = [1,2,3,4,5,6,7,8,9]
let newArrayOfIntegers = arrayofIntegers.filter{ $0 % 2 == 0 }
print(newArrayOfIntegers)

// Example for filter using Dictionary
// This is how the autocomplete looks: <#T##isIncluded: ((key: String, value: Double)) throws -> Bool##((key: String, value: Double)) throws -> Bool#>
let bookAmount2 = ["harrypotter": 100.0 , "junglebook": 200.0]
bookAmount2.filter { (key, value) -> Bool in
    if value <= 100 {
     return true
    }
    return false
}

