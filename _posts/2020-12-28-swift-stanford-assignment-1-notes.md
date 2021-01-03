---
layout: post
title: Notes of Swift Assignment 1
categories: notes Swift
date: 2020-12-28
---

# My Solutions of the Tasks

Here I will list down my solutions corresponding to each required task.

1. > Get the Memorize game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.

   Done in my notes

2. > Currently the cards appear in a predictable order (the matches are always side-by-side, making the game very easy). Shuffle the cards.

   Fortunately the `Array` already provides the function `shuffle`, so what I have done is to modify the add `cards.shuffle()` after creating cards in `MemoryGame.init`:

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
           
           // shuffle the cards
           cards.shuffle()  // answer
       }
       
       ...
   }
   ```

   <div><img src="/images/2020-12-28-swift-stanford-assignment-1-notes-1.png" style="max-width:200px;width:100%" /></div>

   And I think it makes sense to shuffle cards in the Model of MVVM, as the View should reflect the content of the Model, instead of interpreting the orders of the cards that we are showing. So it's up to the Model to decide the orders of the generated cards. It also doesn't make sense to shuffle cards in the ViewModel, as it should be responsible of noticing changes of the Model, publishing changes, and modifying models when the View calls Intent functions. *Changing the model (i.e. shuffling cards in MemoryGame) when the game is initialized* is not in one of the above tasks.

   It's also possible to shuffle the range `0..<numberOfPairsOfCards` before iterating them, but it                                                                                                                                                                                                                                                                                 

3. > Our cards are currently arranged in a single row (we’ll fix that next week). That’s making our cards really tall and skinny (especially in portrait) which doesn’t look very good. Force each card to have a width to height ratio of 2:3 (this will result in empty space above and/or below your cards, which is fine). 

   By searching on Google, I found the `aspectRatio` to be a useful function. It takes two arguments: `_ aspectRatio: CGFloat? = nil` and `contentMode: ContentMode`. The first one, according to the document, takes the ratio of width to height to use for the resulting view. In this case, we simply need to specify `2 / 3` for this argument. And the `contentMode` has two options: `.fill` and `.fit`, which specifies whether this view fits or fills the parent context. I was not sure which one to use, but from the results, I should use `.fit`, so the cards do not stretch.

   Another question is, on which View should I use `aspectRatio`? One way is to do it after every `RoundedRectangle`, but the better way would be to specify it after `ForEach` in the `HStack`:

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
               .aspectRatio(2 / 3, contentMode: .fit)  // answer
           }
           .foregroundColor(.orange)
           .padding()
           .font(Font.largeTitle)
       }
   }
   ```

   It's also possible to put it after each `CardView`.

   <div><img src="/images/2020-12-28-swift-stanford-assignment-1-notes-2.png" style="max-width:200px;width:100%" /></div>

4. > Have your game start up with a random number of pairs of cards between 2 pairs and 5 pairs.

   First of all, we need to create at least 5 emojis, then we need to randomly generate an integer in range `2...5` or `2..<6`. Fortunately, `Int` provides a convenient static function `random` that takes a range and returns a random number in this range.

   ```swift
   class EmojiMemoryGame {
       private var model = EmojiMemoryGame.createMemoryGame()
       
       static func createMemoryGame() -> MemoryGame<String> {
           let emojis = ["👻", "🎃", "🕷", "🕸", "🍂"]
           let numberOfPairsOfCards = Int.random(in: 2...5)  // answer (this line and next line)
           return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
               return emojis[pairIndex]
           }
       }
       
       ...
   }
   ```

   <div><img src="/images/2020-12-28-swift-stanford-assignment-1-notes-3.png" style="max-width:200px;width:100%" /></div>

