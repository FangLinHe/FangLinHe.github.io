---
layout: post
title: "Notes of Swift Lecture 1"
categories: notes Swift
date: 2020-12-24
---

## Lecture 1: Course Logistics and Introduction to SwiftUI

[Video on YouTube](https://youtu.be/jbtqIBpUG7g)

Introduction copied from YouTube description:
> The first of the lectures given to Stanford University students who took CS193p, Developing Applications for iOS using SwiftUI, during Spring quarter of 2020.
> 
> <ins>Paul Hegarty</ins> covers the **logistics of the course** and then dives right into **creating an iOS application** (a card-matching game called Memorize).  The Xcode development environment is used to **demonstrate the basics of SwiftUI’s declarative interface** for composing user-interfaces.
> 
> Note that this is not an active, on-line course.  It is a release of lecture videos that were already given to Stanford students as part of its normal curriculum.

---

* Introduction to the course
  - The first app we will build: Card Matching Game
    
    <div><img src="/images/2020-12-24-swift-stanford-lecture-1-notes-1.png" width="200" /></div>
  
* Create the first app using Xcode, Swift, and with **SwiftUI**

* My trouble shooting of testing the app on real device:
  1. Setup free developer account: simply log in to [developer.apple.com](https://developer.apple.com) with your personal Apple ID, and accept the terms if necessary.
  
  2. Setup account in Xcode: Xcode &rarr; Preferences &rarr; Accounts &rarr; click + under Apple IDs &rarr; Add Apple ID or create a new one
  
  3. Create a new project and change the **Organization Identifier** properly (e.g. original: `com.gmail.email.account` &rarr; `com.fanglin.swift-exercise`). The default identifier generated automatically didn't work for me.
  
  4. **Build and run the app on my device** instead of running it on the simulator didn't work (**the device must be connected via wire**). A message shows:
  
     ```
     Could not launch “Memorize”

     The operation couldn’t be completed.
     Unable to launch com.fanglin.swift-exercises.Memorize because it has an invalid code signature,
     inadequate entitlements or its profile has not been explicitly trusted by the user.
     ```
  
     The solution is, go to your device Settings &rarr; General &rarr; Profiles & Device Management &rarr; under `DEVELOPER APP`, click `Apple Development: your@apple.id` &rarr; Click the blue text `Trust "Apple Development: your@apple.id"` &rarr; Trust &rarr; run it again, you should see the app running successfully.
  
* SwiftUI preview: click the `ContentView.swift` in project navigator, two windows are shown, the left one is the editor, and **the right one is the preview window**. The preview window can be hidden by Editor &rarr; uncheck `canvas` (or option+command+return).

---

```swift
import SwiftUI
```

* Import a package called `SwiftUI` for doing UI stuff.

---

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .padding()
    }
}
```

* `struct` in Swift: container of variables, functions, and behaviors.

* `struct ContentView: View`: this struct is going to **behave / function like a view**; this is not object-oriented programming, but a **functional programming**.

* `View`: a rectangular area on the screen, both for drawing and also for multi-touch.

* `ContentView`: the entire rectangle that fills the screen.

* `var body: some View`: you must define this var (i.e. variables / properties) called body, and the type of this var (`some View`) is **any type, any struct, as long as it behaves like a view**. Which type it returns exactly will be determined by the compiler by looking at the code in the function body.

* `Text("Hello, World!").padding()` in curly-braces: if it is a one-liner, it means to return the result to this function. `return` is omitted in this case. We can also add it back.

* Swift is a `strongly-typed` language: every variable has a specific type and always has a value.

---

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

* Gluing the UI code to the screen. Not the focus here.

## Start making the cards!

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(0..<6) { index in
                CardRowView(rowNumber: index)
            }
        }
        .foregroundColor(.orange)
        .padding()
        .font(Font.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        if isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text("👻")
            }
        } else {
            RoundedRectangle(cornerRadius: 10.0)
        }
    }
}

struct CardRowView: View {
    var rowNumber: Int
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                CardView(isFaceUp: (rowNumber + index) % 2 == 0)
            }
        }
    }
}
```

👆 *my final code*

<div><img src="/images/2020-12-24-swift-stanford-lecture-1-notes-2.png" width="200" /></div>

👆 *my results*

* `Text("👻")`: some string

* `padding`: add some padding inside the View's edges

* `RoundedRectangle(cornerRadius: 10.0)`

* `ZStack`: a struct that also behaves like a view; the input `content` is **in a curly-braces a list of the Views to stack on top of each other**.

* `stroke` (`RoundedRectangle(cornerRadius: 10.0).stroke()`): for any Shapes (like here `RoundedRectangle`) can all be "stroked" by calling the function `stroke` on them.

* `foregroundColor` (`RoundedRectangle(cornerRadius: 10.0).stroke().foregroundColor(.orange)`): change the foreground color by calling the function `foregroundColor`. `.orange` is short for `Color.orange`. The same function can be applied on Text. It can be also applied to ZStack, and it means **tell every View inside of me to use forground color orange, if the View in it is not overwritten.**.

* `fill`: fill the shape with a color or gradient

* `ForEach` (`ForEach(0..<4, content: { index in ... })`): for each interable thing `data` (e.g. range `0..<4` here), run the function specified in `content`; `index` is one of the element in the `data`.

* `HStack`: **stack** Views **h**orizontally

* `font`: change the font

* Omit some code:

  * `return` can be omitted in a one-line function

  * If a function argument takes a `Closure Expression` (works as a function):

    ```swift
    { (parameters) (-> return type) in
        statements
    }
    ```

    , e.g. `ForEach(0..<4, content: { index in ... })`, we can write it like `ForEach(0..<4) { index in ... }`.

* `Encapsulation`: we can "encapsulate" some code to increase the readability, e.g.

  ```swift
      var body: some View {
          HStack {
              ForEach(0..<4) { index in
              		ZStack {
                      RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                      RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                      Text("👻")
              		}
              }
          }
      }
  ```

  , we can move `ZStack { ... }` to a new struct, which also behaves like a view:

  ```swift
  struct ContentView: View {
      var body: some View {
          HStack {
              ForEach(0..<4) { index in
                  CardView()
              }
          }
      }
  }
  
  struct CardView: View {
      var body: some View {
          ZStack {
              RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
              RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
              Text("👻")
          }
      }
  }
  ```

