---
layout: post
title: Stanford CS193p - Reading 1 - part 4
date: 2021-01-02
---

Full Reading 1 document can be found [here](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/r1.pdf)

# Swift Programming Language (cont.)

## [Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)

*Closures* are self-contained **blocks of functionality** that **can be passed around** and used in your code.

**Closures can capture and store references to any constants and variables from the context in which they are defined**. This is known as ***closing over*** those constants and variables. Swift handles all of the memory management of capturing for you.

**Global and nested functions**, as introduced in [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html), are actually **special cases of closures**. Closures take one of three forms:

- **Global functions** are closures that **have a name** and **don’t capture any values**.
- **Nested functions** are closures that **have a name** and can **capture values from their enclosing function**.
- **Closure expressions** are **unnamed closures** written in a **lightweight syntax** that can **capture values from their surrounding context**.

Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These **optimizations** include:

- Inferring parameter and return value types from context
- Implicit returns from single-expression closures
- Shorthand argument names
- Trailing closure syntax

### <span style="background-color:#fffabc">Closure Expressions</span>

*Closure expressions* are a way to **write inline closures in a brief, focused syntax**. Closure expressions provide several **syntax optimizations** for **writing closures in a shortened form without loss of clarity or intent**. The closure expression examples below illustrate these optimizations by refining a single example of the `sorted(by:)` method over several iterations, each of which expresses the same functionality in a more succinct way.

#### The Sorted Method

`sorted(by:)`:

* It sorts an array of values of a known type, based on the output of a **sorting closure** that you provide
* It returns a new array of the same type and size as the old one, with its elements in the correct sorted order.

The closure expression examples below use the `sorted(by:)` method to sort an array of `String` values in **reverse alphabetical order**. Here’s the initial array to be sorted:

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
```

The `sorted(by:)` method accepts **a closure that takes two arguments of the same type as the array’s contents**, and **returns a `Bool` value to say whether the first value should appear before or after the second value once the values are sorted**. The sorting closure needs to **return `true`** if **the first value should appear *before* the second value**, and `false` otherwise.

This example is sorting an array of `String` values, and so the sorting closure needs to be **a function of type `(String, String) -> Bool`**.

One way to provide the sorting closure is to **write a normal function of the correct type**, and to **pass it in as an argument** to the `sorted(by:)` method:

```swift
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```

However, this is a rather long-winded way to write what is essentially a single-expression function (`a > b`). In this example, it would be **preferable to write the sorting closure inline, using closure expression syntax**.

#### Closure Expression Syntax

```swift
{ (parameters) -> return type in
    statements
}
```

The *parameters* in closure expression syntax **can be in-out parameters**, but **they can’t have a default value**. **Variadic parameters can be used if you name the variadic parameter**. **Tuples can also be used as parameter types and return types**.

```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

**The start of the closure’s body** is introduced by the **`in`** keyword. This keyword indicates that **the definition of the closure’s parameters and return type has finished**, and the body of the closure is about to begin.

Because the body of the closure is so short, it can even be written on a single line:

```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
```

#### Inferring Type From Context

Because the sorting closure is passed as an argument to a method, **Swift can infer the types of its parameters and the type of the value it returns**. The `sorted(by:)` method is being called on an array of strings, so its argument must be a function of type `(String, String) -> Bool`. This means that **the `(String, String)` and `Bool` types don’t need to be written** as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (`->`) and the parentheses around the names of the parameters can also be omitted:

```swift
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
```

#### Implicit Returns from Single-Expression Closures

Single-expression closures can **implicitly return the result of their single expression by omitting the `return` keyword** from their declaration, as in this version of the previous example:

```swift
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
```

#### Shorthand Argument Names

Swift automatically provides **shorthand argument names to inline closures**, which can be used to refer to the values of the closure’s arguments by the names `$0`, `$1`, `$2`, and so on.

If you **use these shorthand argument names** within your closure expression, you can **omit the closure’s argument list** from its definition, and **the number and type of the shorthand argument names** will be **inferred from the expected function type**. **The `in` keyword can also be omitted**, because the closure expression is made up entirely of its body:

```swift
reversedNames = names.sorted(by: { $0 > $1 } )
```

Here, `$0` and `$1` refer to the closure’s first and second `String` arguments.

#### Operator Methods

There’s actually an even *shorter* way to write the closure expression above. Swift’s `String` type defines its **string-specific implementation of the greater-than operator (`>`)** as a method that has two parameters of type `String`, and returns a value of type `Bool`. This exactly matches the method type needed by the `sorted(by:)` method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:

```swift
reversedNames = names.sorted(by: >)
```

---

### <span style="background-color:#fffabc">Trailing Closures</span>

If you need to **pass a closure expression** to a function **as the function’s final argument** and **the closure expression is long**, it can be useful to write it as a *trailing closure* instead. You write a **trailing closure after the function call’s parentheses**, even though **the trailing closure is still an argument to the function**. When you use the trailing closure syntax, **you don’t write the argument label** for the first closure as part of the function call. A function call can include multiple trailing closures; however, the first few examples below use a single trailing closure.

```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```

```swift
reversedNames = names.sorted() { $0 > $1 }
```

If a closure expression is provided as the function’s or method’s only argument and you provide that expression as a trailing closure, **you don’t need to write a pair of parentheses `()`** after the function or method’s name when you call the function:

```swift
reversedNames = names.sorted { $0 > $1 }
```

Trailing closures are most useful when the closure is sufficiently long that it is not possible to write it inline on a single line. As an example, Swift’s `Array` type has a **`map(_:)` method**, which **takes a closure expression as its single argument**. The closure is **called once for each item in the array**, and **returns an alternative mapped value** (possibly of some other type) for that item. You specify the nature of the mapping and the type of the returned value by writing code in the closure that you pass to `map(_:)`.

After applying the provided closure to each array element, the `map(_:)` method **returns a new array containing all of the new mapped values**, **in the same order** as their corresponding values in the original array.

Here’s how you can use the `map(_:)` method with a trailing closure to convert an array of `Int` values into an array of `String` values. The array `[16, 58, 510]` is used to create the new array `["OneSix", "FiveEight", "FiveOneZero"]`:

```swift
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
```

If a function takes **multiple closures**, you **omit the argument label for the first trailing closure** and you label **the remaining trailing closures**. For example, the function below loads a picture for a photo gallery:

