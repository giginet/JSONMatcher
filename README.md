JSONMatcher
=================

[![Build Status](https://travis-ci.org/giginet/JSONMatcher.svg?branch=master)](https://travis-ci.org/giginet/JSONMatcher) [![codecov](https://codecov.io/gh/giginet/JSONMatcher/branch/master/graph/badge.svg)](https://codecov.io/gh/giginet/JSONMatcher) ![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20OSX%20%7C%20tvOS-333333.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

This is a JSON matcher library for Swift testing.

It works as extension for [Nimble](https://github.com/Quick/Nimble/).

This library is inspired by [rspec-json_matcher](https://github.com/r7kamura/rspec-json_matcher).

## Usage

### Example

```swift
import XCTest
import Nimble
import JSONMatcher

class ExampleTestCase: XCTestCase { 
    func testComplexExample() {
        expect([
            "name" : "Snorlax",
            "no" : 143,
            "species" : "Sleeping",
            "type" : ["normal"],
            "stats" : [
                "hp" : 160,
                "attack" : 110,
                "defense" : 65,
                "special_attack" : 65,
                "special_defense" : 65,
                "speed" : 30
            ],
            "moves" : [
                ["name" : "Tackle", "type" : "normal", "level" : 1],
                ["name" : "Hyper Beam", "type" : "normal", "level" : NSNull()],
            ]
        ]).to(beJSONAs([
            "name" : "Snorlax",
            "no" : JSONType.Number, // value type matching
            "species" : "[a-zA-Z]+".regex, // regular expression matching
            "type" : ["normal"],
            "stats" : [
                "hp" : 160,
                "attack" : 110,
                "defense" : 65,
                "special_attack" : 65,
                "special_defense" : 65,
                "speed" : 30
            ],
            "moves" : [
                ["name" : "Tackle", "type" : "[a-z]+".regex, "level" : JSONType.Number], // nested collection
                ["name" : "Hyper Beam", "type" : "normal", "level" : NSNull()],
            ]
        ]))
    }
}
```

### Matcher

- beJSON
- beJSONIncluding
- beJSONAs

```swift
expect("{\"name\": \"Pikachu\"}").to(beJSON())
expect(["name" : "Pikachu", "no" : 25]).to(beJSONIncluding(["name" : "Pikachu"]))
expect(["name" : "Pikachu", "no" : 25]).to(beJSONAs(["name": "Pikachu", "no" : 25]))
```

## Requirements

### Dependencies

- Nimble >= 4.0.0

### Supported Platforms

- iOS 8.0 or above
- OSX 10.9 or above
- tvOS 9.0 or above

## Installation

### Carthage

Declare following in your `Cartfile.private`.

```
github "giginet/JSONMatcher"
```

### CocoaPods

Declare following in your `Podfile`.

```ruby
use_frameworks!

target "YourApplicationTests" do
  pod 'JSONMatcher'
end
```

## Author

giginet <<giginet.net@gmail.com>>

## License

MIT License
