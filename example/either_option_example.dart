import 'package:either_option/src/option.dart';

import 'model/server_error.dart';
import 'model/user.dart';
import 'utils/repository.dart';

// You can combine all functions defined in src/either.dart and src/option.dart
main() async {
  final Repository repository = Repository();
  print("------Either Example---------");
  final eitherUser = await repository.getUser(3);
  print(eitherUser); // Right(User(3,User 3,Password3))
  if (eitherUser.isRight) {
    final User user = eitherUser.right.value;
    print("Id : ${user.id}");
    print("UserName : ${user.username}");
    print("Pass : ${user.password}");
  }

  final notFoundUser = await repository.getUser(200);
  print(notFoundUser); //Left(ServerError(This user doesn't exist))
  if (notFoundUser.isLeft) {
    final ServerError error = notFoundUser.left.value;
    print(error.message);
  }
  print("-------------------------------");

  print("---------Option Example---------");
  final mayBeUser = await repository.getUserOpt(3);
  final user = mayBeUser.getOrElse(User(id: 0, username: "", password: ""));
  print(user); // User(3,User 3,Password3)

  final maybeUser2 = await repository.getUserOpt(345);
  final userNone =
      maybeUser2.getOrElse(User(id: 0, username: "ko", password: "ko"));
  print(userNone); // User(0,ko,ko)
  print("-------------------------------");

  print("---------Option Example 2---------");
  String f(A a) => a.toString();
  final some = Option.of(B());
  print(some.map((s) => f(s)));
  print("-------------------------------");
}

class A {
  @override
  String toString() => "Im a A";
}

class B extends A {
  @override
  String toString() => "Im a B";
}
