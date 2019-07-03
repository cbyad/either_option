# either_option

__either_option__ is a simple library typed for easy and safe error handling with functional programming style in Dart.
It aims to allow flutter/dart developpers to use the 2 most popular patterns and abstractions : 
`Either` and `Option`, mainly used in FP language like Scala, Haskell, OCaml,...

# Installation
In your pubspec.yaml dependencies add  

        either_option: ^1.0.0

# Example
Uncomment lines in files [repository.dart](example/utils/repository.dart) and [either_option_example.dart](example/either_option_example.dart). I did this to don't add unecessary [http](https://pub.dev/packages/http) dependencies just for 1 example.

* [Either & Option](example/either_option_example.dart)

# Tests
* [Either](test/either_test.dart)
* [Option](test/option_test.dart)