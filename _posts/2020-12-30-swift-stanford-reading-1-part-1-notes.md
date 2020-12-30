---
layout: post
title: Notes of Reading 1 - part 1
date: 2020-12-30
---

Full Reading 1 document can be found [here](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/r1.pdf)

## [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

### Constants and Variables

#### Declaring Constants and Variables

```swift
// Declare a new constant called maximumNumberOfLoginAttempts,
// and give it a value of 10.
let maximumNumberOfLoginAttempts = 10

// Declare a new variable called currentLoginAttempt, and give
// it an initial value of 0.”
var currentLoginAttempt = 0

// You can declare multiple constants or multiple variables on
// a single line, separated by commas:
var x = 0.0, y = 0.0, z = 0.0
```

#### Type Annotations

```swift
// Declare a variable called welcomeMessage that is of type String.
var welcomeMessage: String

// The welcomeMessage variable can now be set to any string value
// without error:
welcomeMessage = "Hello"

// You can define multiple related variables of the same type on a
// single line, separated by commas, with a single type annotation
// after the final variable name:
var red, green, blue: Double
```

#### Naming Constants and Variables

```swift
// Constant and variable names can contain almost any character,
// including Unicode characters:
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

// You can change the value of an existing variable to another
// value of a compatible type.
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome is now "Bonjour!"

// Unlike a variable, the value of a constant can’t be changed
// after it’s set. Attempting to do so is reported as an error
// when your code is compiled:
let languageName = "Swift"
languageName = "Swift++"
// This is a compile-time error: languageName cannot be changed.
```

#### Printing Constants and Variables

```swift
// You can print the current value of a constant or variable with
// the print(_:separator:terminator:) function:
print(friendlyWelcome)
// Prints "Bonjour!"

// Swift uses string interpolation to include the name of a constant
// or variable as a placeholder in a longer string, and to prompt
// Swift to replace it with the current value of that constant or
// variable. Wrap the name in parentheses and escape it with a
// backslash before the opening parenthesis:
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// Prints "The current value of friendlyWelcome is Bonjour!"
```

---

### Comments

```swift
// This is a comment.

/* This is also a comment
but is written over multiple lines. */

// You write nested comments by starting a multiline comment block and
// then starting a second multiline comment within the first block.
// The second block is then closed, followed by the first block:
/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
This is the end of the first multiline comment. */
```

---

### Semicolons

```swift
// Swift doesn’t require you to write a semicolon (;) after each
// statement in your code.
// However, semicolons are required if you want to write multiple
// separate statements on a single line
let cat = "🐱"; print(cat)
// Prints "🐱"
```

---

### Integers

Swift provides **signed** and **unsigned integers** in **8, 16, 32, and 64 bit** forms. E.g. `UInt8` for an 8-bit unsigned integer, `Int32` for a 32-bit signed integer. These integer types have capitalized names.

#### Integer Bounds

```swift
// You can access the minimum and maximum values of each integer
// type with its min and max properties:
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```

#### Int

Swift provides `Int`, which has the same size as the current platform’s native word size:

- On a 32-bit platform, `Int` is the same size as `Int32`.
- On a 64-bit platform, `Int` is the same size as `Int64`.

Recommendation: Unless you need to work with a specific size of integer, always use `Int` for integer values in your code.

#### UInt

- On a 32-bit platform, `UInt` is the same size as `UInt32`.
- On a 64-bit platform, `UInt` is the same size as `UInt64`.

---

### Floating-Point Numbers

- `Double` represents a 64-bit floating-point number.
- `Float` represents a 32-bit floating-point number.

 Recommendation: In situations where either type would be appropriate, `Double` is preferred.

---

### <span style="background-color:#fffabc">Type Safety and Type Inference</span>

* Swift is a *type-safe* language.
* If you don’t specify the type of value you need, Swift uses *type inference* to work out the appropriate type.

```swift
let meaningOfLife = 42
// meaningOfLife is inferred to be of type Int

let pi = 3.14159
// pi is inferred to be of type Double
// Swift always chooses Double (rather than Float) when inferring
// the type of floating-point numbers.

let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double
```

---

### Numeric Literals

- A *decimal* number, with no prefix
- A *binary* number, with a `0b` prefix
- An *octal* number, with a `0o` prefix
- A *hexadecimal* number, with a `0x` prefix

```swift
// All of these integer literals have a decimal value of 17:
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
```

**Decimal floats** can also have an optional *exponent*, indicated by an uppercase or lowercase `e`; **hexadecimal floats** must have an exponent, indicated by an uppercase or lowercase `p`.

