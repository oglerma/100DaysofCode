import UIKit


// Associated Values for Enums
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
    
    /******************************************
     * After we have intantiated a case then we
     * can call for the function. This function
     * will use the case that we selected and
     * get the Associated value we assigend to it
     * and return it back to us with an additional
     * string that we included.
     ******************************************/
    func whatWeAreDoing() -> String {
        switch self {
        case .bored:
            return "I'm Still bored"
        case .running(let destination):
            return "THis is the running destination \(destination)"
        case .talking(let topic):
            return "THis is the talking topic \(topic)"
        case .singing(let volume):
            return "THis is the singing volume \(volume)"
        }
    }
}


let talking = Activity.talking(topic: "football")
talking.whatWeAreDoing()


let bored = Activity.bored.whatWeAreDoing()



/****************************************************
 * Using "ENUMS" with Error Handling Capabilities
 ****************************************************/
enum NetworkError: Error {
    case insecure
    case noWifi(message: String)
}
/* In order for us to use a do,try,catch handlers we have to include with the
 * functions the word "throws" Which means that if the function runs and there is
 * something that you said needed to be done and it doesn't, then you can return an
 * error inside the function. You do this by writing the throw, kinda like a return, keyword
 * next to the throw keyword use the enum that you created and
 */
// Example 1
func downloadData(from url: String) throws -> String {
    if url.hasPrefix("https://") {
        return "This is the best Swift site ever!"
    } else {
        throw NetworkError.insecure
    }
}
if let data = try? downloadData(from: "https://www.hackingwithswift.com") {
    print(data)
} else {
    print("Unable to fetch the data.")
}

// Example 2
func downloadDataNoWifi(from url: String) throws -> String {
    if url.hasPrefix("https://") {
        return "This is the best Swift site ever!"
    } else {
        throw NetworkError.noWifi(message: "You done messed up son")
    }
}

// Calling the throw function
if let datat = try? downloadDataNoWifi(from: "httpr://") {
    print(datat)
}else {
    print("No connection")
}

// Example 3 (AND I THINK IT IS THE BEST EXAMPLE)
do {
    let someVar = try downloadDataNoWifi(from: "asdf")
    print(someVar)
} catch NetworkError.insecure {
    print("It is insecure, you dig: \(NetworkError.insecure)")
} catch NetworkError.noWifi(let message){
    print("There is no connection, this is the result: \(message)")
} catch {
    print("There is an error for function on line 70")
}

/****************************************************
 * Enum with Parameters and Switch statments to
 *  compare an enum.
 ****************************************************/


enum WeatherType{
    case sun
    case wind(speed: Int)
    case rain
    case snow
}


// ONE OF THE VALUES IN THE SWITCH STATMENT CAN HOLD A VALUE WITH THE KEY WORD
// LET AND ASSIGNING IT A VARIABLE. ALSO IT CAN DO A QUICK OPERATIVE STATEMENT AS
// WELL. ANOTHER FUNCTIONALITY FOR SWIFT SWITCH STATEMENT.
func areHatersHating(weather: WeatherType) -> String? {
    
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "Meh"
    case .snow, .wind, .rain:
        return "Hate"
    }
    
}

// If function return an optional and it is not nil, then unwrap it, else if value
// is nil then store the value of "Unknown" into the variable.
var hWeather = areHatersHating(weather: .wind(speed: 5)) ?? "Unknown"
print(hWeather)


















