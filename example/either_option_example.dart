import 'package:either_option/src/either.dart';
import 'package:either_option/src/option.dart';

import 'model/server_error.dart';
import 'model/user.dart';
import 'repository_example.dart';

/// You can combine all functions defined in src/either.dart and src/option.dart
main() async {
  final Repository repository = Repository();

  print("------Either Example---------");
  final Either<ServerError, User> res = await repository.getUser(3);
  final defaultUser = User(id: 0, username: "ko", password: "ko");
  final userName = res.fold((_) => defaultUser.username, (user) => user.id);
  print(userName); // "User 3"

  print("---------Option Example---------");
  final maybeUser = await repository.getUserOpt(345);
  final userNone = maybeUser.getOrElse(defaultUser);
  print(userNone); // User(0, ko, ko)

  print("---------Option Example 2---------");
  String f(A a) => a.toString();
  final some = Option.of(B());
  print(some.map((s) => f(s)));
}

class A {
  @override
  String toString() => "Im a A";
}

class B extends A {
  @override
  String toString() => "Im a B";
}