For decimal numbers with an exponent of `exp`, the base number is multiplied by 10<sup>exp</sup>:

- `1.25e2` means 1.25 x 10<sup>2</sup>, or `125.0`.
- `1.25e-2` means 1.25 x 10<sup>-2</sup>, or `0.0125`.

For hexadecimal numbers with an exponent of `exp`, the base number is multiplied by 2<sup>exp</sup>:

- `0xFp2` means 15 x 2<sup>2</sup>, or `60.0`.
- `0xFp-2` means 15 x 2<sup>-2</sup>, or `3.75`. 

All of these floating-point literals have a decimal value of `12.1875`:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
// C = 12, .3 = 3/16 = 0.1875, p0 = 2^0 = 1 -> (12 + 0.1875) * 1
```

Numeric literals can contain extra formatting to **make them easier to read**. **Both integers and floats can be padded with extra zeros** and can **contain underscores** to help with readability. Neither type of formatting affects the underlying value of the literal:

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

---

### <span style="background-color:#fffabc">Numeric Type Conversion</span>

Use the `Int` type for all general-purpose integer constants and variables in your code, **even if they’re known to be nonnegative**. Using the default integer type in everyday situations means that integer constants and variables are immediately interoperable in your code and will match the inferred type for integer literal values.

**Use other integer types only when they’re specifically needed** for the task at hand, because of <u>explicitly sized data from an external source</u>, or <u>for performance, memory usage</u>, or <u>other necessary optimization</u>. Using explicitly sized types in these situations helps to catch any accidental value overflows and implicitly documents the nature of the data being used.

#### Integer Conversion

**A number that won’t fit** into a constant or variable of a sized integer type **is reported as an error** when your code is compiled.

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 cannot store negative numbers, and so this will report an error
let tooBig: Int8 = Int8.max + 1
// Int8 cannot store a number larger than its maximum value,
// and so this will also report an error
```

Values of different types can’t be added together directly. This example calls `UInt16(one)` to create a new `UInt16` initialized with the value of `one`, and uses this value in place of the original:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

`SomeType(ofInitialValue)` is the default way to call the initializer of a Swift type and pass in an initial value. `ofInitialValue` has to be a type for which `SomeType` provides an initializer.

#### Integer and Floating-Point Conversion

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double

let integerPi = Int(pi)
// integerPi equals 3, and is inferred to be of type Int
```

---

### Type Aliases

*Type aliases* define an alternative name for an existing type. You define type aliases with the `typealias` keyword.

```swift
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound is now 0
```

---

### Booleans

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// Prints "Eww, turnips are horrible."
```

**Swift’s type safety prevents non-Boolean values from being substituted for `Bool`.**

```swift
// The following example reports a compile-time error:
let i = 1
if i {
    // this example will not compile, and will report an error
}

// However, the alternative example below is valid:
let i = 1
if i == 1 {
    // this example will compile successfully
}
```

---

### <span style="background-color:#fffabc">Tuples</span>

*Tuples* **group multiple values** into a single compound value. The values within a tuple can be of any type and **don’t have to be of the same type** as each other. You can create tuples from any permutation of types, e.g. `(Int, Int, Int)`, `(String, Bool)`, or any other permutation you require.

```swift
let http404Error = (404, "Not Found")
// http404Error is a tuple of type (Int, String), and equals
// (404, "Not Found")
```

Decompose:

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"

// Ignore parts of the tuple with an underscore
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"

// Access the individual element values in a tuple using index
// numbers starting at zero
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
```

You can **name the individual elements** when it's defined, and you can **use the element names** to access the values of those elements:

```swift
let http200Status = (statusCode: 200, description: "OK")

print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"
```

Note: Tuples are useful for simple groups of related values. They’re **not suited** to the **creation of complex data structures**.

---

### <span style="color: #c0c0c0">Optionals</span>

You use *optionals* in situations where **a value may be absent.** An optional represents two possibilities: Either **there *is* a value, and you can unwrap** the optional to access that value, or **there *isn’t* a value at all**.

Example: `Int` type has an initializer which tries to convert a `String` value into an `Int` value. However, not every string can be converted into an integer.

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"
```

#### nil

You set an optional variable to a **valueless state** by assigning it the special value `nil`:'

```swift
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value
```

If you define an optional variable **without providing a default value**, the variable is automatically **set to `nil`** for you:

```swift
var surveyAnswer: String?
// surveyAnswer is automatically set to nil
```

#### If Statements and Forced Unwrapping

Use `== nil` or `!= nil` to check if they contain a value.

```swift
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// Prints "convertedNumber contains some integer value."
```

