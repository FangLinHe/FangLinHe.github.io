---
layout: post
title: Notes of Swift Lecture 2
date: 2020-12-28
---

[Video on YouTube](https://youtu.be/4GjXq2Sr55Q)

Introduction copied from YouTube description:

> The series of video lectures given to Stanford University students in Spring of 2020 continues with a conceptual overview of the **architectural paradigm** underlying the development of applications for iOS: **MVVM**.  In addition a key concept in the Swift Programming Language, its **type system**, is explained.  The Memorize demonstration continues, incorporating MVVM.



> It is impossible to develop applications for iOS using SwiftUI without using the MVVM architecture for organizing your code.  This lecture explains what that is and then demonstrates how it works in our demonstration application.  SwiftUI development happens entirely in the programming language Swift.  Swift is unique in its **support of most modern language features**, including both **object-oriented programming** and functional programming.  Since functional programming is new to most Stanford students, this lecture starts the process of explaining how it works by covering the <u>basics of Swift’s type system</u>, including **structs and classes**, **generics** and **functions as types**.  The demonstration then moves to the next level using the **MVVM architecture** (including creating a **Model**, a **ViewModel**, **expressing user’s intent from the View**) and **utilizing Swift features** like generics and functions as types.  After this lecture, students take over the development of Memorize for their first assignment.



> Archived course materials (homework assignments and lecture slides) are available at [https://cs193p.stanford.edu](https://www.youtube.com/redirect?redir_token=QUFFLUhqbEpKSHBwQmF3bjN5aWdHaWF1MkJ4OVFwb0Z5UXxBQ3Jtc0tucFB3OGNQR1B0ZnNIck9UdER1bWQ4Y3BrVjZEc3pmYUZqbzV2LWR0VVBQaU8wUFZSYnZFVFlzSHF5S3dpYjZCNkt5N0paN3BReFdNUk9mX2UzVUF2SjdsU2dpWXNZNnZEQ3FGMFNKc09TLWduMk8wZw%3D%3D&v=4GjXq2Sr55Q&q=https%3A%2F%2Fcs193p.stanford.edu&event=video_description).

---

# MVVM

<div><img src="/images/2020-12-28-swift-stanford-lecture-2-notes-1.png" style="max-width:800px;width:100%" /></div>

👆 *MVVM overview*

* **MVVM**:
  * A design paradigm
  * A code organizing model
  * Abbreviation of `Model-View-ViewModel`
  * Works in concert with the concept of **reactive** user interfaces
  * Must be adhered to **for SwiftUI to work**
  * Different from `MVC (Model-View-Controller)` with UIKit (old-style iOS development mechanicsm uses)
  * Trying to separate the **Model** (the back-end of the app), independent part with the **View** (in front of the users)
* **Model**:
  * UI independent (e.g. doesn't import SwiftUI)
  * Encapsulate the **data** and the **logic** about what your application does
  * E.g. in the card-matching game: cards (data), logic (what happens when I choose a card, how to match, how many points I get when I match, what happens if mismatch, etc.)
  * The truth
* **View**:
  * Reflects the model
  * The **data** is always flowing **from the Model to the View**
  * Draws what's in the model; reflects the state of the game in the model
  * Stateless
  * Declarative (declare that the View looks this way, and we're going to change anything on the screen only when the model changes)
  * Reactive / reactive programming (whenever Model changes, the View changes to look like it automatically)
* **ViewModel**:
  * Bind the View to the Model
  * Interpreter (interpreting the Model for the View)
  * Can be as simple as a struct, a SQL database, or something over the network (HTTP requests)
  * `Model` -- **notice changes** &rarr; `ViewModel` &rarr; `View`: e.g. using struct, **it's copied around when it's passed to functions** &rarr; Swift knows when a struct has changed
  * ViewModel might interpret the data to convert to some other format for the View to draw
  * `Model` -- notice changes &rarr; `ViewModel` -- **publish something changed to the world** &rarr; `View`
  * ViewModel doesn't have any pointers to the View; it doesn't talk directly to its Views
  * The View subscribes to that publication (*automatically observes publications*) &rarr; if something has changes &rarr; ask ViewModel what the current state is (*pull data*) &rarr; draw to reflect the state of the world (*rebuilds*)

* Some example of the syntax will be used:
  * ViewModel:
    * `ObservableObject`
    * `@Published`
    * `objectWillChange.send()`
    * `.environmentObject()`
  * View:
    * `ObservedObject`
    * `@Binding`
    * `.onReceive`
    * `@EnvironmentObject`
* The other direction (View wants to change Model):
  * ViewModel **processes the user's intent**
  * Related architecture: **Model-View-Intent**
  * E.g. in the card memory game, the intent is when the user chooses a card &rarr; the View will **call an Intent fucntion** in the ViewModel &rarr; the ViewModel will **modify the Model** &rarr; the Model notices changes &rarr; the ViewModel might interpret &rarr; the ViewModel publishes "something changed"

<div><img src="/images/2020-12-28-swift-stanford-lecture-2-notes-2.png" style="max-width:800px;width:100%" /></div>

👆 *the whole picture of MVVM*

---

# Varieties of Type

* struct
* class
* protocol (next time)
* "Don't care" type (aka generics)
* enum (next time)
* functions

---

## `struct` and `class`

* They have pretty much exactly **the same syntax**:

  * Stored `var`s (sotred variables in memory), e.g.

    ```swift
    var isFaceUp: Bool
    ```

  * Computed `var`s (the values are the results of evaluating some code), e.g.

    ```swift
    var body: some View {
        return Text("Hello World")
    }
    ```

  * Constant `let`s (i.e. `var`s whose values never change), e.g.

    ```swift
    let defaultColor = Color.orange
    ...
    CardView().foregroundColor(defaultColor)
    ```

  * Functions `func`.

    * With single label for the argument(s), e.g. `operand` and `by` in the example

      ```swift
      func multiply(operand: Int, by: Int) -> Int {
          return operand * by
      }
      multiply(operand: 5, by: 6) // return 30
      ```

      In this function `multiply`, it has two arguments: `operand` and `by`, both have type `Int`, and the function returns an `Int`. Inside the function, it uses `operand` and `by` to make it operate.

    * With two labels for the argument(s), e.g.

      ```swift
      func multiply(_ operand: Int, by otherOperand: Int) -> Int {
          return operand * otherOperand
      }
      multiply(5, by: 6)
      ```

      The first parameter has the label `_` (underbar) and the label `operand`; the second one has the label `by` and `otherOperand`. The first labels `_` and `by` are **used by callers of the function** (i.e. `multiply(5, by: 6)`) / **external names**, and the second labels `operand` and `otherOperand` are **used inside the function** / **internal names**. `_` means **no label** / **leave it out** / **unused**.

  * Initializers `init`, used to create the struct or class **with some argument that is not one of your variables**. E.g.

    ```swift
    struct MemoryGame {
        init(numberOfPairsOfCards: Int) {
            // create a game with that many pairs of cards
        }
    }
    ```

    You can have many `init`s taking different argument(s).

* Differences between struct and class

  | `struct`                                                     | `class`                                                      |
  | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | Value type                                                   | Reference type                                               |
  | Copied when passed or assigned                               | Passed around via pointers (i.e. storage in the heap)        |
  | Copy on write<br />(it actually makes a copy when you actually write to a struct.) | Automatically reference counted<br />(when no one is left pointing, the memory gets freed up) |
  | Support functional programming                               | Support object-oriented programming                          |
  | No inheritance                                               | Inheritance (single inheritance: inherit from one class)     |
  | "Free" `init` initializes all `var`s                         | "Free" `init` initializes no `var`s                          |
  | Mutability must be explicitly stated<br />(i.e. `let a: SomeStruct` you can't mutate it,<br />`var a: SomeStruct` you can mutate it) | Always mutable                                               |
  | Your "go to" data structure (i.e. use it as the first try)   | Used in specific circumstancestances                         |
  | Everything you’ve seen so far is a struct<br />(except View which is a protocol) | The ViewModel in MVVM is always a class<br />(also, UIKit (old style iOS) is class-based) |

---

## Generics

* Introduction:
  Sometimes we need the type that "we don't care" which type it is. But Swift is a strongly-typed language; no type is called "untyped". Thus we use **generics** feature instead.

* Example: `Array`

  * An `Array` contains a bunch of things and it doesn't care what type they are

  * Inside the code, it has **variables** for the things it contains, **which ned types**.

  * It needs types for **functions** in it (e.g. add items)

  * &rarr; What they need is **generics**: use a declaration of the "don't care" type

    ```swift
    struct Array<Element> {
        ...
        func append(_ element: Element) { ... }
    }
    ```

    The type of the argument to append is `Element` - don't care type / a placeholder

  * When does the type get set to a real type? When people use Array, e.g.

    ```swift
    var a = Array<Int>()
    a.append(5)
    a.append(22)
    ```

    The actual type of `Element` is `Int`

  * One can have multiple "don't care" types, e.g. `<Element, Foo>`

* "Don't care" type's real name: **Type parameter**

---

## Functions as Types

* Functions are also types, e.g.

  ```swift
  (Int, Int) -> Bool  // takes two Ints and returns a Bool
  (Double) -> Void  // takes a Double and returns nothing
  () -> Array<String>  // takes no arguments and returns an Array of Strings
  // All of the above are types, so we can declare a variable of them
  var foo: (Double) -> Void  // foo's type: function that takes a Double and returns nothing
  func doSomething(what: () -> Bool)  // what's type: function that takes nothing and returns Bool
  ```

* Example usage:

  ```swift
  // a var called operation; its type is "function that takes a Double and returns a double"
  var operation: (Double) -> Double
  
  // a simple function that takes a Double and returns a Double
  func square(operand: Double) -> Double {
      return operand * operand
  }
  
  // assign a value to the operaion var
  operation = square
  let result1 = operation(4)  // 16
  ```

  Notice that the labels are dropped (i.e. `operation(4)` instead of `operation(operand: 4)` when you pass something through a **function type**

  ```swift
  operation = sqrt  // a built-in function
  let result2 = operation(4)  // 2
  ```

* **Closures**:
  * Inlining a function instead of declaring them with `func`
  * SwiftUI: functional programming &rarr; **functions as type** is a very important concept in Swift

---

# Back to the Demo - using MVVM

1. Add a new Swift file for the **Model**:

   New File &rarr; Choose **Swift File** as we are creating a Model, not a UI struct) &rarr; Save As: MemoryGame, Group: Memorize (in yellow folder), location: Memorize/Memorize. The created file looks like this:

   ```swift
   //
   //  MemoryGame.swift
   //  Memorize
   //
   //  Created by FANG LIN HE on 2020/12/27.
   //
   
   import Foundation
   ```

   It doesn't import `SwiftUI` as it's a UI thing; it imports `Foundation` for all basic types (`Int`, `Double`, `Array`, etc.)

2. Add a struct for our **Model**:

   ```swift
   struct MemoryGame<CardContent> {
       var cards: Array<Card>
       
       func choose(card: Card) {
           print("Card chosen: \()")
       }
       
       struct Card {
           var isFaceUp: Bool
           var isMatched: Bool
           var content: CardContent
       }
   }
   ```

   * Full name of `Card` is `MemoryGame.Card`: nesting structs inside structs is a name spacing thing, so we know it's a card for the MemoryGame, not a random card.
   * Embed something in a string with `\()`, e.g. `"Put the thing here: \(something)"` it will embed the value of `something` in this string, as long as `something` **can be turned to a string**
   * Here the card content type is a **generic** type `CardContent`, as it can be anything: images, emojis, numbers, etc.

3. Add a **ViewModel** serves as a glue that **glues the Model (UI independent thing) to the View (UI dependent thing)**:

   New File &rarr; Swift File &rarr; Save As: **EmojiMemoryGame** (a specific MemoryGame that uses emojis as the things it draws) &rarr; the same location and group as the Model

   * Import `SwiftUI` as **a ViewModel is essentially a UI thing**, because it knows how this is going to be drawn on screen

     ```swift
     //
     //  EmojiMemoryGame.swift
     //  Memorize
     //
     //  Created by FANG LIN HE on 2020/12/27.
     //
     
     import SwiftUI
     ```

   * Add a class called **EmojiMemoryGame** for the ViewModel

     ```swift
     class EmojiMemoryGame {
         private(set) var model: MemoryGame<String>
     }
     ```

     * The `model` should be something more descriptive, e.g. game, memoryGame, etc.; here it's called `model` so we clearly see it's a Model.
     * The reasons to use `class` instead of `struct`: easy to share (lives in the heap), as multiple Views need to look at this "portal" (i.e. ViewModel: a portal on to the Model)
     * `private` is used to "close the front-door", so the Model will not be messed up and `model` can only be accessed by the `EmojiMemoryGame` &rarr; but in that case no View can see the model
     * `private(set)` is used to "close the glass-door", so Views can see what's inside the house (`model`) but they can't modify it

   * Add "user intent" related code

     ```swift
     class EmojiMemoryGame {
         ...
         
         // MARK: - Intent(s)
         
         func choose(card: MemoryGame<String>.Card) {
             model.choose(card: card)
         }
     }
     ```

     * The purpose of `MARK: - XXX`: a header that will show the content under it

       <div><img src="/images/2020-12-28-swift-stanford-lecture-2-notes-3.png" style="max-width:600px;width:100%" /></div>

4. Finetune everything to use MVVM properly

   * Modify the accessibility of the `model`, e.g. we only let the View sees the cards in the model

     ```swift
     class EmojiMemoryGame {
         private var model: MemoryGame<String>
         
         // MARK: - Access to the Model
         var cards: Array<MemoryGame<String>.Card> {
             model.cards
         }
         
         ...
     }
     ```

   * Add an initializer to the Model `MemoryGame` to initialize `cards` variable by the given number of pairs and card content factory

     ```swift
     struct MemoryGame<CardContent> {
         var cards: Array<Card>
         
         func choose(card: Card) {
             print("Card chosen: \()")
         }
         
         init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
             cards = Array<Card>()  // creates an empty array
             for pairIndex in 0..<numberOfPairsOfCards {
                 let content = cardContentFactory(pairIndex)
                 cards.append(Card(isFaceUp: false, isMatched: false, content: content))
                 cards.append(Card(isFaceUp: false, isMatched: false, content: content))
             }
         }
         
         struct Card {
             var isFaceUp: Bool
             var isMatched: Bool
             var content: CardContent
         }
     }
     ```

     * `init` is itself a function, so no need to call it `func init`
     * `init` doesn't have return values, as its purpose is to initialize the variables
     * You can have multiple `init`s

   * Initialize the `model` in the ViewModel `EmojiMemoryGame` by the given 2 pairs of cards and a dummy card content factory that always returns 😀

     ```swift
     func createCardContent(pairIndex: Int) -> String {
         return "😀"
     }
     
     class EmojiMemoryGame {
         private var model: MemoryGame<String> =
             MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: createCardContent)
         
         ...
     }
     ```

   * Prevent creating extra little functions &rarr; inline the function / write a **closure**:

     ```swift
     import SwiftUI
     
     class EmojiMemoryGame {
         private var model =
             MemoryGame<String>(numberOfPairsOfCards: 2) { _ in "😀" }
         
         ...
     }
     ```

     * Inline the function: moves `{` to before the arguments and place `in`
     * Type inferences: as the argument type and the return type of `cardContentFactory` can be referred by the argument type of `MemoryGame`'s  `init`, we don't need `Int` in and `-> String` in `(pairIndex: Int) -> String`; then the parenthesis of `(pairIndex)` can also be omitted
     * The inline function has one line &rarr; `return` can be omitted
     * When the last argument of a function is a function type: we can get rid of the keyword `cardContentFactory` and put the curly brace thing outside
     * As `pairIndex` is not used here: replace it with `_` meaning "it doesn't matter what it is"; it must be placed to say we know there is an argument but we don't use it

   * Create a function to create a `MemoryGame` and use it to define `model`

     ```swift
     import SwiftUI
     
     class EmojiMemoryGame {
         private var model = EmojiMemoryGame.createMemoryGame()
         
         static func createMemoryGame() -> MemoryGame<String> {
             let emojis = ["👻", "🎃", "🕷"]
             return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
                 return emojis[pairIndex]
             }
         }
         
         ...
     }
     ```

     * `[a, b, c, ...]` is the way how to create an Array; `array[index]` is how to access the `index`-th element in the array

     * `emojis` has the type `Array<String>` which can be inferred by the value (`["👻", "🎃", "🕷"]`), so we can omit the type

     * We can use `array.count`, which returns the number of elements in the array, instead of hard-corded `2` for `numberOfPairsOfCards`

     * Here the function `createMemoryGame` must be a static function, because all functions cannot be used until all variables are initialized. `static` makes the function on the *type* (`EmojiMemoryGame`), not on the *instance* (e.g. `let game = EmojiMemoryGame()`.

     * We already used static members before, e.g. `Color.orange`,  `Font.largeTitle`, these are constants of types `Color` and `Font`.

     * Hint of jumping into the documentation: hold down the `option` key, it'll show a question mark on the mouse, click on it, e.g. Font, it'll give a short description of what `Font` is, then click on <u>Open in Developer Documentation</u>, a detailed document will pop up

       <div><img src="/images/2020-12-28-swift-stanford-lecture-2-notes-4.png" style="max-width:600px;width:100%" /></div>

       <div><img src="/images/2020-12-28-swift-stanford-lecture-2-notes-5.png" style="max-width:600px;width:100%" /></div>

   * In the `ContentView`, use the cards defined in model

     ```swift
     // ContentView.swift
     
     struct ContentView: View {
         // EmojiMemoryGame is a class, so viewModel is shared
         // Here the `viewModel` should be some name more meaningful, e.g. game
         var viewModel: EmojiMemoryGame
         
         var body: some View {
             HStack {
                 // the iterable thing in ForEach (viewModel.cards) should be "identifiable",
                 // so we need to make Card implement the protocal "Identifiable"
                 // (i.e. have a variable "id")
                 ForEach(viewModel.cards) { card in
                     CardView(card: card)
                 }
             }
             .foregroundColor(.orange)
             .padding()
             .font(Font.largeTitle)
         }
     }
     
     struct CardView: View {
         var card: MemoryGame<String>.Card
         
         var body: some View {
             if card.isFaceUp {
                 ZStack {
                     RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                     RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                     Text(card.content)
                 }
             } else {
                 RoundedRectangle(cornerRadius: 10.0)
             }
         }
     }
     ```

   * Make the `MemoryGame.Card` in `MemoryGame.swift` to function like an `Identifiable` (which is a protocol) in order to use it by `ForEach`:

     ```swift
     struct MemoryGame<CardContent> {
         ...
         
         init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
             cards = Array<Card>()  // creates an empty array
             for pairIndex in 0..<numberOfPairsOfCards {
                 let content = cardContentFactory(pairIndex)
                 cards.append(Card(content: content, id: pairIndex * 2))
                 cards.append(Card(content: content, id: pairIndex * 2 + 1))
             }
         }
         
         struct Card: Identifiable {
             var isFaceUp: Bool = true
             var isMatched: Bool = false
             var content: CardContent
             let id: Int
         }
     }
     ```

     * Here the struct `Card` must implement a variable called `id` (here I use a constant as it should not be changed), which can be any type, and the value should be unique for each element.
     * Here we set the default values of the variables `isFaceUp` and `isMatched` to false, so we don't need to initialize them in the `init` function.

   * In the `MemorizeApp` defined in `MemorizeApp.swift`, create a `EmojiMemoryGame` and initialize `ContentView` with this game (i.e. pointer to a ViewModel)

     ```swift
     //
     //  MemorizeApp.swift
     //  Memorize
     //
     //  Created by FANG LIN HE on 2020/12/24.
     //
     
     import SwiftUI
     
     @main
     struct MemorizeApp: App {
         var body: some Scene {
             WindowGroup {
                 let game = EmojiMemoryGame()
                 ContentView(viewModel: game)
             }
         }
     }
     ```

     * Note that I'm using Xcode 12.3, so it's already using newer version of SwiftUI (SwiftUI 2.0) from the video. In the video, this line of code lies in `SceneDelegate.swift`. More info of new SwiftUI, see the WWDC20 video: [What's new in SwiftUI](https://developer.apple.com/videos/play/wwdc2020/10041/).

   * Do similar thing for ContentView in `ContentView_Previews`:

     ```swift
     struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
             ContentView(viewModel: EmojiMemoryGame())
                 .preferredColorScheme(.dark)
         }
     }
     ```

     This is simply for the preview, so it's fine to not share the same `EmojiMemoryGame` instance.

   * Finally, implement the tapping with `onTapGesture` on the `CardView`:

     ```swift
     struct ContentView: View {
         var viewModel: EmojiMemoryGame
         
         var body: some View {
             HStack {
                 ForEach(viewModel.cards) { card in
                     CardView(card: card).onTapGesture {
                         viewModel.choose(card: card)
                     }
                 }
             }
             .foregroundColor(.orange)
             .padding()
             .font(Font.largeTitle)
         }
     }
     ```

     * Here the `onTapGesture` function takes a function type as an argument, so we can put in curly braces directly after the function name, and it returns a View. In the closure, we call the `viewModel.choose(card: card)` to react the user intent, i.e. printing which card is chosen.

5. Final result:

   <div><img src="/images/2020-12-28-swift-stanford-lecture-2-notes-6.png" style="max-width:300px;width:100%" /></div>

   👆 *6 cards defined in the Model is shown on the View*

   ```
   Card chosen: Card(isFaceUp: true, isMatched: false, content: "👻", id: 0)
   Card chosen: Card(isFaceUp: true, isMatched: false, content: "👻", id: 1)
   Card chosen: Card(isFaceUp: true, isMatched: false, content: "🎃", id: 2)
   Card chosen: Card(isFaceUp: true, isMatched: false, content: "🎃", id: 3)
   Card chosen: Card(isFaceUp: true, isMatched: false, content: "🕷", id: 4)
   Card chosen: Card(isFaceUp: true, isMatched: false, content: "🕷", id: 5)
   ```

   👆 *Texts shown when we tap on each card*

