---
layout: post
title: Notes of Reading 1 - part 3
date: 2021-01-01
---

Full Reading 1 document can be found [here](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/r1.pdf)

## [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html)

Swift provides a variety of control flow statements. These include `while` loops to **perform a task multiple times**; `if`, `guard`, and `switch` statements to **execute different branches of code based on certain conditions**; and statements such as `break` and `continue` to **transfer the flow of execution to another point in your code**.

Swift also provides a `for`-`in` loop that makes it easy to **iterate over arrays, dictionaries, ranges, strings, and other sequences**.

Swift’s `switch` statement is considerably more powerful than its counterpart in many C-like languages. **Cases can match many different patterns**, including interval matches, tuples, and casts to a specific type. Matched values in a `switch` case can be bound to temporary constants or variables for use within the case’s body, and complex matching conditions can be expressed with a `where` clause for each case.

### For-In Loops

```swift
// Iterate an array
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!

// Iterate a dictionary
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs

// Iterate a range
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25

// Ignore the values by using an underscore in place of a variable name
// ... is a closed range operator
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// Prints "3 to the power of 10 is 59049"

// Use the half-open range operator (..<) to include the lower bound
// but not the upper bound
let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
}

// Usage of the stride(from:to:by:) function to skip some values
// It's an open range (not including the value of `to`)
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
}

// Closed range
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
}
```

---

### While Loops

- `while` evaluates its condition **at the start of each pass** through the loop.
- `repeat`-`while` evaluates its condition **at the end of each pass** through the loop.

#### While

```swift
while condition {
    statements
}
```

My code of *Snakes and Ladders* game [using while loop](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID125):

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)  // start from square 0 until 25; in total 26 squares

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0

while square < finalSquare {
    // roll the dice
    diceRoll = Int.random(in: 1...6)
    square += diceRoll
    print("Move to \(square)")
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        let movement = board[square]
        square += movement
        if movement > 0 {
            print("Move forward to \(square) through ladder +\(movement)")
        }
        else if movement < 0 {
            print("Move backward to \(square) through snake \(movement)")
        }
    }
}
print("Game over!")
```

#### Repeat-While

The `repeat`-`while` loop in Swift is analogous to a `do`-`while` loop in other languages.

```swift
repeat {
    statements
} while condition
```

My code of *Snakes and Ladders* game [using repeat-while loop](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID126):

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)  // start from square 0 until 25; in total 26 squares

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0

repeat {
    // move up or down for a snake or a ladder
    let movement = board[square]
    square += movement
    if movement > 0 {
        print("Move forward to \(square) through ladder +\(movement)")
    }
    else if movement < 0 {
        print("Move backward to \(square) through snake \(movement)")
    }

    // roll the dice
    diceRoll = Int.random(in: 1...6)
    square += diceRoll
    print("Move to \(square)")
} while square < finalSquare
print("Game over!")
```

**The structure of the `repeat`-`while` loop is better suited to this game** than the `while` loop in the previous example. In the `repeat`-`while` loop above, `square += board[square]` is always executed *immediately after* the loop’s `while` condition confirms that `square` is still on the board. This behavior removes the need for the array bounds check seen in the `while` loop version of the game described earlier.

------

### Conditional Statements

Make parts of your code *conditional* with the `if` statement and the `switch` statement.

#### If

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// Prints "It's very cold. Consider wearing a scarf."

temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Prints "It's not that cold. Wear a t-shirt."

temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
// Prints "It's really warm. Don't forget to wear sunscreen."

temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}
```

------

#### <span style="background-color:#fffabc">Switch</span>

```swift
switch some value to consider {
case value 1:
    respond to value 1
case value 2,
     value 3:
    respond to value 2 or 3
default:
    otherwise, do something else
}
```

Every `switch` statement must be *exhaustive*. That is, **every possible value of the type being considered must be matched by one of the `switch` cases**. If it’s not appropriate to provide a case for every possible value, you can define a default case to cover any values that are not addressed explicitly. This default case is indicated by the `default` keyword, and must always appear last.

```swift
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
// Prints "The last letter of the alphabet"
```

------

#### <span style="background-color:#fffabc">No Implicit Fallthrough</span>

`switch` statements **do not fall through** the bottom of each case and into the next one by default.

Note: Although `break` is not required in Swift, you can use a `break` statement to match and ignore a particular case or to break out of a matched case before that case has completed its execution. For details, see [Break in a Switch Statement](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html#ID139).

The body of each case ***must* contain at least one executable statement**. It is **not valid** to write the following code, because the first case is empty:

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": // Invalid, the case has an empty body
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// This will report a compile-time error.
```

To make a `switch` with a single case that matches both `"a"` and `"A"`, **combine the two values into a compound case**, separating the values with commas.

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
// Prints "The letter A"
```

------

#### Interval Matching

Values in `switch` cases **can be checked for their inclusion in an interval**. This example uses number intervals to provide a natural-language count for numbers of any size:

```swift
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."
```

------

#### Tuples

You can use tuples to **test multiple values in the same `switch` statement**. Each element of the tuple can be tested against a different value or interval of values. Alternatively, **use the underscore character (`_`)**, also known as the wildcard pattern, **to match any possible value**.

```swift
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"
```

Unlike C, **Swift allows multiple `switch` cases to consider the same value or values**. In fact, the point (0, 0) could match all *four* of the cases in this example. However, **if multiple matches are possible, the first matching case is always used**. The point (0, 0) would match `case (0, 0)` first, and so all other matching cases would be ignored.

------

#### <span style="color:#c0c0c0">Value Bindings</span>

A `switch` case can **name the value or values it matches to temporary constants or variables**, for use in the body of the case. This behavior is known as *value binding*, because the values are **bound to temporary constants or variables within the case’s body**.

```swift
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"
```

This `switch` statement **does not have a `default` case**. The final case, `case let (x, y)`, declares a tuple of two placeholder constants that **can match any value**. Because `anotherPoint` is always a tuple of two values, this case matches all possible remaining values, and a `default` case is not needed to make the `switch` statement exhaustive.

------

#### <span style="color:#c0c0c0">Where</span>

A `switch` case can use a `where` clause to **check for additional conditions**.

```swift
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// Prints "(1, -1) is on the line x == -y"
```

------

#### Compound Cases

**Multiple switch cases that share the same body** can be combined by writing several patterns after `case`, **with a comma between each of the patterns**. If any of the patterns match, then the case is considered to match. The patterns can be written over multiple lines if the list is long. For example:

```swift
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
// Prints "e is a vowel"
```

Compound cases can also **include value bindings**. All of the patterns of a compound case have to include the same set of value bindings, and each binding has to get a value of the same type from all of the patterns in the compound case. This ensures that, no matter which part of the compound case matched, the code in the body of the case can always access a value for the bindings and that the value always has the same type.

```swift
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// Prints "On an axis, 9 from the origin"
```

My own example:

```swift
let alphabet = "A"
switch alphabet {
case "a", "e", "i", "o", "u", "A", "E", "I", "O", "U":
    print("\(alphabet) is a vowel")
case let alphabet where alphabet >= "a" && alphabet <= "z",
     let alphabet where alphabet >= "A" && alphabet <= "Z":
    print("\(alphabet) is a consonant")
default:
    print("\(alphabet) is not a vowel or a consonant")
}
```

---

### Control Transfer Statements

*Control transfer statements* **change the order in which your code is executed**, by **transferring control from one piece of code to another**. Swift has five control transfer statements:

- `continue`
- `break`
- `fallthrough`
- `return` (described in [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html))
- `throw` (described in [Propagating Errors Using Throwing Functions](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html#ID510))

---

#### <span style="color:#c0c0c0">Continue</span>

The `continue` statement tells a loop to **stop what it is doing** and **start again at the beginning of the next iteration** through the loop. It says “I am done with the current loop iteration” without leaving the loop altogether.

```swift
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)
// Prints "grtmndsthnklk"
```

---

#### <span style="background-color:#fffabc">Break</span>

The `break` statement **ends execution of an entire control flow statement immediately**. The `break` statement can be used **inside a `switch` or loop statement** when you want to terminate the execution of the `switch` or loop statement earlier than would otherwise be the case.

##### Break in a Loop Statement

When used inside a loop statement, `break` **ends the loop’s execution immediately** and **transfers control to the code after the loop’s closing brace (`}`)**. No further code from the current iteration of the loop is executed, and no further iterations of the loop are started.

##### Break in a Switch Statement

When used inside a `switch` statement, `break` causes the `switch` statement to **end its execution immediately** and to **transfer control to the code after the `switch` statement’s closing brace (`}`)**.

This behavior can be used to **match and ignore one or more cases in a `switch` statement**. Because Swift’s `switch` statement is **exhaustive** and **does not allow empty cases**, it is sometimes necessary to deliberately match and ignore a case in order to make your intentions explicit. You do this by writing the `break` statement as the entire body of the case you want to ignore. When that case is matched by the `switch` statement, the `break` statement inside the case ends the `switch` statement’s execution immediately.

```swift
let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not be found for \(numberSymbol).")
}
// Prints "The integer value of 三 is 3."
```

---

#### Fallthrough

In Swift, `switch` statements **don’t fall through the bottom of each case and into the next one**. That is, the entire `switch` statement completes its execution as soon as the first matching case is completed.

If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis with the `fallthrough` keyword. The example below uses `fallthrough` to create a textual description of a number.

```swift
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."
```

---

#### <span style="color:#c0c0c0">Labeled Statements</span>

In Swift, you can nest loops and conditional statements inside other loops and conditional statements to create complex control flow structures. However, loops and conditional statements can both use the `break` statement to end their execution prematurely. Therefore, it is sometimes useful to **be explicit about which loop or conditional statement you want a `break` statement to terminate**. Similarly, if you have multiple nested loops, it can be useful to be explicit about which loop the `continue` statement should affect.

To achieve these aims, you can **mark a loop statement or conditional statement with a *statement label***. With a **conditional statement**, you can use a statement label **with the `break` statement** to end the execution of the labeled statement. With a **loop statement**, you can use a statement label **with the `break` or `continue` statement** to end or continue the execution of the labeled statement.

A labeled statement is indicated by **placing a label on the same line as the statement’s introducer keyword, followed by a colon**. Here’s an example of this syntax for a `while` loop, although the principle is the same for all loops and `switch` statements:

```swift
label name: while condition {
    statements
}
```

Example of *Snakes and Ladders* game but with an additional condition:

* To win, you must land exactly on square 25.

Provided example:

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
```

