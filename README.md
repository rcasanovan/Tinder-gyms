# iOS Coding Challenge

## Here we go!

This demo implements a similar version of a popular dating app to list a series of gyms with activities.

The user can discard or like each of the gyms/activities and depending on the case, show a match.


## Architecture

"The Composable Architecture (TCA, for short) is a library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind. It can be used in SwiftUI, UIKit, and more, and on any Apple platform (iOS, macOS, tvOS, and watchOS)".


## What is the Composable Architecture?

This library provides a few core tools that can be used to build applications of varying purpose and complexity. It provides compelling stories that you can follow to solve many problems you encounter day-to-day when building applications, such as:

* State management

How to manage the state of your application using simple value types, and share state across many screens so that mutations in one screen can be immediately observed in another screen.

* Composition

How to break down large features into smaller components that can be extracted to their own, isolated modules and be easily glued back together to form the feature.

* Side effects

How to let certain parts of the application talk to the outside world in the most testable and understandable way possible.

* Testing

How to not only test a feature built in the architecture, but also write integration tests for features that have been composed of many parts, and write end-to-end tests to understand how side effects influence your application. This allows you to make strong guarantees that your business logic is running in the way you expect.

* Ergonomics

How to accomplish all of the above in a simple API with as few concepts and moving parts as possible.


## Data flow
<p float="center">
  <img src="https://github.com/urbansportsgroup-challenges/ios-coding-challenge-rcasanovan/blob/main/Images/TCA_image.001.jpeg"/>
</p>

## Snapshots
<p float="left">
  <img src="https://github.com/urbansportsgroup-challenges/ios-coding-challenge-rcasanovan/blob/main/Images/testLoadActivitiesViewLoadingState.light.png" width="250" />
  <img src="https://github.com/urbansportsgroup-challenges/ios-coding-challenge-rcasanovan/blob/main/Images/testLoadActivitiesViewSuccessState.light.png" width="250" /> 
  <img src="https://github.com/urbansportsgroup-challenges/ios-coding-challenge-rcasanovan/blob/main/Images/testLoadActivitiesViewFailureState.light.png" width="250" />
  <img src="https://github.com/urbansportsgroup-challenges/ios-coding-challenge-rcasanovan/blob/main/Images/testLoadActivitiesViewSuccessStateWithNoGyms.light.png" width="250" />
  <img src="https://github.com/urbansportsgroup-challenges/ios-coding-challenge-rcasanovan/blob/main/Images/testMatchView.light.png" width="250" /> 
</p>


## Requirements included in the demo
- create the UI using SwiftUI
- set the minimum deployment target to iOS 16
- add any dependencies you decide to use with SPM (TCA and snapshot testing)
- fetch data from a remote endpoint ([OpenGym](https://data.townofcary.org/api/explore/v2.1/catalog/datasets/open-gym/records?limit=100))
- cover at least the basic functionality with unit tests
- design the app as a single-screen that displays gym information and user distance, with a swipe-right-to-like matching interface similar to dating apps
- set the match chance to 10% of the interactions and trigger an animation: the app is getting 100 records from the API so you need to do 10 likes before see a match
- additional animations for a dynamic user experience
- more comprehensive tests, including UI tests (snapshot tests)


## Additional tools / technologies
* [Swift-format](https://github.com/apple/swift-format): swift-format provides the formatting technology for SourceKit-LSP and the building blocks for doing code formatting transformations.