```swift
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}

loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}

```

---

### <span style="color:#c0c0c0">Capturing Values</span>

---

### <span style="color:#c0c0c0">Closures are Reference Types</span>

---

### <span style="color:#c0c0c0">Escaping Closures</span>

---

### <span style="color:#c0c0c0">Autoclosures</span>

---

## <span style="color:#c0c0c0">Enumerations</span>

## [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html)

*Structures* and *classes* are general-purpose, flexible constructs that become the building blocks of your program’s code. You define **properties** and **methods** to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.

Unlike other programming languages, **Swift doesn’t require you to create separate interface and implementation files for custom structures and classes**. In Swift, you define a structure or class in a single file, and the **external interface** to that class or structure is **automatically made available for other code to use**.

Note: **An instance of a class is traditionally known as an *object***. However, Swift structures and classes are **much closer in functionality** than in other languages, and much of this chapter describes functionality that applies to instances of *either* a class or a structure type. Because of this, **the more general term *instance* is used**.

### Comparing Structures and Classes

Structures and classes in Swift have **many things in common**. Both can:

- Define **properties** to store values
- Define **methods** to provide functionality
- Define **subscripts** to provide access to their values using subscript syntax
- Define **initializers** to set up their initial state
- **Be extended** to expand their functionality beyond a default implementation
- **Conform to protocols** to provide standard functionality of a certain kind

**Classes** have **additional capabilities** that structures don’t have:

- **Inheritance** enables one class to inherit the characteristics of another.
- **Type casting** enables you to check and interpret the type of a class instance at runtime.
- **Deinitializers** enable an instance of a class to **free up any resources it has assigned**.
- **Reference counting** allows more than one reference to a class instance.

The additional capabilities that classes support **come at the cost of increased complexity**. **As a general guideline, prefer structures because they’re easier to reason about**, and **use classes when they’re appropriate or necessary**. In practice, this means most of the custom data types you define will be **structures and enumerations**. For a more detailed comparison, see [Choosing Between Structures and Classes](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes).

### Definition Syntax

```swift
struct SomeStructure {
    // structure definition goes here
}
class SomeClass {
    // class definition goes here
}
```

Note: Whenever you define a **new structure or class**, you **define a new Swift type**. Give **types `UpperCamelCase`** names (such as `SomeStructure` and `SomeClass` here) to match the capitalization of standard Swift types (such as `String`, `Int`, and `Bool`). Give **properties and methods `lowerCamelCase`** names (such as `frameRate` and `incrementCount`) to differentiate them from type names.

```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

#### Structure and Class Instances

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

#### Accessing Properties

```swift
print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"

someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"
```

#### Memberwise Initializers for Structure Types

All **structures** have an **automatically generated *memberwise initializer***, which you can use to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name:

```swift
let vga = Resolution(width: 640, height: 480)
```

Unlike structures, **class instances don’t receive a default memberwise initializer**. Initializers are described in more detail in [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html).

---

### Structures and Enumerations Are Value Types

A ***value type*** is a type whose value is ***copied*** when it’s assigned to a variable or constant, or when it’s passed to a function.

You’ve actually been using value types extensively throughout the previous chapters. In fact, **all of the basic types in Swift**—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—**are value types**, and are **implemented as structures behind the scenes**.

All structures and enumerations are value types in Swift. This means that any structure and enumeration instances you create—and any value types they have as properties—are always copied when they are passed around in your code.

Note: **Collections** defined by the standard library like arrays, dictionaries, and strings **use an optimization to reduce the performance cost of copying**. Instead of making a copy immediately, **these collections share the memory where the elements are stored between the original instance and any copies**. If one of the copies of the collection is modified, **the elements are copied just before the modification**. The behavior you see in your code is always as if a copy took place immediately.

```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
```

This example declares a constant called `hd` and sets it to a `Resolution` instance initialized with the width and height of full HD video (1920 pixels wide by 1080 pixels high).

It then declares a variable called `cinema` and sets it to the current value of `hd`. **Because `Resolution` is a structure, a *copy* of the existing instance is made, and this new copy is assigned to `cinema`**. Even though `hd` and `cinema` now have the same width and height, they are two completely different instances behind the scenes.

```swift
cinema.width = 2048

print("cinema is now \(cinema.width) pixels wide")
// Prints "cinema is now 2048 pixels wide"

print("hd is still \(hd.width) pixels wide")
// Prints "hd is still 1920 pixels wide"
```

<div style="text-align: center;"><img src="/images/2021-01-02-swift-stanford-reading-1-part-4-notes-1.png" style="width: 100%; max-width: 800px" /></div>

The same behavior applies to enumerations:

```swift
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"
```

---

### Classes Are Reference Types

Unlike value types, ***reference types* are *not* copied** when they are assigned to a variable or constant, or when they are passed to a function. Rather than a copy, **a reference to the same existing instance is used**.

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```

Because classes are reference types, `tenEighty` and `alsoTenEighty` actually both refer to the *same* `VideoMode` instance. Effectively, they are just two different names for the same single instance, as shown in the figure below:

<div style="text-align: center;"><img src="/images/2021-01-02-swift-stanford-reading-1-part-4-notes-2.png" style="width: 100%; max-width: 800px" /></div>

```swift
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// Prints "The frameRate property of tenEighty is now 30.0"
```

Note that `tenEighty` and `alsoTenEighty` are **declared as *constants***, rather than variables. However, you can still change `tenEighty.frameRate` and `alsoTenEighty.frameRate` because the values of **the `tenEighty` and `alsoTenEighty` constants** themselves **don’t actually change**. `tenEighty` and `alsoTenEighty` themselves don’t “store” the `VideoMode` instance—instead, they both *refer* to a `VideoMode` instance behind the scenes. **It’s the `frameRate` property of the underlying `VideoMode` that is changed, not the values of the constant references to that `VideoMode`**.

#### Identity Operators

It can sometimes be useful to find out **whether two constants or variables refer to exactly the same instance of a class**. To enable this, Swift provides two identity operators:

* Identical to (`===`)
* Not identical to (`!==`)

```swift
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."
```

Note that *identical to* (represented by three equals signs, or `===`) doesn’t mean the same thing as *equal to* (represented by two equals signs, or `==`). ***Identical to*** means that **two constants or variables of class type refer to exactly the same class instance**. ***Equal to*** means that **two instances are considered equal or equivalent in value**, for some appropriate meaning of *equal*, as defined by the type’s designer.