My verbose version:

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)  // start from square 0 until 25; in total 26 squares

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0

gameLoop: repeat {
    diceRoll = Int.random(in: 1...6)
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        print("Reach square \(finalSquare)!")
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        print("diceRoll \(diceRoll) will move us beyond the final square, so roll again")
        continue gameLoop
    case let newSquare:
        square = newSquare
        print("Move to \(square)")
        let movement = board[newSquare]
        square += movement
        if movement > 0 {
            print("Move forward to \(square) through ladder +\(movement)")
        }
        else if movement < 0 {
            print("Move backward to \(square) through snake \(movement)")
        }
    }
} while square != finalSquare
print("Game over!")
```

---

### <span style="background-color:#fffabc">Early Exit</span>

A **`guard`** statement, like an `if` statement, executes statements depending on the Boolean value of an expression. You use a `guard` statement to **require that a condition must be true in order for the code after the `guard` statement to be executed**. Unlike an `if` statement, **a `guard` statement always has an `else` clause**—the code inside the `else` clause is executed if the condition is not true.

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."
```

If that condition is not met, the code inside the **`else` branch** is executed. That branch **must transfer control to exit the code block** in which the `guard` statement appears. It can do this with a control transfer statement such as **`return`, `break`, `continue`, or `throw`, or it can call a function or method that doesn’t return, such as `fatalError(_:file:line:)`**.

