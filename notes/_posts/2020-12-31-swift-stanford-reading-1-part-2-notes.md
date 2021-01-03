---
layout: post
title: Stanford CS193p - Reading 1 - part 2
categories: notes Swift CS193p
date: 2020-12-31
---

Full Reading 1 document can be found [here](https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/r1.pdf)

# Swift Programming Language (cont.)

## [Strings and Characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html)

* Swift’s `String` and `Character` types provide a fast, **Unicode-compliant** way to work with text in your code.
* Every string is composed of encoding-independent Unicode characters, and provides support for accessing those characters in various Unicode representations.

### String Literals

```swift
let someString = "Some string literal value"
```

#### Multiline String Literals

```swift
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""
```

When your source code includes a line break inside of a multiline string literal, **that line break also appears in the string’s value**. If you want to use line breaks to make your source code easier to read, but **you don’t want the line breaks** to be part of the string’s value, **write a backslash (`\`)** at the end of those lines:

```swift
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
```

A multiline string can be indented to match the surrounding code. The **whitespace before the closing quotation marks** (`"""`) tells Swift **what whitespace to ignore before all of the other lines**. However, if you write whitespace at the beginning of a line in addition to what’s before the closing quotation marks, that whitespace *is* included.

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-1.png" style="width: 80%; max-width: 500px" /></div>

The above example gives us the result: `linesWithIndentation: String = "This line doesn\'t begin with whitespace.\n    This line begins with four spaces.\nThis line doesn\'t begin with whitespace."`

If the closing quotation marks have more than 4 spaces, it'll cause the error `error: repl.swift:97:5: error: insufficient indentation of line in multi-line string literal`.

#### Special Characters in String Literals

- The escaped special characters `\0` (null character), `\\` (backslash), `\t` (horizontal tab), `\n` (line feed), `\r` (carriage return), `\"` (double quotation mark) and `\'` (single quotation mark)
- An arbitrary Unicode scalar value, written as `\u{`*n*`}`, where *n* is a **1–8 digit hexadecimal number** (Unicode is discussed in [Unicode](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html#ID293) below)

```swift
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
```

Because multiline string literals use three double quotation marks instead of just one, **you can include a double quotation mark** (`"`) inside of a multiline string literal **without escaping it**. To include the text `"""` in a multiline string, **escape at least one** of the quotation marks. For example:

```swift
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
```

#### Extended String Delimiters

You can place a string literal within *extended delimiters* to **include special characters in a string without invoking their effect**. You place your string within quotation marks (`"`) and surround that with number signs (`#`). For example, printing the string literal `#"Line 1\nLine 2"#` prints the line feed escape sequence (`\n`) rather than printing the string across two lines.

If you need the **special effects** of a character in a string literal, match **the number of number signs** within the string following the escape character (`\`).

```swift
// The string can be surrounded by more than one number signs
#"Line 1\nLine 2"#        // String = "Line 1\\nLine 2"
##"Line 1\nLine 2"##      // String = "Line 1\\nLine 2"
###"Line 1\nLine 2"###    // String = "Line 1\\nLine 2"
####"Line 1\nLine 2"####  // String = "Line 1\\nLine 2"

// Errors:
#"Line 1\nLine 2"    // error: unterminated string literal
"Line 1\nLine 2"#    // error: expected expression
##"Line 1\nLine 2"#  // error: unterminated string literal
"Line 1\nLine 2"##   // error: too many '#' characters in closing delimiter

// Need the special effects
#"Line 1\#nLine 2"#              // String = "Line 1\nLine 2"
##"Line 1\##nLine 2"##           // String = "Line 1\nLine 2"
#####"Line 1\#####nLine 2"#####  // String = "Line 1\nLine 2"

// Errors:
#"Line 1\##nLine 2"#  // error: too many '#' characters in delimited escape
                      // another error: invalid escape sequence in literal


// Compiles but might not be what you want
##"Line 1\#nLine 2"##           // String = "Line 1\\#nLine 2"
#####"Line 1\####nLine 2"#####  // String = "Line 1\\####nLine 2"
```

String literals created using extended delimiters can also be multiline string literals. You can use extended delimiters to **include the text `"""` in a multiline string**, overriding the default behavior that ends the literal. For example:

```swift
// String = "Here are three more double quotes: \"\"\""
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
```

---

### Initializing an Empty String

```swift
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other

// Check if a string is empty
if emptyString.isEmpty {
    print("Nothing to see here")
}
// Prints "Nothing to see here"
```

---

### String Mutability

```swift
var variableString = "Horse"
variableString += " and carriage"
// variableString is now "Horse and carriage"

let constantString = "Highlander"
constantString += " and another Highlander"
// this reports a compile-time error - a constant string cannot be modified
```

---

### Strings Are Value Types

If you create a new `String` value, that `String` **value is *copied*** when it’s passed to a function or method, or when it’s assigned to a constant or variable.

Behind the scenes, Swift’s compiler optimizes string usage so that **actual copying takes place only when absolutely necessary**.

---

### Working with Characters

Access the individual `Character` values for a `String` by iterating over the string:

```swift
for character in "Dog!🐶" {
    print(character)
}
// D
// o
// g
// !
// 🐶
```

`Character` type:

```swift
let exclamationMark: Character = "!"
```

Initialize `String` with array of `Character`:

```swift
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// Prints "Cat!🐱"
```

---

### Concatenating Strings and Characters

```swift
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome now equals "hello there"

var instruction = "look over"
instruction += string2
// instruction now equals "look over there"

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome now equals "hello there!"

let badStart = """
one
two
"""
let end = """
three
"""
print(badStart + end)
// Prints two lines:
// one
// twothree

let goodStart = """
one
two

"""
print(goodStart + end)
// Prints three lines:
// one
// two
// three
```

---

### <span style="background-color:#fffabc">String Interpolation</span>

*String interpolation* is a way to construct a new `String` value **from a mix of constants, variables, literals, and expressions** by **including their values inside a string literal**. You can use string interpolation in both single-line and multiline string literals. Each item that you insert into the string literal is **wrapped in a pair of parentheses, prefixed by a backslash (`\`)**:

```swift
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"

print(#"Write an interpolated string in Swift using \(multiplier)."#)
// Prints "Write an interpolated string in Swift using \(multiplier)."

print(#"6 times 7 is \#(6 * 7)."#)
// Prints "6 times 7 is 42."
```

---

### Unicode

*Unicode* is an **international standard for encoding, representing, and processing text** in different writing systems. It enables you to represent almost any character from any language in a standardized form, and to read and write those characters to and from an external source such as a text file or web page. Swift’s `String` and `Character` types are fully Unicode-compliant, as described in this section.

#### Unicode Scalar Values

Behind the scenes, Swift’s native `String` type is built from ***Unicode scalar values***. A Unicode scalar value is a unique **21-bit** number for a character or modifier, such as `U+0061` for `LATIN SMALL LETTER A` (`"a"`), or `U+1F425` for `FRONT-FACING BABY CHICK` (`"🐥"`).

Note that not all 21-bit Unicode scalar values are assigned to a character—some scalars are reserved for future assignment or for use in UTF-16 encoding. Scalar values that **have been assigned to a character** typically also **have a name**, such as `LATIN SMALL LETTER A` and `FRONT-FACING BABY CHICK` in the examples above.

#### Extended Grapheme Clusters

Every instance of Swift’s `Character` type represents a single *extended grapheme cluster*. An **extended grapheme cluster** is **a sequence of one or more Unicode scalars** that (when combined) produce a **single** human-readable **character**.

Example:
é: single Unicode scalar `é` (`LATIN SMALL LETTER E WITH ACUTE`, or `U+00E9`) = a standard letter `e` (`LATIN SMALL LETTER E`, or `U+0065`) + `COMBINING ACUTE ACCENT` scalar (`U+0301`)

```swift
let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
// eAcute is é, combinedEAcute is é
```

Extended grapheme clusters are **a flexible way to represent many complex script characters as a single `Character` value**. For example, Hangul syllables from the Korean alphabet can be represented as either a precomposed or decomposed sequence. Both of these representations qualify as a single `Character` value in Swift:

```swift
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
// precomposed is 한, decomposed is 한
```

Extended grapheme clusters enable scalars for **enclosing marks** (such as `COMBINING ENCLOSING CIRCLE`, or `U+20DD`) to enclose other Unicode scalars as part of a single `Character` value, e.g.<br>
é⃝

```swift
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
```

Unicode scalars for **regional indicator symbols** can be combined in pairs to make a single `Character` value, such as this combination of `REGIONAL INDICATOR SYMBOL LETTER U` (`U+1F1FA`) and `REGIONAL INDICATOR SYMBOL LETTER S` (`U+1F1F8`):

```swift
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS is 🇺🇸

let regionalIndicatorForTW: Character = "\u{1F1F9}\u{1F1FC}"
// regionalIndicatorForTW is 🇹🇼
```

---

### <span style="background-color:#fffabc">Counting Characters</span>

```swift
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// Prints "unusualMenagerie has 40 characters"
```

Note that Swift’s use of extended grapheme clusters for `Character` values means that **string concatenation and modification** may **not** always **affect a string’s character count**.

```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in café is 4"
```

Note: the `count` property **must iterate over the Unicode scalars** in the entire string in order to determine the characters for that string.

---

### <span style="background-color:#ffd9d9">Accessing and Modifying a String</span>

You access and modify a string through its methods and properties, or by using subscript syntax.

#### String Indices

Each `String` value has an associated ***index type*, `String.Index`**, which corresponds to **the position of each `Character` in the string**.

As mentioned above, **different characters can require different amounts of memory to store**, so in order to determine which `Character` is at a particular position, you must iterate over each Unicode scalar from the start or end of that `String`. For this reason, **Swift strings can’t be indexed by integer values**.

Use the `startIndex` property to access the position of the first `Character` of a `String`. The `endIndex` property is the position **after** the last character in a `String`. As a result, the `endIndex` property isn’t a valid argument to a string’s subscript. If a `String` is empty, `startIndex` and `endIndex` are equal.

You access the indices before and after a given index using the `index(before:)` and `index(after:)` methods of `String`. To **access an index farther away from the given index**, you can use the `index(_:offsetBy:)` method instead of calling one of these methods multiple times.

```swift
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7) 
greeting[index]
// a
```

Attempting to access an index outside of a string’s range or a `Character` at an index outside of a string’s range will trigger a runtime error.

```swift
greeting[greeting.endIndex] // Error
greeting.index(after: greeting.endIndex) // Error
```

Use the `indices` property to access all of the indices of individual characters in a string.

```swift
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "
```

Note: You can use the `startIndex` and `endIndex` properties and the `index(before:)`, `index(after:)`, and `index(_:offsetBy:)` methods **on any type that conforms to the `Collection` protocol**. This includes `String`, as shown here, as well as collection types such as `Array`, `Dictionary`, and `Set`.

#### Inserting and Removing

To **insert a single character** into a string at a specified index, use the `insert(_:at:)` method, and to **insert the contents of another string** at a specified index, use the `insert(contentsOf:at:)` method.

```swift
var welcome = "hello"
    welcome.insert("!", at: welcome.endIndex)
    // welcome now equals "hello!"

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"
```

To **remove a single character** from a string at a specified index, use the `remove(at:)` method, and to **remove a substring at a specified range**, use the `removeSubrange(_:)` method:

```swift
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome now equals "hello"
```

Note: You can use the `insert(_:at:)`, `insert(contentsOf:at:)`, `remove(at:)`, and `removeSubrange(_:)` methods on **any type that conforms to the `RangeReplaceableCollection` protocol**. This includes `String`, as shown here, as well as collection types such as `Array`, `Dictionary`, and `Set`.

---

### <span style="background-color:#fffabc">Substrings</span>

When you get a substring from a string—for example, **using a subscript** or **a method like `prefix(_:)`**—the result is an instance of [`Substring`](https://developer.apple.com/documentation/swift/substring), not another string. Substrings in Swift have most of the same methods as strings, which means you can **work with substrings the same way you work with strings**. However, unlike strings, you **use substrings for only a short amount of time** while performing actions on a string. When you’re ready to **store the result for a longer time, you convert the substring to an instance of `String`**. For example:

```swift
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)
```

Like strings, each substring has **a region of memory where the characters that make up the substring** are stored. The **difference** between strings and substrings is that, as a performance optimization, **a substring can reuse part of the memory** that’s used to store the original string, or part of the memory that’s used to store another substring. (Strings have a similar optimization, but if two strings share memory, they are equal.) This performance optimization means you **don’t** have to pay the performance cost of **copying memory until you modify either the string or substring**. As mentioned above, substrings **aren’t** suitable for **long-term storage**—because they reuse the storage of the original string, **the entire original string must be kept in memory as long as any of its substrings are being used**.

In the example above, `greeting` is a string, which means it has a region of memory where the characters that make up the string are stored. Because `beginning` is a substring of `greeting`, it reuses the memory that `greeting` uses. In contrast, `newString` is a string—when it’s created from the substring, it has its own storage. The figure below shows these relationships:

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-2.png" style="width: 80%; max-width: 400px" /></div>

Note: Both `String` and `Substring` **conform to the [`StringProtocol`](https://developer.apple.com/documentation/swift/stringprotocol) protocol**, which means it’s often convenient for string-manipulation functions to accept a `StringProtocol` value. You can call such functions with either a `String` or `Substring` value.

---

### Comparing Strings

Swift provides three ways to compare textual values: **string and character equality**, **prefix equality**, and **suffix equality**.

#### String and Character Equality

String and character equality is checked with:

* The “equal to” operator (`==`): considered equal if their extended grapheme clusters are *canonically equivalent*.

  ```swift
  let quotation = "We're a lot alike, you and I."
  let sameQuotation = "We're a lot alike, you and I."
  if quotation == sameQuotation {
      print("These two strings are considered equal")
  }
  // Prints "These two strings are considered equal"
  ```

  Extended grapheme clusters are **canonically equivalent** if they have **the same linguistic meaning and appearance**, even if they’re composed from different Unicode scalars behind the scenes. E.g.

  * é: `LATIN SMALL LETTER E WITH ACUTE` (`U+00E9`) ==  `LATIN SMALL LETTER E` (`U+0065`) followed by `COMBINING ACUTE ACCENT` (`U+0301`)

    ```swift
    // "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
    let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
    
    // "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
    let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
    
    if eAcuteQuestion == combinedEAcuteQuestion {
        print("These two strings are considered equal")
    }
    // Prints "These two strings are considered equal"
    ```

  * A and A: `LATIN CAPITAL LETTER A` (`U+0041`, or `"A"`) != `CYRILLIC CAPITAL LETTER A` (`U+0410`, or `"А"`) (used in Russian). They are visually similar, but don’t have the same linguistic meaning

    ```swift
    let latinCapitalLetterA: Character = "\u{41}"
    
    let cyrillicCapitalLetterA: Character = "\u{0410}"
    
    if latinCapitalLetterA != cyrillicCapitalLetterA {
        print("These two characters are not equivalent.")
    }
    // Prints "These two characters are not equivalent."
    ```

* The “not equal to” operator (`!=`)

#### Prefix and Suffix Equality

Use `hasPrefix(_:)` and `hasSuffix(_:)`.

```swift
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// Prints "6 mansion scenes; 2 cell scenes"
```

---

### <span style="color:#c0c0c0">Unicode Representations of Strings</span>

* Unicode-defined *encoding forms*:
  * UTF-8 encoding form (which encodes a string as 8-bit code units)
  * UTF-16 encoding form (which encodes a string as 16-bit code units)
  * UTF-32 encoding form (which encodes a string as 32-bit code units)
* You can access a `String` value in one of three other **Unicode-compliant representations**:
  * A collection of UTF-8 code units (accessed with the string’s `utf8` property)
  * A collection of UTF-16 code units (accessed with the string’s `utf16` property)
  * A collection of 21-bit Unicode scalar values, equivalent to the string’s UTF-32 encoding form (accessed with the string’s `unicodeScalars` property) 

For example: `dogString` is made up of the characters `D`, `o`, `g`, `‼` (`DOUBLE EXCLAMATION MARK`, or Unicode scalar `U+203C`), and the 🐶 character (`DOG FACE`, or Unicode scalar `U+1F436`)

```swift
let dogString = "Dog‼🐶"
```

#### UTF-8 Representation

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-3.png" style="width: 80%; max-width: 500px" /></div>

You can access a **UTF-8** representation of a `String` by iterating over its `utf8` property. **This property is of type `String.UTF8View`**, which is a collection of **unsigned 8-bit (`UInt8`) values**, one for each byte in the string’s UTF-8 representation:

```swift
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 226 128 188 240 159 144 182 "
```

In the example above:

* The first three decimal `codeUnit` values (`68`, `111`, `103`) represent the characters `D`, `o`, and `g`, whose UTF-8 representation is the same as their ASCII representation
* The next three decimal `codeUnit` values (`226`, `128`, `188`) are a three-byte UTF-8 representation of the `DOUBLE EXCLAMATION MARK` character.
* The last four `codeUnit` values (`240`, `159`, `144`, `182`) are a four-byte UTF-8 representation of the `DOG FACE` character.

#### UTF-16 Representation

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-4.png" style="width: 80%; max-width: 500px" /></div>

You can access a **UTF-16** representation of a `String` by iterating over its `utf16` property. **This property is of type `String.UTF16View`**, which is a collection of **unsigned 16-bit (`UInt16`) values**, one for each 16-bit code unit in the string’s UTF-16 representation:

```swift
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 55357 56374 "
```

#### Unicode Scalar Representation

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-5.png" style="width: 80%; max-width: 500px" /></div>

You can access a Unicode scalar representation of a `String` value by iterating over its `unicodeScalars` property. **This property is of type `UnicodeScalarView`**, which is a collection of **values of type `UnicodeScalar`**.

Each `UnicodeScalar` has a `value` property that returns **the scalar’s 21-bit value**, **represented within a `UInt32` value**:

```swift
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
// Prints "68 111 103 8252 128054 "
```

As an alternative to querying their `value` properties, **each `UnicodeScalar` value can also be used to construct a new `String` value**, such as with string interpolation:

```swift
for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}
// D
// o
// g
// ‼
// 🐶

let newDogString = String(dogString.unicodeScalars)  // String = "Dog‼🐶"
```

---

## [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html)

Three primary *collection types*:

* **Arrays** are ordered collections of values.
* **Sets** are unordered collections of unique values.
* **Dictionaries** are unordered collections of key-value associations.

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-6.png" style="width: 80%; max-width: 800px" /></div>

### <span style="background-color:#fffabc">Mutability of Collections</span>

If you create an array, a set, or a dictionary, and assign it to a **variable**, the **collection** that is created will be ***mutable***.

If you assign an array, a set, or a dictionary to a **constant**, that collection is ***immutable***.

---

### <span style="background-color:#fffabc">Arrays</span>

An *array* stores **values of the same type** in an **ordered list**. The same value can appear in an array multiple times at different positions.

#### Array Type Shorthand Syntax

* Full: `Array<Element>`, where `Element` is the type of values the array is allowed to store. 
* Shorthand form: `[Element]`.
* Although the two forms are functionally identical, **the shorthand form is preferred** and is used throughout this guide when referring to the type of an array.

#### Creating an Empty Array

* `Array<Element>()` or `[]` if the context already provides type information

```swift
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
// Prints "someInts is of type [Int] with 0 items."

someInts.append(3)
// someInts now contains 1 value of type Int
someInts = []
// someInts is now an empty array, but is still of type [Int]
```

#### Creating an Array with a Default Value

```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
```

#### Creating an Array by Adding Two Arrays Together

```swift
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```

#### Creating an Array with an Array Literal

Initialize an array with an *array literal*: `[value 1, value 2, value 3]`

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList has been initialized with two initial items

// or ignore the type thanks to Swift’s type inference
var shoppingList = ["Eggs", "Milk"]
```

#### Accessing and Modifying an Array

The number of items in an array: check its read-only `count` property:

```swift
print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."
```

Use the Boolean `isEmpty` property as a shortcut for checking whether the `count` property is equal to `0`:

```swift
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// Prints "The shopping list is not empty."
```

Add new item: `append(_:)` method:

```swift
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes
```

**Append an array** of one or more compatible items with the **addition assignment operator (`+=`)**:

```swift
shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items
```

Retrieve a value from the array by using ***subscript syntax*** (zero-indexed):

```swift
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"
```

Change an existing value at a given index by using subscript syntax:

```swift
shoppingList[0] = "Six eggs"
// the first item in the list is now equal to "Six eggs" rather than "Eggs"
```

The index must be valid. E.g. `shoppingList[shoppingList.count] = "Salt"` to try to append an item to the end of the array results in a runtime error.

You can also use subscript syntax to **change a range of values at once**, **even if the replacement set of values has a different length than the range you are replacing**. The following example replaces `"Chocolate Spread"`, `"Cheese"`, and `"Butter"` with `"Bananas"` and `"Apples"`:

```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList now contains 6 items
```

**To insert an item** into the array at a specified index, call the array’s `insert(_:at:)` method:

```swift
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list
```

**Remove an item** from the array with the `remove(at:)` method. This method removes the item at the specified index and **returns the removed item** (although you can ignore the returned value if you do not need it):

```swift
let mapleSyrup = shoppingList.remove(at: 0)
// the item that was at index 0 has just been removed
// shoppingList now contains 6 items, and no Maple Syrup
// the mapleSyrup constant is now equal to the removed "Maple Syrup" string
```

Any gaps in an array are closed when an item is removed, and so the value at index `0` is once again equal to `"Six eggs"`:

```swift
firstItem = shoppingList[0]
// firstItem is now equal to "Six eggs"
```

Remove the final item from an array: use the `removeLast()` method rather than the `remove(at:)` method to avoid the need to query the array’s `count` property. Like the `remove(at:)` method, `removeLast()` returns the removed item:

```swift
let apples = shoppingList.removeLast()
// the last item in the array has just been removed
// shoppingList now contains 5 items, and no apples
// the apples constant is now equal to the removed "Apples" string
```

#### Iterating Over an Array

```swift
for item in shoppingList {
    print(item)
}
// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas
```

With the integer index of the item: `enumerated()` method

```swift
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas
```

---

### <span style="color: #c0c0c0">Sets</span>

A *set* stores distinct **values of the same type** in a collection **with no defined ordering**. You can use a set instead of an array **when the order of items is not important**, or when you need to ensure that **an item only appears once**.

#### Hash Values for Set Types

A type must be *hashable* in order to be stored in a set—that is, the type must provide a way to compute a *hash value* for itself. A **hash value** is **an `Int` value that is the same for all objects that compare equally**, such that if `a == b`, the hash value of `a` is equal to the hash value of `b`.

All of Swift’s **basic types** (such as `String`, `Int`, `Double`, and `Bool`) **are hashable by default**, and can be used as set value types or dictionary key types. **Enumeration case values without associated values** (as described in [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)) are also hashable by default.

#### Set Type Syntax

* `Set<Element>`: `Element` is the type that the set is allowed to store
* Sets do not have an equivalent shorthand form.

#### Creating and Initializing an Empty Set

```swift
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// Prints "letters is of type Set<Character> with 0 items."

letters.insert("a")
// letters now contains 1 value of type Character
letters = []
// letters is now an empty set, but is still of type Set<Character>
```

#### Creating a Set with an Array Literal

You can also **initialize a set with an array literal**, as a shorthand way to write one or more values as a set collection.

A set type **cannot be inferred from an array literal** alone, so **the type `Set` must be explicitly declared**. However, because of Swift’s type inference, you **don’t have to write the type of the set’s elements** if you’re initializing it with an array literal that contains values of just one type. The initialization of `favoriteGenres` could have been written in a shorter form instead:

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
```

#### Accessing and Modifying a Set

```swift
print("I have \(favoriteGenres.count) favorite music genres.")
// Prints "I have 3 favorite music genres."

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// Prints "I have particular music preferences."

favoriteGenres.insert("Jazz")
// favoriteGenres now contains 4 items

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// Prints "It's too funky in here."
```

#### Iterating Over a Set

```swift
for genre in favoriteGenres {
    print("\(genre)")
}
// Classical
// Jazz
// Hip hop

// sorted() returns the set’s elements as an array sorted using the < operator
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
// Classical
// Hip hop
// Jazz
```

---

### <span style="color: #c0c0c0">Performing Set Operations (and this)</span>

You can efficiently perform **fundamental set operations**, such as **combining** two sets together, determining which values two sets **have in common**, or determining whether two sets **contain all, some, or none of the same values**.

#### Fundamental Set Operations

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-7.png" style="width: 80%; max-width: 600px" /></div>

- Use the `intersection(_:)` method to create a new set with only **the values common to both sets**.
- Use the `symmetricDifference(_:)` method to create a new set **with values in either set, but not both**.
- Use the `union(_:)` method to create a new set **with all of the values in both sets**.
- Use the `subtracting(_:)` method to create a new set **with values not in the specified set**.

```swift
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]
```

#### Set Membership and Equality

The illustration below depicts three sets—`a`, `b` and `c`—with **overlapping regions** representing **elements shared among sets**. 

* Set `a` is a *superset* of set `b`, because `a` contains all elements in `b`.
* Conversely, set `b` is a *subset* of set `a`, because all elements in `b` are also contained by `a`.
* Set `b` and set `c` are *disjoint* with one another, because they share no elements in common.

<div style="text-align: center;"><img src="/images/2020-12-31-swift-stanford-reading-1-part-2-notes-8.png" style="width: 80%; max-width: 400px" /></div>

- Use the “is equal” operator (`==`) to determine whether two sets **contain all of the same values**.
- Use the `isSubset(of:)` method to determine whether **all of the values of a set are contained in the specified set**.
- Use the `isSuperset(of:)` method to determine whether a set **contains all of the values in a specified set**.
- Use the `isStrictSubset(of:)` or `isStrictSuperset(of:)` methods to determine whether a set is a subset or superset, but **not equal to**, a specified set.
- Use the `isDisjoint(with:)` method to determine whether **two sets have no values in common**.

```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true
```

---

### <span style="background-color:#fffabc">Dictionaries</span>

* A ***dictionary*** stores associations between **keys** of the same type and **values** of the same type in a collection with **no defined ordering**.
* Each value is associated with a **unique *key***, which acts as an **identifier** for that value within the dictionary.

#### Dictionary Type Shorthand Syntax

`Dictionary<Key, Value>`:

* `Key`: the type of value that can be used as a dictionary key. A dictionary `Key` type must **conform to the `Hashable` protocol**, like a set’s value type.
* `Value`: the type of value that the dictionary stores for those keys.
* Shorthand form: `[Key: Value]` (preferred)

#### Creating an Empty Dictionary

```swift
var namesOfIntegers = [Int: String]()
// namesOfIntegers is an empty [Int: String] dictionary

namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]
```

#### Creating a Dictionary with a Dictionary Literal

*Dictionary literal*: `[key 1: value 1, key 2: value 2, key 3: value 3]`

```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// or the type can be inferred
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

#### Accessing and Modifying a Dictionary

```swift
print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// Prints "The airports dictionary is not empty."

airports["LHR"] = "London"
// the airports dictionary now contains 3 items

airports["LHR"] = "London Heathrow"
// the value for "LHR" has been changed to "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin."

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."

airports["APL"] = "Apple International"
// "Apple International" is not the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."
```

#### Iterating Over a Dictionary

```swift
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow
// YYZ: Toronto Pearson

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson

let airportCodes = [String](airports.keys)
// airportCodes is ["LHR", "YYZ"]

let airportNames = [String](airports.values)
// airportNames is ["London Heathrow", "Toronto Pearson"]
```

---