When you define your own custom structures and classes, it’s your responsibility to decide what qualifies as two instances being equal. The process of defining your own implementations of the `==` and `!=` operators is described in [Equivalence Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html#ID45).

#### Pointers

If you have experience with C, C++, or Objective-C, you may know that these languages use *pointers* to refer to addresses in memory. A Swift constant or variable that **refers to an instance** of some reference type is **similar to a pointer in C**, but isn’t a direct pointer to an address in memory, and doesn’t require you to write an asterisk (`*`) to indicate that you are creating a reference. Instead, **these references are defined like any other constant or variable in Swift**. The standard library provides pointer and buffer types that you can use if you need to interact with pointers directly—see [Manual Memory Management](https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management).

---

## [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)

*Properties* associate **values** with a particular class, structure, or enumeration. **Stored properties store constant and variable values** as part of an instance, whereas **computed properties calculate (rather than store) a value**. **Computed properties** are provided by **classes, structures, and enumerations**. **Stored properties** are provided only by **classes and structures**.

Stored and computed **properties are usually associated with instances** of a particular type. However, **properties can also be associated with the type itself**. Such properties are known as **type properties**.

In addition, you can define **property observers** to **monitor changes in a property’s value**, which you can **respond to with custom actions**. Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits from its superclass.

You can also use a **property wrapper** to **reuse code in the getter and setter of multiple properties**.

### Stored Properties

In its simplest form, a **stored property** is a **constant** or **variable** that is **stored** as **part of an instance** of a particular class or structure. Stored properties can be either *variable stored properties* (introduced by the `var` keyword) or *constant stored properties* (introduced by the `let` keyword).

You can provide a **default value for a stored property as part of its definition**, as described in [Default Property Values](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID206). You can also **set and modify the initial value** for a stored property **during initialization**. This is true even for constant stored properties, as described in [Assigning Constant Properties During Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID212).

The example below defines a structure called `FixedLengthRange`, which describes a range of integers whose range length cannot be changed after it is created:

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8
```

#### Stored Properties of Constant Structure Instances

If you create an instance of a structure and assign that instance to a **constant**, you **cannot modify the instance’s properties**, **even if they were declared as variable properties**:

```swift
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```

Because `rangeOfFourItems` is declared as a constant (with the `let` keyword), it is not possible to change its `firstValue` property, even though `firstValue` is a variable property.

This behavior is due to structures **being *value types***. When an instance of a value type is **marked as a constant**, so **are all of its properties**.

The same is not true for **classes**, which are ***reference types***. If you assign an instance of **a reference type to a constant**, you can still **change that instance’s variable properties**.

#### Lazy Stored Properties

A *lazy stored property* is a property whose **initial value is not calculated until the first time it is used**. You indicate a lazy stored property by writing the `lazy` modifier before its declaration.

Note: You must always **declare a lazy property as a variable** (with the `var` keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value *before* initialization completes, and therefore cannot be declared as lazy.

Lazy properties are useful when the initial value for a property is dependent on outside factors whose values are not known until after an instance’s initialization is complete. Lazy properties are also useful when **the initial value for a property requires complex or computationally expensive setup** that should not be performed unless or until it is needed.

The example below uses a lazy stored property to avoid unnecessary initialization of a complex class. This example defines two classes called `DataImporter` and `DataManager`, neither of which is shown in full:

```swift
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created
```

The `DataManager` class has a stored property called `data`, which is initialized with a new, empty array of `String` values. Although the rest of its functionality is not shown, the purpose of this `DataManager` class is to manage and provide access to this array of `String` data.

Part of the functionality of the `DataManager` class is the ability to import data from a file. This functionality is provided by the `DataImporter` class, which is assumed to take a nontrivial amount of time to initialize. This might be because a `DataImporter` instance needs to open a file and read its contents into memory when the `DataImporter` instance is initialized.

It is possible for a `DataManager` instance to manage its data without ever importing data from a file, so there is no need to create a new `DataImporter` instance when the `DataManager` itself is created. Instead, it makes more sense to create the `DataImporter` instance if and when it is first used.

Because it is marked with the `lazy` modifier, the `DataImporter` instance for the `importer` property is only created when the `importer` property is first accessed, such as when its `filename` property is queried:

```swift
print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"
```

Note: If a property marked with the `lazy` modifier is **accessed by multiple threads simultaneously** and the property has not yet been initialized, **there’s no guarantee that the property will be initialized only once**.

#### Stored Properties and Instance Variables

A Swift property does not have a corresponding instance variable, and **the backing store for a property is not accessed directly**. This approach avoids confusion about how the value is accessed in different contexts and simplifies the property’s declaration into a single, definitive statement. All information about the property—including its name, type, and memory management characteristics—is defined in a single location as part of the type’s definition.

### <span style="color:#c0c0c0">Computed Properties</span>

---

### <span style="color:#c0c0c0">Property Observers</span>

---

### <span style="color:#c0c0c0">Property Wrappers</span>

---

### Global and Local Variables

**Global variables** are variables that are defined **outside** of any function, method, closure, or type context. **Local variables** are variables that are defined **within** a function, method, or closure context.

You can define *computed variables* and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they are written in the same way as computed properties.

Note: **Global** constants and variables are always **computed lazily**, in a similar manner to [Lazy Stored Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID257). Unlike lazy stored properties, **global constants and variables do not need to be marked with the `lazy` modifier**.

**Local** constants and variables are **never computed lazily**.

---

### <span style="background-color:#fffabc">Type Properties</span>

You can define properties that **belong to the type itself**, not to any one instance of that type. There will only ever be **one** copy of these properties, no matter how many instances of that type you create. These kinds of properties are called *type properties*.

Type properties are useful for defining values that are **universal to *all* instances** of a particular type, such as a **constant property that all instances can use** (like a static constant in C), or a variable property that **stores a value that is global to all instances of that type** (like a static variable in C).

**Stored** type properties can be **variables or constants**. **Computed** type properties are always declared as **variable properties**, in the same way as computed instance properties.

Note: Unlike stored instance properties, you must **always** give stored type properties a **default value**. This is because the type itself **does not have an initializer** that can assign a value to a stored type property at initialization time.

Stored type properties are **lazily initialized on their first access**. They are guaranteed to be **initialized only once**, even when accessed by multiple threads simultaneously, and they do not need to be marked with the `lazy` modifier.

#### Type Property Syntax

Type properties are written as part of the type’s definition, **within the type’s outer curly braces**, and each type property is explicitly scoped to the type it supports.

You define type properties with the **`static`** keyword. For **computed type properties** for **class types**, you can use the **`class` keyword** instead to **allow subclasses to override the superclass’s implementation**. The example below shows the syntax for stored and computed type properties:

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
```

Note: The computed type property examples above are for read-only computed type properties, but you can also **define read-write computed type properties** with the same syntax as for computed instance properties.

#### Querying and Setting Type Properties

Type properties are queried and set with **dot syntax**, just like instance properties. However, type properties are **queried and set on the *type***, not on an instance of that type. For example:

```swift
print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"
```

The examples that follow use two stored type properties as part of a structure that models an audio level meter for a number of audio channels. Each channel has an integer audio level between `0` and `10` inclusive.

The figure below illustrates how two of these audio channels can be combined to model a stereo audio level meter. When a channel’s audio level is `0`, none of the lights for that channel are lit. When the audio level is `10`, all of the lights for that channel are lit. In this figure, the left channel has a current level of `9`, and the right channel has a current level of `7`:

<div style="text-align: center;"><img src="/images/2021-01-02-swift-stanford-reading-1-part-4-notes-3.png" style="width: 100%; max-width: 200px" /></div>

The audio channels described above are represented by instances of the `AudioChannel` structure:

```swift
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// Prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "10"
```

---

## [Methods](https://docs.swift.org/swift-book/LanguageGuide/Methods.html)

*Methods* are **functions** that are **associated with a particular type**. **Classes, structures, and enumerations** can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures, and enumerations can also define **type methods**, which are **associated with the type itself**.

### Instance Methods

```swift
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0
```

#### The self Property

Every instance of a type has an implicit property called `self`, which is exactly equivalent to **the instance itself**. You use the `self` property to refer to the current instance within its own instance methods.

```swift
func increment() {
    self.count += 1
}
```

In practice, **you don’t need to write `self` in your code very often**. If you don’t explicitly write `self`, Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method. This assumption is demonstrated by the use of `count` (rather than `self.count`) inside the three instance methods for `Counter`.

The main exception to this rule occurs when a parameter name for an instance method **has the same name** as a property of that instance. In this situation, **the parameter name takes precedence**, and it becomes necessary to refer to the property in a more qualified way. You use the `self` property to distinguish between the parameter name and the property name.

```swift
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"
```

Without the `self` prefix, Swift would assume that both uses of `x` **referred to the method parameter** called `x`.

#### <span style="background-color:#fffabc">Modifying Value Types from Within Instance Methods</span>

Structures and enumerations are *value types*. **By default, the properties of a value type cannot be modified from within its instance methods.**

```swift
struct Point {
    var x = 0.0, y = 0.0
    // error: repl.swift:4:11: error: left side of mutating operator isn't mutable: 'self' is immutable 
    func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
```

However, if you need to modify the properties of your structure or enumeration within a particular method, you can **opt in to *mutating* behavior** for that method. The method can then mutate (that is, change) its properties from within the method, and **any changes that it makes are written back to the original structure when the method ends**. The method **can also assign a completely new instance to its implicit `self` property**, and this new instance will replace the existing one when the method ends.

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")
// Prints "The point is now at (3.0, 4.0)"
```

Note that **you cannot call a mutating method on a constant of structure type**, because its properties cannot be changed, even if they are variable properties, as described in [Stored Properties of Constant Structure Instances](https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID256):

```swift
let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveBy(x: 2.0, y: 3.0)
// this will report an error
```

#### <span style="color:#c0c0c0">Assigning to self Within a Mutating Method</span>

Mutating methods can **assign an entirely new instance to the implicit `self` property**. The `Point` example shown above could have been written in the following way instead:

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
```

Mutating methods for enumerations can set the implicit `self` parameter to be a different case from the same enumeration:

```swift
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off
```

---

### <span style="background-color:#fffabc">Type Methods</span>

You can define methods that are **called on the type itself**. These kinds of methods are called *type methods*. You indicate type methods by writing the `static` keyword before the method’s `func` keyword. **Classes can use the `class` keyword instead, to allow subclasses to override the superclass’s implementation of that method**.

Note: In Swift, you can define **type-level methods** for all **classes, structures, and enumerations**. Each type method is explicitly scoped to the type it supports.

Type methods are called with **dot syntax**, like instance methods. However, you call type methods on the type, not on an instance of that type. Here’s how you call a type method on a class cailled `SomeClass`:

```swift
class SomeClass {
    class func someTypeMethod() {
        // type method implementation goes here
    }
}
SomeClass.someTypeMethod()
```

Within the body of a type method, the **implicit `self` property** refers to **the type itself**, rather than an instance of that type. This means that you can use `self` to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.

```swift
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
// Prints "level 6 has not yet been unlocked"
```

---

## <span style="color:#c0c0c0">Subscripts</span>

## <span style="color:#c0c0c0">Inheritance</span>

## [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)

*Initialization* is the process of **preparing an instance of a class, structure, or enumeration for use**. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required **before the new instance is ready for use**.

You implement this initialization process by defining *initializers*, which are like special methods that can be called to create a new instance of a particular type. Swift initializers **do not return a value**. Their primary role is to ensure that new instances of a type are **correctly initialized before they are used for the first time**.

Instances of **class** types can also implement a ***deinitializer***, which performs any **custom cleanup just before an instance of that class is deallocated**. For more information about deinitializers, see [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html).

### Setting Initial Values for Stored Properties

Classes and structures *must* set **all of their stored properties** to an appropriate initial value **by the time an instance of that class or structure is created**. Stored properties cannot be left in an indeterminate state.

You can set an initial value for a stored property **within an initializer**, or by **assigning a default property value** as part of the property’s definition. These actions are described in the following sections.

Note: When you **assign a default value** to a stored property, or set its initial value within an initializer, the value of that property is set directly, **without calling any property observers**.

#### Initializers

*Initializers* are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, **written using the `init` keyword**:

```swift
init() {
    // perform some initialization here
}
```

Example:

```swift
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// Prints "The default temperature is 32.0° Fahrenheit"

```

#### Default Property Values

You specify a default property value by assigning an initial value to the property when it is defined.

Note: If a property always **takes the same initial value**, provide a **default value** rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance, as described later in this chapter.

```swift
struct Fahrenheit {
    var temperature = 32.0
}
```

---

### <span style="background-color:#ffd9d9">Customizing Initialization</span>

You can customize the initialization process with **input parameters** and **optional property types**, or by **assigning constant properties** during initialization, as described in the following sections.

#### Initialization Parameters

You can provide ***initialization parameters* as part of an initializer’s definition**, to define the types and names of values that customize the initialization process. Initialization parameters have the same capabilities and syntax as function and method parameters.

```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0
```

#### Parameter Names and Argument Labels

Initializers **do not** have an **identifying function name** before their parentheses in the way that functions and methods do. Therefore, **the names and types of an initializer’s parameters** play a particularly important role in identifying which initializer should be called. Because of this, Swift provides an **automatic argument label for *every* parameter in an initializer** if you don’t provide one.

```swift
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

let veryGreen = Color(0.0, 1.0, 0.0)
// this reports a compile-time error - argument labels are required
```

#### Initializer Parameters Without Argument Labels

If you **do not want to use an argument label** for an initializer parameter, **write an underscore (`_`)** instead of an explicit argument label for that parameter to override the default behavior.

```swift
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius is 37.0
```

#### Optional Property Types

Optional type: `TypeName?`

```swift
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// Prints "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."
```

The response to a survey question cannot be known until it is asked, and so the `response` property is declared with a type of `String?`, or “optional `String`”. It is **automatically assigned a default value of `nil`**, meaning “no string yet”, **when a new instance of `SurveyQuestion` is initialized**.

#### Assigning Constant Properties During Initialization

You can **assign a value to a constant property** at any point **during initialization**, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.

Note: For **class** instances, a **constant property** can be modified during initialization only **by the class** that introduces it. It **cannot be modified by a subclass**.

```swift
class SurveyQuestion {
    let text: String  // now it's a constant
    var response: String?
    init(text: String) {
        self.text = text  // it can be initialized in the initializer
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```

---

### Default Initializers

Swift provides a *default initializer* for any **structure** or **class** that **provides default values** for all of its properties and **does not provide at least one initializer itself**. The default initializer simply creates a new instance with all of its properties set to their default values.

```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()  // the default initializer
```

Because **all properties of the `ShoppingListItem` class have default values**, and because it is a **base class with no superclass**, `ShoppingListItem` automatically gains a **default initializer** implementation that **creates a new instance with all of its properties set to their default values**. (The `name` property is an optional `String` property, and so it automatically receives a default value of `nil`, even though this value is not written in the code.) The example above uses the default initializer for the `ShoppingListItem` class to create a new instance of the class with initializer syntax, written as `ShoppingListItem()`, and assigns this new instance to a variable called `item`.

#### Memberwise Initializers for Structure Types

Structure types automatically receive a ***memberwise initializer* if they don’t define any of their own custom initializers**. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

```swift
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)

let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// Prints "0.0 2.0"

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// Prints "0.0 0.0"
```

You can omit either property or both properties, and the initializer uses the default value for anything you omit.

---

### <span style="color:#c0c0c0">Initializer Delegation for Value Types</span>

---

### <span style="color:#c0c0c0">Class Inheritance and Initialization</span>

---

### <span style="color:#c0c0c0">Failable Initializers</span>

---

### <span style="color:#c0c0c0">Required Initializers</span>

---

### <span style="color:#c0c0c0">Setting a Default Property Value with a Closure or Function</span>

---

# Swift API Guidelines

Read this [Swift API Guidelines](https://swift.org/documentation/api-design-guidelines/) document in its entirety. 

## Fundamentals

- **Clarity at the point of use** is your most important goal. Entities such as methods and properties are declared only once but *used* repeatedly. Design APIs to make those uses clear and concise. When evaluating a design, reading a declaration is seldom sufficient; always examine a use case to make sure it looks clear in context.

- **Clarity is more important than brevity.** Although Swift code can be compact, it is a *non-goal* to enable the smallest possible code with the fewest characters. Brevity in Swift code, where it occurs, is a side-effect of the strong type system and features that naturally reduce boilerplate.

- **Write a documentation comment** for every declaration. Insights gained by writing documentation can have a profound impact on your design, so don’t put it off.

  - **Use Swift’s [dialect of Markdown](https://developer.apple.com/library/prerelease/mac/documentation/Xcode/Reference/xcode_markup_formatting_ref/).**

  - **Begin with a summary** that describes the entity being declared. Often, an API can be completely understood from its declaration and its summary.

    ```swift
    /// Returns a "view" of `self` containing the same elements in
    /// reverse order.
    func reversed() -> ReverseCollection
    ```

    - **Focus on the summary**; it’s the most important part. Many excellent documentation comments consist of nothing more than a great summary.

    - **Use a single sentence fragment** if possible, ending with a period. Do not use a complete sentence.

    - **Describe what a function or method *does* and what it *returns***, omitting null effects and `Void` returns:

      ```swift
      /// Inserts `newHead` at the beginning of `self`.
      mutating func prepend(_ newHead: Int)
      
      /// Returns a `List` containing `head` followed by the elements
      /// of `self`.
      func prepending(_ head: Element) -> List
      
      /// Removes and returns the first element of `self` if non-empty;
      /// returns `nil` otherwise.
      mutating func popFirst() -> Element?
      ```

      Note: in rare cases like `popFirst` above, the summary is formed of multiple sentence fragments **separated by semicolons**.

    - **Describe what a subscript *accesses***:

      ```swift
      /// Accesses the `index`th element.
      subscript(index: Int) -> Element { get set }
      ```

    - **Describe what an initializer *creates***:

      ```swift
      /// Creates an instance containing `n` repetitions of `x`.
      init(count n: Int, repeatedElement x: Element)
      ```

    - For all other declarations, **describe what the declared entity *is***.

      ```swift
      /// A collection that supports equally efficient insertion/removal
      /// at any position.
      struct List {
      
        /// The element at the beginning of `self`, or `nil` if self is
        /// empty.
        var first: Element?
        ...
      ```

  - **Optionally, continue** with one or more paragraphs and bullet items. Paragraphs are separated by blank lines and use complete sentences.

    ```swift
    /// Writes the textual representation of each    ← Summary
    /// element of `items` to the standard output.
    ///                                              ← Blank line
    /// The textual representation for each item `x` ← Additional discussion
    /// is generated by the expression `String(x)`.
    ///
    /// - Parameter separator: text to be printed    ⎫
    ///   between items.                             ⎟
    /// - Parameter terminator: text to be printed   ⎬ Parameters section
    ///   at the end.                                ⎟
    ///                                              ⎭
    /// - Note: To print without a trailing          ⎫
    ///   newline, pass `terminator: ""`             ⎟
    ///                                              ⎬ Symbol commands
    /// - SeeAlso: `CustomDebugStringConvertible`,   ⎟
    ///   `CustomStringConvertible`, `debugPrint`.   ⎭
    public func print(
      _ items: Any..., separator: String = " ", terminator: String = "\n")
    ```

    * **Use recognized [symbol documentation markup](https://developer.apple.com/library/prerelease/mac/documentation/Xcode/Reference/xcode_markup_formatting_ref/SymbolDocumentation.html#//apple_ref/doc/uid/TP40016497-CH51-SW1) elements** to add information beyond the summary, whenever appropriate.
    * **Know and use recognized bullet items with [symbol command syntax](https://developer.apple.com/library/prerelease/mac/documentation/Xcode/Reference/xcode_markup_formatting_ref/SymbolDocumentation.html#//apple_ref/doc/uid/TP40016497-CH51-SW13).** Popular development tools such as Xcode give special treatment to bullet items that start with the following keywords:
      Attention, Author, Authors, Bug, Complexity, Copyright, Date, Experiment, Important, Invariant, Note, Parameter, Parameters, Postcondition, Precondition, Remark, Requires, Returns, SeeAlso, Since, Throws, ToDo, Version, Warning

## Naming

### Promote Clear Usage

- **Include all the words needed to avoid ambiguity** for a person reading code where the name is used.

  ```swift
  // ✅
  extension List {
    public mutating func remove(at position: Index) -> Element
  }
  employees.remove(at: x) // good!
  ```

  ```swift
  // ⛔️
  employees.remove(x) // unclear: are we removing x?
  ```

- **Omit needless words.** Every word in a name should convey salient information at the use site.

  ```swift
  // ⛔️
  public mutating func removeElement(_ member: Element) -> Element?
  
  allViews.removeElement(cancelButton)
  ```

  ```swift
  // ✅
  public mutating func remove(_ member: Element) -> Element?
  
  allViews.remove(cancelButton) // clearer
  ```

  Occasionally, repeating type information is necessary to avoid ambiguity, but in general it is **better to use a word that describes a parameter’s *role*** rather than its type. See the next item for details.

- **Name variables, parameters, and associated types according to their roles,** rather than their type constraints.

  ```swift
  // ⛔️
  var string = "Hello"
  protocol ViewController {
    associatedtype ViewType : View
  }
  class ProductionLine {
    func restock(from widgetFactory: WidgetFactory)
  }
  ```

  ```swift
  // ✅
  var greeting = "Hello"
  protocol ViewController {
    associatedtype ContentView : View
  }
  class ProductionLine {
    func restock(from supplier: WidgetFactory)
  }
  ```

  If an associated type is so tightly bound to its protocol constraint that **the protocol name *is* the role**, avoid collision by appending `Protocol` to the protocol name:

  ```swift
  protocol Sequence {
    associatedtype Iterator : IteratorProtocol
  }
  protocol IteratorProtocol { ... }
  ```

* **Compensate for weak type information** to clarify a parameter’s role.

  Especially when a parameter type is `NSObject`, `Any`, `AnyObject`, or a fundamental type such `Int` or `String`, **type information and context at the point of use may not fully convey intent**. In this example, the declaration may be clear, but the use site is vague.

  ```swift
  // ⛔️
  func add(_ observer: NSObject, for keyPath: String)
  grid.add(self, for: graphics) // vague
  ```

  To restore clarity, **precede each weakly typed parameter with a noun describing its role**:

  ```swift
  // ✅
  func addObserver(_ observer: NSObject, forKeyPath path: String)
  grid.addObserver(self, forKeyPath: graphics) // clear
  ```

### Strive for Fluent Usage

- **Prefer method and function names that make use sites form grammatical English phrases.**

  ```swift
  // ✅
  x.insert(y, at: z)          // “x, insert y at z”
  x.subViews(havingColor: y)  // “x's subviews having color y”
  x.capitalizingNouns()       // “x, capitalizing nouns”
  
  // ⛔️
  x.insert(y, position: z)
  x.subViews(color: y)
  x.nounCapitalize()
  ```

  It is acceptable for fluency to degrade after the first argument or two when those arguments are not central to the call’s meaning:

  ```swift
  AudioUnit.instantiate(
    with: description, 
    options: [.inProcess], completionHandler: stopProgressBar)  // less important
  ```

- **Begin names of factory methods with “`make`”,** e.g. `x.makeIterator()`.

- The first argument to **initializer and [factory methods](https://en.wikipedia.org/wiki/Factory_method_pattern) calls** should not form a phrase starting with the base name, e.g. `x.makeWidget(cogCount: 47)`

  For example, the first arguments to these calls do not read as part of the same phrase as the base name:

  ```swift
  // ✅
  let foreground = Color(red: 32, green: 64, blue: 128)
  let newPart = factory.makeWidget(gears: 42, spindles: 14)
  let ref = Link(target: destination)
  ```

  In the following, the API author has tried to create grammatical continuity with the first argument.

  ```swift
  // ⛔️
  let foreground = Color(havingRGBValuesRed: 32, green: 64, andBlue: 128)
  let newPart = factory.makeWidget(havingGearCount: 42, andSpindleCount: 14)
  let ref = Link(to: destination)
  ```

  In practice, this guideline along with those for [argument labels](https://swift.org/documentation/api-design-guidelines/#argument-labels) means the first argument will have a label **unless** the call is performing a [value preserving **type conversion**](https://swift.org/documentation/api-design-guidelines/#type-conversion).

  ```swift
  let rgbForeground = RGBColor(cmykForeground)
  ```

* **Name functions and methods according to their side-effects**

  - Those without side-effects should read as noun phrases, e.g. `x.distance(to: y)`, `i.successor()`.

  - Those with side-effects should read as **imperative verb phrases**, e.g., `print(x)`, `x.sort()`, `x.append(y)`.

  - **Name Mutating/nonmutating method pairs** consistently. A mutating method will often have a nonmutating variant with similar semantics, but that returns a new value rather than updating an instance in-place.

    - When the operation is **naturally described by a verb**, use the verb’s **imperative** for the **mutating method** and **apply the “ed” or “ing” suffix** to name its **nonmutating** counterpart.

      |   Mutating    |     Nonmutating      |
      | :-----------: | :------------------: |
      |  `x.sort()`   |   `z = x.sorted()`   |
      | `x.append(y)` | `z = x.appending(y)` |

      - Prefer to name the nonmutating variant using the verb’s past [participle](https://en.wikipedia.org/wiki/Participle) (usually appending “ed”):

        ```swift
        /// Reverses `self` in-place.
        mutating func reverse()
        
        /// Returns a reversed copy of `self`.
        func reversed() -> Self
        ...
        x.reverse()
        let y = x.reversed()
        ```

      - When adding “ed” is not grammatical because the verb has a direct object, name the nonmutating variant using the verb’s present [participle](https://en.wikipedia.org/wiki/Participle), by appending “ing.”

        ```swift
        /// Strips all the newlines from `self`
        mutating func stripNewlines()
        
        /// Returns a copy of `self` with all the newlines stripped.
        func strippingNewlines() -> String
        ...
        s.stripNewlines()
        let oneLine = t.strippingNewlines()
        ```

    - When the operation is **naturally described by a noun**, use the **noun** for the **nonmutating** method and apply the **“form” prefix** to name its **mutating** counterpart.

      |     Nonmutating      |       Mutating        |
      | :------------------: | :-------------------: |
      |   `x = y.union(z)`   |   `y.formUnion(z)`    |
      | `j = c.successor(i)` | `c.formSuccessor(&i)` |

* **Uses of Boolean methods and properties should read as assertions about the receiver** when the use is nonmutating, e.g. `x.isEmpty`, `line1.intersects(line2)`.

* **Protocols that describe *what something is* should read as nouns** (e.g. `Collection`).

* **Protocols that describe a *capability* should be named using the suffixes `able`, `ible`, or `ing`** (e.g. `Equatable`, `ProgressReporting`).

* The names of other **types, properties, variables, and constants should read as nouns.**

### Use Terminology Well

**Term of Art**: noun - a word or phrase that has a precise, specialized meaning within a particular field or profession.

- **Avoid obscure terms** if a more common word conveys meaning just as well. Don’t say “epidermis” if “skin” will serve your purpose. Terms of art are an essential communication tool, but should only be used to capture crucial meaning that would otherwise be lost.

- **Stick to the established meaning** if you do use a term of art.

  - **Don’t surprise an expert**: anyone already familiar with the term will be surprised and probably angered if we appear to have invented a new meaning for it.
  - **Don’t confuse a beginner**: anyone trying to learn the term is likely to do a web search and find its traditional meaning.

- **Avoid abbreviations.** Abbreviations, especially non-standard ones, are effectively terms-of-art, because understanding depends on correctly translating them into their non-abbreviated forms.

  > The intended meaning for any abbreviation you use should be easily found by a web search.

- **Embrace precedent.** Don’t optimize terms for the total beginner at the expense of conformance to existing culture.

  E.g. `Array` > `List`, `sin(x)` > `verticalPositionOnUnitCircleAtOriginOfEndOfRadiusWithAngle(x)`

## Conventions

### General Conventions

- **Document the complexity of any computed property that is not O(1).** People often assume that property access involves no significant computation, because they have stored properties as a mental model. Be sure to alert them when that assumption may be violated.

- **Prefer methods and properties to free functions.** Free functions are used only in special cases:

  1. When there’s no obvious `self`:

     ```swift
     min(x, y, z)
     ```

  2. When the function is an unconstrained generic:

     ```swift
     print(x)
     ```

  3. When function syntax is part of the established domain notation:

     ```swift
     sin(x)
     ```

- **Follow case conventions.** Names of types and protocols are `UpperCamelCase`. Everything else is `lowerCamelCase`.

  [Acronyms and initialisms](https://en.wikipedia.org/wiki/Acronym) that commonly appear as all upper case in American English should be uniformly up- or down-cased according to case conventions:

  ```swift
  var utf8Bytes: [UTF8.CodeUnit]
  var isRepresentableAsASCII = true
  var userSMTPServer: SecureSMTPServer
  ```

  Other acronyms should be treated as ordinary words:

  ```swift
  var radarDetector: RadarScanner
  var enjoysScubaDiving = true
  ```

- **Methods can share a base name** when they share the same basic meaning or when they operate in distinct domains.

  For example, the following is encouraged, since the methods do essentially the same things:

  ```swift
  // ✅
  extension Shape {
    /// Returns `true` iff `other` is within the area of `self`.
    func contains(_ other: Point) -> Bool { ... }
  
    /// Returns `true` iff `other` is entirely within the area of `self`.
    func contains(_ other: Shape) -> Bool { ... }
  
    /// Returns `true` iff `other` is within the area of `self`.
    func contains(_ other: LineSegment) -> Bool { ... }
  }
  
  ```

  And since geometric types and collections are separate domains, this is also fine in the same program:

  ```swift
  // ✅
  extension Collection where Element : Equatable {
    /// Returns `true` iff `self` contains an element equal to
    /// `sought`.
    func contains(_ sought: Element) -> Bool { ... }
  }
  ```

  However, these `index` methods have different semantics, and should have been named differently:

  ```swift
  // ⛔️
  extension Database {
    /// Rebuilds the database's search index
    func index() { ... }
  
    /// Returns the `n`th row in the given table.
    func index(_ n: Int, inTable: TableID) -> TableRow { ... }
  }
  ```

  Lastly, avoid “**overloading on return type**” because it causes ambiguities in the presence of type inference.

  ```swift
  extension Box {
    /// Returns the `Int` stored in `self`, if any, and
    /// `nil` otherwise.
    func value() -> Int? { ... }
  
    /// Returns the `String` stored in `self`, if any, and
    /// `nil` otherwise.
    func value() -> String? { ... }
  }
  ```

### Parameters

```swift
func move(from start: Point, to end: Point)
```

* **Choose parameter names to serve documentation**. Even though parameter names do not appear at a function or method’s point of use, they play an important explanatory role.

  Choose these names to make documentation easy to read. For example, these names make documentation read naturally:

  ```swift
  // ✅
  /// Return an `Array` containing the elements of `self`
  /// that satisfy `predicate`.
  func filter(_ predicate: (Element) -> Bool) -> [Generator.Element]
  
  /// Replace the given `subRange` of elements with `newElements`.
  mutating func replaceRange(_ subRange: Range, with newElements: [E])
  ```

  These, however, make the documentation awkward and ungrammatical:

  ```swift
  // ⛔️
  /// Return an `Array` containing the elements of `self`
  /// that satisfy `includedInResult`.
  func filter(_ includedInResult: (Element) -> Bool) -> [Generator.Element]
  
  /// Replace the range of elements indicated by `r` with
  /// the contents of `with`.
  mutating func replaceRange(_ r: Range, with: [E])
  ```

* **Take advantage of defaulted parameters** when it simplifies common uses. Any parameter with a single commonly-used value is a candidate for a default.

  ```swift
  let order = lastName.compare(royalFamilyName)
  
  extension String {
    /// ...description...
    public func compare(
       _ other: String, options: CompareOptions = [],
       range: Range? = nil, locale: Locale? = nil
    ) -> Ordering
  }
  ```

* **Prefer to locate parameters with defaults toward the end** of the parameter list. Parameters without defaults are usually more essential to the semantics of a method, and provide a stable initial pattern of use where methods are invoked.

### Argument Labels

```swift
func move(from start: Point, to end: Point)
x.move(from: x, to: y)
```

- **Omit all labels when arguments can’t be usefully distinguished**, e.g. `min(number1, number2)`, `zip(sequence1, sequence2)`.

- **In initializers that perform value preserving type conversions, omit the first argument label**, e.g. `Int64(someUInt32)`

  The first argument should always be **the source of the conversion**.

  ```swift
  extension String {
    // Convert `x` into its textual representation in the given radix
    init(_ x: BigInt, radix: Int = 10)   // ← Note the initial underscore
  }
  
  text = "The value is: "
  text += String(veryLargeNumber)
  text += " and in hexadecimal, it's"
  text += String(veryLargeNumber, radix: 16)
  ```

  In “narrowing” type conversions, though, a label that describes the narrowing is recommended.

  ```swift
  extension UInt32 {
    /// Creates an instance having the specified `value`.
    init(_ value: Int16)            // ← Widening, so no label
    /// Creates an instance having the lowest 32 bits of `source`.
    init(truncating source: UInt64)
    /// Creates an instance having the nearest representable
    /// approximation of `valueToApproximate`.
    init(saturating valueToApproximate: UInt64)
  }
  ```

- **When the first argument forms part of a [prepositional phrase](https://en.wikipedia.org/wiki/Adpositional_phrase#Prepositional_phrases), give it an argument label**. The argument label should normally begin at the [preposition](https://en.wikipedia.org/wiki/Preposition), e.g. `x.removeBoxes(havingLength: 12)`.

  An **exception** arises when **the first two arguments represent parts of a single abstraction**.

  ```swift
  // ⛔️
  a.move(toX: b, y: c)
  a.fade(fromRed: b, green: c, blue: d)
  ```

  In such cases, begin the argument label *after* the preposition, to keep the abstraction clear.

  ```
  // ✅
  a.moveTo(x: b, y: c)
  a.fadeFrom(red: b, green: c, blue: d)
  ```

- **Otherwise, if the first argument forms part of a grammatical phrase, omit its label**, appending any preceding words to the base name, e.g. `x.addSubview(y)`

  This guideline implies that **if the first argument *doesn’t* form part of a grammatical phrase**, it should **have a label**.

  ```
  // ✅
  view.dismiss(animated: false)
  let text = words.split(maxSplits: 12)
  let studentsByName = students.sorted(isOrderedBefore: Student.namePrecedes)
  ```

  Note that it’s important that the phrase convey the correct meaning. The following would be grammatical but would express the wrong thing.

  ```swift
  view.dismiss(false)   Don't dismiss? Dismiss a Bool?
  words.split(12)       Split the number 12?
  ```

* **Label all other arguments**.

## Special Instructions

- **Label tuple members and name closure parameters** where they appear in your API.

  ```swift
  /// Ensure that we hold uniquely-referenced storage for at least
  /// `requestedCapacity` elements.
  ///
  /// If more storage is needed, `allocate` is called with
  /// `byteCount` equal to the number of maximally-aligned
  /// bytes to allocate.
  ///
  /// - Returns:
  ///   - reallocated: `true` iff a new block of memory
  ///     was allocated.
  ///   - capacityChanged: `true` iff `capacity` was updated.
  mutating func ensureUniqueStorage(
    minimumCapacity requestedCapacity: Int, 
    allocate: (_ byteCount: Int) -> UnsafePointer<Void>
  ) -> (reallocated: Bool, capacityChanged: Bool)
  ```

  Names used for closure parameters should be chosen like [parameter names](https://swift.org/documentation/api-design-guidelines/#parameter-names) for top-level functions. Labels for closure arguments that appear at the call site are not supported.

- **Take extra care with unconstrained polymorphism** (e.g. `Any`, `AnyObject`, and unconstrained generic parameters) to avoid ambiguities in overload sets.

  For example, consider this overload set:

  ```swift
  // ⛔️
  struct Array {
    /// Inserts `newElement` at `self.endIndex`.
    public mutating func append(_ newElement: Element)
  
    /// Inserts the contents of `newElements`, in order, at
    /// `self.endIndex`.
    public mutating func append(_ newElements: S)
      where S.Generator.Element == Element
  }
  
  var values: [Any] = [1, "a"]
  values.append([2, 3, 4]) // [1, "a", [2, 3, 4]] or [1, "a", 2, 3, 4]?
  ```

  To eliminate the ambiguity, name the second overload more explicitly.

  ```swift
  // ✅
  struct Array {
    /// Inserts `newElement` at `self.endIndex`.
    public mutating func append(_ newElement: Element)
  
    /// Inserts the contents of `newElements`, in order, at
    /// `self.endIndex`.
    public mutating func append(contentsOf newElements: S)
      where S.Generator.Element == Element
  }
  ```

  Notice how the new name better matches the documentation comment. In this case, the act of writing the documentation comment actually brought the issue to the API author’s attention.