*Forced unwrapping* with an exclamation point (`!`) to the end of the optional’s name. Use it when you’re sure that the optional *does* contain a value.

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber has an integer value of 123."
```

#### Optional Binding

You use *optional binding* to find out **whether an optional contains a value**, and if so, to **make that value available as a temporary constant or variable**. Optional binding can be used with `if` and `while` statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action. `if` and `while` statements are described in more detail in [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html).

Write an optional binding for an `if` statement as follows:

```swift
if let constantName = someOptional {
    statements
}

// If you wanted to manipulate the value of actualNumber within
// the first branch of the if statement, use `var`
if var constantName = someOptional {
    statements
}
```

E.g.

```swift
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" could not be converted to an integer")
}
// Prints "The string "123" has an integer value of 123"
```

You can include as many **optional bindings and Boolean conditions** in a single `if` statement as you need to, **separated by commas**. If **any** of the values in the optional bindings **are `nil`** or **any Boolean condition evaluates to `false`,** the whole `if` statement’s condition **is considered to be `false`**. The following `if` statements are equivalent:

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"
```

Note: Constants and variables created with optional binding in an `if` statement **are available only within the body of the `if` statement**.

#### Implicitly Unwrapped Optionals

*Implicitly unwrapped optionals*: **remove the need to check and unwrap the optional’s value every time it’s accessed**, because it can be safely assumed to have a value all of the time. You can think of an implicitly unwrapped optional as **giving permission for the optional to be force-unwrapped if needed**.

You write an implicitly unwrapped optional by placing an exclamation point (`String!`) rather than a question mark (`String?`) after the type that you want to make optional.

The primary use of implicitly unwrapped optionals in Swift is during class initialization.

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation point

let optionalString = assumedString
// The type of optionalString is "String?" and assumedString isn't force-unwrapped.
```

You can check whether an implicitly unwrapped optional is `nil` and use an implicitly unwrapped optional with optional binding the same way you do on a normal optional:

```swift
if assumedString != nil {
    print(assumedString!)
}
// Prints "An implicitly unwrapped optional string."

if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."
```

---

### <span style="color: #c0c0c0">Error Handling</span>

When a function encounters an error condition, it *throws* an error. That function’s caller can then *catch* the error and respond appropriately.

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}

// A do statement creates a new containing scope, which allows errors
// to be propagated to one or more catch clauses.
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}

// An example of how error handling can be used to respond to
// different error conditions:
func makeASandwich() throws {
    // ...
}

do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
```

---

### Assertions and Preconditions

*Assertions* and *preconditions* are checks that happen at **runtime**. If the condition evaluates to `false`, the current state of the program is invalid; code execution ends, and your app is terminated.

**Assertions** help you find mistakes and incorrect assumptions during **development**, and **preconditions** help you detect issues in **production**.

Assertions and preconditions aren’t used for recoverable or expected errors.

<u>Assertions</u> are checked only in **debug builds**, but <u>preconditions</u> are checked in **both debug and production builds**. This means you can use as many assertions as you want during your development process, without impacting performance in production.

#### Debugging with Assertions

```swift
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 is not >= 0.

assert(age >= 0) // You can omit the assertion message
```

