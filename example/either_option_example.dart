import 'package:either_option/src/either.dart';

import 'model/server_error.dart';
import 'model/user.dart';
import 'utils/repository.dart';

// You can combine all functions defined in src/either.dart and src/option.dart
// Same concept with Option
main() async {
  print("------Simple Example---------");
  final Repository repository = Repository();

  final eitherUser = await repository.getUser(3);
  print(eitherUser); // Right(User(3,User 3))
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
}
