import UIKit

/**************************************************
 * LAZY PROPERTIES
 **************************************************/
/**************************************************
 * FACTS ABOUT LAZY PROPERTIES
 *
 *
 *
 *
 *
 *
 **************************************************/




















/**************************************************
 * STATIC PROPERTIES AND METHODS
 **************************************************/
/**************************************************
 * FACTS ABOUT STATIC PROPERTIES AND METHODS
 *      - Static properties and Methods belong to the
 *              Class itself, not the instance of the class.
 *              Meaning that even though the property or method
 *              exist inside the class, it is assigned only to
 *              the class and not the object you created.
 *      - You cannot override them in another struct unlike classes.
 *      -
 *
 **************************************************/

struct Team {
    
    static var numOfPlayers: Int = 0
    static var numOfBalls: Int {get{ return numOfPlayers * 2}}
    
    var playerName: String
    
    init(playerName: String) {
        self.playerName = playerName
        Team.numOfPlayers += 1
        
    }
}


var teamArray = [Team]()
for i in 1...10 {
    print("This is the number of players: \(Team.numOfPlayers)")
    print("This is the number of balls: \(Team.numOfBalls)")
    teamArray.append(Team(playerName: "Player \(i)"))
}

print(Team.numOfPlayers)
print(Team.numOfBalls)


for name in teamArray{
    print(name.playerName)
}



/**************************************************
 * ACCESS CONTROL
 **************************************************/
/**************************************************
 * FACTS ABOUT ACCESS CONTROL
 *      - If there is a private property or method anywhere inside
 *              the Struct, it is not possible to see all
 *              the other variables and you will have to
 *              provide an init for the struct. Otherwise,
 *              if there is no private properties or methods
 *              then you don't have to provide an init() function
 *              because it comes included with the struct.
 **************************************************/

// PRIVATE ACCESS CONTROL REQUIREMENTS
struct SecretAgent {
    private var actualName: String
    public var codeName: String
    init(name: String, codeName: String) {
        self.actualName = name
        self.codeName = codeName
    }
}
let bond = SecretAgent(name: "James Bond", codeName: "007")


// PRIVATE ACCESS CONTROL REQUIREMENTS
struct Doctor {
    public var name: String
    public var location: String
    private var currentPatient = "No one"
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}

let dasd = Doctor(name: "Dr. Do-Little", location: "Miami")
struct RebelBase {
    private var location: String
    private var peopleCount: Int
    init(location: String, people: Int) {
        self.location = location
        self.peopleCount = people
    }
}
let base = RebelBase(location: "Yavin", people: 1000)

struct School {
    var staffNames: [String]
    private var studentNames: [String]
    
    // The String that is passed is now a countable.
    // It is made into an array or Strings.
    init(staff: String...) {
        self.staffNames = staff
        self.studentNames = [String]()
    }
}
let royalHigh = School(staff: "Mrs Hughes")
royalHigh.staffNames

