# either_option

__either_option__ is a simple library typed for easy and safe error handling with functional programming style in Dart.
It aims to allow flutter/dart developpers to use the 2 most popular patterns and abstractions : 
`Either` and `Option`, mainly used in FP language like Scala, Haskell, OCaml,...

# Installation
Package link on pub [either_option](https://pub.dev/packages/either_option)
In your pubspec.yaml dependencies add  

        either_option: ^1.0.1

# Overview
`Either` Represents a value of one of two possible types.
By convention we put missing or error value in an instance of `Left` and expected success value in an instance of `Right`.

For example, we fetch an url from a [repository](example/utils/repository.dart) to get an *User* details and use `Either<ServerError,User>` :

```scala
  Future<Either<ServerError, User>> getUser(int id) async {
    final baseUrl = "https://fakerestapi.azurewebsites.net/api/Users/$id";

    final res = await http.get(baseUrl);

    if (res.statusCode == 200) {
      dynamic body = json.decode(res.body);
      User user = User.fromJson(body);
      return Right(user);
    }
    if (res.statusCode == 404)
      return Left(ServerError("This user doesn't exist"));

    return Left(ServerError("Unknown server error"));
  }
```
So now to consume result we can use for example `fold` method and say what to do with value :

```scala
main() async {
  final Repository repository = Repository();

  final Either<ServerError, User> res = await repository.getUser(3);
  final defaultUser = User(id: 0, username: "ko", password: "ko");
  final userName = res.fold((_) => defaultUser.username, (user) => user.id);
  print(userName); // "User 3"
  
//if res was a Left, print(userName) would give "ko"
}
```
`Option` Represents a value of one of two possible types.
By convention we consider missing value as an instance of `None` and expected success value in an instance of `Some`.

# Features
Functions available :

|              | Option    | Either|
| ------------ |:---------:| -----:|
| fold         |   :+1:    |    :+1:    |
| map          |     :+1:  |   :+1:     |
| flatMap      |     :+1:  |    :+1:    |
| getOrElse    |     :+1:  |       |
| orElse       |      :+1:      |       |
| toLeft       |     :+1:       |       |
| toRight      |     :+1:       |       |
| toEither     |     :+1:       |       |
| Option.empty |     :+1:       |       |
| Option.of    |     :+1:       |       |
| swap         |                |   :+1:|



# Example
* [Either & Option](example/either_option_example.dart)

# Tests
* [Either](test/either_test.dart)
* [Option](test/option_test.dart)