If the code already checks the condition, you use the [`assertionFailure(_:file:line:)`](https://developer.apple.com/documentation/swift/1539616-assertionfailure) function to indicate that **an assertion has failed**. For example:

```swift
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}
```

#### Enforcing Preconditions

```swift
// In the implementation of a subscript...
precondition(index > 0, "Index must be greater than zero.")
```

You can also call the [`preconditionFailure(_:file:line:)`](https://developer.apple.com/documentation/swift/1539374-preconditionfailure) function to indicate that **a failure has occurred**—for example, if the default case of a switch was taken, but all valid input data should have been handled by one of the switch’s other cases.

Note:

* If you compile in **unchecked mode** (`-Ounchecked`), **preconditions aren’t checked**. The compiler assumes that preconditions are always true, and it optimizes your code accordingly. However, **the `fatalError(_:file:line:)` function always halts execution, regardless of optimization settings**.
* You can use the `fatalError(_:file:line:)` function during **prototyping and early development** to <u>create stubs for functionality that hasn’t been implemented yet</u>, by writing `fatalError("Unimplemented")` as the stub implementation. Because **fatal errors are never optimized out**, unlike assertions or preconditions, you can be sure that execution always halts if it encounters a stub implementation.

---

## [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html)

### Terminology

Operators are **unary**, **binary**, or **ternary**:

- *Unary* operators operate on a single target (such as `-a`). Unary *prefix* operators appear immediately before their target (such as `!b`), and unary *postfix* operators appear immediately after their target (such as `c!`).
- *Binary* operators operate on two targets (such as `2 + 3`) and are *infix* because they appear in between their two targets.
- *Ternary* operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (`a ? b : c`).

The values that operators affect are *operands*. In the expression `1 + 2`, the `+` symbol is a binary operator and its two operands are the values `1` and `2`.

---

### Assignment Operator

```swift
let b = 10
var a = 5
a = b
// a is now equal to 10
```

If the **right side of the assignment is a tuple** with multiple values, its elements can be **decomposed into multiple** constants or variables at once:

```swift
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
```

Unlike the assignment operator in C and Objective-C, **the assignment operator** in Swift **does not itself return a value**. The following statement is not valid:

```swift
if x = y {
    // This is not valid, because x = y does not return a value.
}
```

---

### Arithmetic Operators

```swift
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0

// The addition operator is also supported for String concatenation:
"hello, " + "world"  // equals "hello, world"
```

The Swift arithmetic operators **don’t allow values to overflow by default**. You can opt in to value overflow behavior by using Swift’s overflow operators (such as `a &+ b`). See [Overflow Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html#ID37).

```swift
let value = UInt8.max  // value is 255
value + 1  // error, because overflow is not allowed by default
value &+ 1  // using overflow operator works, value is 0
```

#### Remainder Operator

```swift
9 % 4    // equals 1
-9 % 4   // equals -1
```

The sign of `b` is ignored for negative values of `b`. This means that `a % b` and `a % -b` always give the same answer.

#### Unary Minus Operator

```swift
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
```

#### Unary Plus Operator

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
```

---

### Compound Assignment Operators

```swift
var a = 1
a += 2  // The expression a += 2 is shorthand for a = a + 2.
// a is now equal to 3
```

---

### Comparison Operators

- Equal to (`a == b`)
- Not equal to (`a != b`)
- Greater than (`a > b`)
- Less than (`a < b`)
- Greater than or equal to (`a >= b`)
- Less than or equal to (`a <= b`)

```swift
1 == 1   // true because 1 is equal to 1
2 != 1   // true because 2 is not equal to 1
2 > 1    // true because 2 is greater than 1
1 < 2    // true because 1 is less than 2
1 >= 1   // true because 1 is greater than or equal to 1
2 <= 1   // false because 2 is not less than or equal to 1

let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".

(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"

("blue", -1) < ("purple", 1)        // OK, evaluates to true
("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
```

---

### <span style="background-color:#fffabc">Ternary Conditional Operator</span>

```swift
// question ? answer1 : answer2
if question {
    answer1
} else {
    answer2
}

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90

// Above example is shorthand for the code below:
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight is equal to 90
```

---

### <span style="color: #c0c0c0">Nil-Coalescing Operator</span>

The *nil-coalescing operator* (`a ?? b`) unwraps an optional `a` if it contains a value, or returns a default value `b` if `a` is `nil`. The expression `a` is always of an optional type. The expression `b` must match the type that is stored inside `a`.

```swift
// a ?? b is shorthand for the code below:
a != nil ? a! : b

let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is not nil, so colorNameToUse is set to "green"
```

---

### <span style="background-color:#fffabc">Range Operators</span>

#### Closed Range Operator

The *closed range operator* (`a...b`) defines a range that runs from `a` to `b`, and includes the values `a` and `b`. The value of `a` must not be greater than `b`.

```swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```

#### Half-Open Range Operator

The *half-open range operator* (`a..<b`) defines a range that runs from `a` to `b`, but doesn’t include `b`.

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack
```

#### One-Sided Ranges

The closed range operator has an alternative form for ranges that **continue as far as possible in one direction**—for example, a range that includes all the elements of an array from index 2 to the end of the array. In these cases, you can omit the value from one side of the range operator. This kind of range is called a *one-sided range* because the operator has a value on only one side. For example:

```swift
for name in names[2...] {
    print(name)
}
// Brian
// Jack

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian

for name in names[..<2] {
    print(name)
}
// Anna
// Alex

let range = ...5
range.contains(7)   // false
range.contains(4)   // true
range.contains(-1)  // true
```

No such stuff: `0..<`

---

### Logical Operators

- Logical NOT (`!a`)
- Logical AND (`a && b`)
- Logical OR (`a || b`)

#### Logical NOT Operator

```swift
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

#### Logical AND Operator

```swift
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

#### Logical OR Operator

```swift
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

#### Combining Logical Operators

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

#### Explicit Parentheses

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```