import UIKit

let myPassword = "semperFi"

/***************************************************
 * This enum is our Custom Error handling message. The way to use this is
 * when we Use it (i.e. CustomError.wrongPasswordSon(message: "You can type something)
 * then we can print the statment out more carefully later.
 ****************************************************/
enum CustomError: Error {
    case wrongPasswordSon(message: String)
    case justRunBoy(message: String)        // This one will not run just put it here as
                                            // an extra case that we could use.
}

/***************************************************
 * The Way this function works is by putting a throws right before your return
 * type. So since we will throw an exception if the password is not correct then
 * what is going to happen is
 ****************************************************/
func checkYourPassword(insertPassword pw: String) throws -> String {
    
    if pw != myPassword {
        throw CustomError.wrongPasswordSon(message: "Try again broski you entered \(pw) your password is \(myPassword)")
    }
    
    return "The password is \(pw)"
}



/***************************************************
 *  We have to do an entire DO, TRY, CATCH method in order to make
 *  sure that we caught the errors.
 ****************************************************/
do{
    // The reason i am saving it into a constant is because i want to print the statement
    // otherwise the constant was not necessary.
    let myFinishedPassword = try checkYourPassword(insertPassword: "semperFi")
    print("YOu are correct my friend. \(myFinishedPassword)")
} catch CustomError.wrongPasswordSon(let pw) {
    // The reason we have a let variable of "let pw" is because what happens
    // is that when the compiler reaches this place it calls the CustomError property
    // that it saw in the function and stores the messsage of that property from
    // the message we wrote inside and puts it into this let statement. THat is the
    // reason we can use it in the print statement below.
    print("We got a wrong Password Error, This is what it says", "-- \(pw)")
}catch CustomError.justRunBoy(let run) {
    print("Your mom is close by make sure you: ", "-- \(run)") // This one will not run just put it here as
                                                               // an extra case that we could use.
} catch {
    // We put a default catch just in case it pases all the ones we have but
    // we use the error that is already linked to the function, though it is not
    // personalized like the above errors. That is why the error.localizedDescription
    // will show us the not well written error.
    print("Dont know what happened \(error.localizedDescription)")
}