**Using a `guard` statement for requirements improves the readability of your code**, compared to doing the same check with an `if` statement. It lets you write the code that’s typically executed without wrapping it in an `else` block, and it lets you keep the code that handles a violated requirement next to the requirement.

---

### <span style="color:#c0c0c0">Checking API Availability</span>

You use an *availability condition* in an `if` or `guard` statement to **conditionally execute a block of code, depending on whether the APIs you want to use are available at runtime**. The compiler uses the information from the availability condition when it verifies that the APIs in that block of code are available.

```swift
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
```

The availability condition above specifies that in iOS, the body of the `if` statement executes only in iOS 10 and later; in macOS, only in macOS 10.12 and later. The last argument, `*`, is required and specifies that on any other platform, the body of the `if` executes on the minimum deployment target specified by your target.

In its general form, the availability condition takes a list of platform names and versions. **You use platform names such as `iOS`, `macOS`, `watchOS`, and `tvOS`**—for the full list, see [Declaration Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID348). In addition to specifying major version numbers like iOS 8 or macOS 10.10, you can specify minor versions numbers like iOS 11.2.6 and macOS 10.13.3.

```swift
if #available(platform name version, ..., *) {
    // statements to execute if the APIs are available
} else {
    // fallback statements to execute if the APIs are unavailable
}
```

---

## [Function](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)

*Functions* are **self-contained chunks of code** that **perform a specific task**. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

Swift’s unified function syntax is **flexible** enough to express anything from a simple C-style function **with no parameter names** to a complex Objective-C-style method **with names and argument labels for each parameter**. Parameters can **provide default values** to simplify function calls and can **be passed as in-out parameters**, which modify a passed variable once the function has completed its execution.

Every function in Swift **has a type**, consisting of the **function’s parameter types and return type**. You can use this type like any other type in Swift, which makes it easy to **pass functions as parameters to other functions**, and to **return functions from functions**. Functions can also be written within other functions to **encapsulate useful functionality within a nested function scope**.

### Defining and Calling Functions

* **Parameters**: named, typed values that the function takes as input
* **Return type**: a type of value that the function will pass back as output when it is done
* **Function name**: describes the task that the function performs
* **Arguments**: the input values that match the types of the function’s parameters passed when the function is "called"
* A function’s arguments must always be provided **in the same order** as the function’s parameter list.

```swift
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
// Prints "Hello, Anna!"
print(greet(person: "Brian"))
// Prints "Hello, Brian!"

// To make the body of this function shorter, you can combine
// the message creation and the return statement into one line:
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Prints "Hello again, Anna!"
```

---

### Function Parameters and Return Values

#### Functions Without Parameters

```swift
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"
```

#### Functions With Multiple Parameters

```swift
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"
```

#### Functions Without Return Values

```swift
func greet(person: String) {
    print("Hello, \(person)!")
}
greet(person: "Dave")
// Prints "Hello, Dave!"

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but does not return a value
```

#### Functions with Multiple Return Values

You can use a **tuple** type as the return type for a function to return **multiple values as part of one compound return value**.

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"
```

Returned values are labeled `min` and `max` so that they **can be accessed by name when querying the function’s return value**.

Note that the tuple’s members **do not need to be named** at the point that **the tuple is returned from the function**, because their names are already **specified as part of the function’s return type**.

##### Optional Tuple Return Types

```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "min is -6 and max is 109"
```

#### Functions With an Implicit Return

If the entire body of the function is a **single expression**, the function **implicitly returns that expression**. For example, both functions below have the same behavior:

```swift
func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// Prints "Hello, Dave!"

