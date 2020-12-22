---
layout: post
title: "Notes of Swift Lecture 1"
date: 2020-12-22
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
    <div><img src="/images/2020-12-22-swift-stanford-lecture-1-notes-1.png" width="200" /></div>
* First app
  - Create the first app using Xcode with SwiftUI
  - Trouble shooting of testing the app on real device:
    1. Setup free developer account: simply log in to [developer.apple.com](https://developer.apple.com) with your personal Apple ID, and accept the terms if necessary.
    2. Setup account in Xcode
    3. Create a new project and set the bundle properly (e.g. com.fanglin.swift-exercises.Memorize). The default bundle generated automatically didn't work for me.
    4. Build and run on the device - must be connected via wire. After installing, we need to go settings on the device -> ??