5. > When your game randomly shows 5 pairs, the font we are using for the emoji will be too large (in portrait) and will start to get clipped. Have the font adjust in the 5 pair case (only) to use a smaller font than .largeTitle. Continue to use .largeTitle when there are 4 or fewer pairs in the game.

   Here we have several options: use conditional statements (i.e. if / else), or use a [Ternary Conditional Operator](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html#ID71) (i.e. `question ? answer1 : answer2`) to specify the `fontSize` based on the number of cards. For 5 pairs of cards we have 10 cards, so I set the condition to be `viewModel.cards.count >= 10`, and in that case, assign `Font.title3` to `fontSize`, otherwise use `Font.largeTitle`. Then use `fontSize` in the `font` function. I chose `Font.title3` as it fits in the cards better.

   ```swift
   struct ContentView: View {
       var viewModel: EmojiMemoryGame
       
       var body: some View {
           let fontSize = viewModel.cards.count >= 10 ? Font.title3 : Font.largeTitle
           HStack {
               ForEach(viewModel.cards) { card in
                   CardView(card: card).onTapGesture {
                       viewModel.choose(card: card)
                   }
               }
               .aspectRatio(2 / 3, contentMode: .fit)  // answer
           }
           .foregroundColor(.orange)
           .padding()
           .font(fontSize)
       }
   }
   ```

   <div><img src="/images/2020-12-28-swift-stanford-assignment-1-notes-4.png" style="max-width:200px;width:100%" /></div>

6. > Your UI should work in portrait or landscape on any iOS device. In landscape your cards will be larger (but still 2:3 aspect ratio). This probably will not require any work on your part (that’s part of the power of SwiftUI), but be sure to experiment with running on different simulators in Xcode to be sure.

   iPhone 11 Pro Max - 14.3 / portrait and landscape:

   <div style="display: flex;align-items: center;">
       <div style="max-width:200px;width: 50%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-5.png" style="width:100%;border:1px solid #aaaaaa" />
       </div>
       <div style="max-width:400px;width: 50%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-6.png" style="width:100%;border:1px solid #aaaaaa" />
       </div>
   </div>

   iPad Pro (12.9-inch) - 4th generation - 14.3 / portrait and landscape:

   <div style="display: flex;align-items: center;">
       <div style="max-width:200px;width: 50%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-7.png" style="width:100%;border:1px solid #aaaaaa" />
       </div>
       <div style="max-width:300px;width: 50%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-8.png" style="width:100%;border:1px solid #aaaaaa" />
       </div>
   </div>

   From this experiment, I think that the font size should be adapted based on the screen size or with some smarter approach. Otherwise the emojis look too small in large screens or already too small in landscape of iPhone 11 Pro Max.

# Bonus points

1. > Have the emoji on your cards be randomly chosen from a larger set of emoji (at least a dozen). In other words, don’t always use the same five emoji in every game.

    I change the `emojis` to be an array of 25 emojis, shuffle it, and assign the sub-array of shuffled emojis to a new constant `randomEmojis`, and use emojis in `randomEmojis` as the content of the cards.

   ```swift
   class EmojiMemoryGame {
       private var model = EmojiMemoryGame.createMemoryGame()
       
       static func createMemoryGame() -> MemoryGame<String> {
           let emojis = ["👻", "🎃", "🕷", "🕸", "🍂",
                         "😀", "🤪", "🤩", "🥳", "😫",
                         "😈", "💩", "🤟", "🙏", "💋",
                         "🗣", "🐭", "🙉", "🦇", "🦗",
                         "☎️", "💸", "🚽", "🎈", "🛒"]  // answer
           let numberOfPairsOfCards = Int.random(in: 2...5)
           let randomEmojis = emojis.shuffled()[0..<numberOfPairsOfCards]  // answer
           return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
               return randomEmojis[pairIndex]  // answer
           }
       }
       
       ...
   }
   ```

   <div style="display: flex;">
       <div style="max-width:200px;width: 33.33%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-9.png" style="width:100%" />
       </div>
       <div style="max-width:200px;width: 33.33%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-10.png" style="width:100%" />
       </div>
       <div style="max-width:200px;width: 33.33%;padding: 5px">
           <img src="/images/2020-12-28-swift-stanford-assignment-1-notes-11.png" style="width:100%" />
       </div>
   </div>