func anotherGreeting(for person: String) -> String {
    return "Hello, " + person + "!"
}
print(anotherGreeting(for: "Dave"))
// Prints "Hello, Dave!"
```

Note: The code you write as an implicit return value needs to return some value. For example, **you can’t use `fatalError("Oh no!")` or `print(13)` as an implicit return value**.

---

### <span style="background-color:#fffabc">Function Argument Labels and Parameter Names</span>

Each function parameter has both an *argument label* and a *parameter name*:

* The **argument label** is used when **calling the function**; each argument is written in the function call **with its argument label before it**.
* The **parameter name** is used in the **implementation of the function**. By default, **parameters use their parameter name as their argument label**.

```swift
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```

All parameters **must have unique names**. Although **it’s possible for multiple parameters to have the same argument label**, unique argument labels help make your code more readable.

---

#### <span style="background-color:#fffabc">Specifying Argument Labels</span>

```swift
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."
```

#### Omitting Argument Labels

If you don’t want an argument label for a parameter, **write an underscore (`_`) instead of an explicit argument label** for that parameter.

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)
```

If a parameter has an argument label, **the argument *must* be labeled when you call the function**.

#### Default Parameter Values

```swift
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
```

Place parameters that **don’t have default values at the beginning** of a function’s parameter list, **before the parameters that have default values**. Parameters that don’t have default values are usually more important to the function’s meaning—writing them first makes it easier to recognize that the same function is being called, regardless of whether any default parameters are omitted.

#### <span style="color:#c0c0c0">Variadic Parameters</span>

A *variadic parameter* accepts **zero or more values of a specified type**. You use a variadic parameter to specify that **the parameter can be passed a varying number of input values** when the function is called. Write variadic parameters by inserting **three period characters (`...`) after the parameter’s type name**.

The values passed to a variadic parameter are made available **within the function’s body as an array of the appropriate type**. For example, a variadic parameter with a name of `numbers` and a type of `Double...` is made available within the function’s body as a constant array called `numbers` of type `[Double]`.

```swift
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers
```

Note: A function may have **at most one variadic parameter**.

#### <span style="color:#c0c0c0">In-Out Parameters</span>

**Function parameters are constants** by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error. This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an *in-out parameter* instead.

You write an in-out parameter by **placing the `inout` keyword right before a parameter’s type**. An in-out parameter has a value that is passed *in* to the function, is modified by the function, and is passed back *out* of the function to replace the original value. For a detailed discussion of the behavior of in-out parameters and associated compiler optimizations, see [In-Out Parameters](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID545).

You can only **pass a variable as the argument for an in-out parameter**. You **cannot pass a constant or a literal value as the argument**, because constants and literals cannot be modified. You **place an ampersand (`&`) directly before a variable’s name** when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.

Note: In-out parameters cannot have default values, and variadic parameters cannot be marked as `inout`.

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"
```

Note: In-out parameters are not the same as returning a value from a function. The `swapTwoInts` example above does not define a return type or return a value, but it still modifies the values of `someInt` and `anotherInt`. In-out parameters are an alternative way for a function to have an effect outside of the scope of its function body.

---

### Function Types

Every function has a specific *function type*, made up of **the parameter types** and the **return type of the function**.

```swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
```

The type of both of these functions is `(Int, Int) -> Int`.

```swift
func printHelloWorld() {
    print("hello, world")
}
```

The type of this function is `() -> Void`.

#### Using Function Types

You use function types just like any other types in Swift.

```swift
var mathFunction: (Int, Int) -> Int = addTwoInts

print("Result: \(mathFunction(2, 3))")
// Prints "Result: 5"

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Prints "Result: 6"

let anotherMathFunction = addTwoInts
// anotherMathFunction is inferred to be of type (Int, Int) -> Int
```

#### Function Types as Parameter Types

```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```

#### Function Types as Return Types

```swift
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!
```

---

### Nested Functions

All of the functions you have encountered so far in this chapter have been examples of ***global functions***, which **are defined at a global scope**. You can also define functions **inside the bodies of other functions**, known as ***nested functions***.

**Nested functions are hidden from the outside world** by default, but can still be called and used by their enclosing function. An enclosing function can also **return one of its nested functions to allow the nested function to be used in another scope**.

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
```

