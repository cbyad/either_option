import 'package:either_option/either_option.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'model/server_error.dart';
import 'model/user.dart';

class Repository {
  // With Either
  Future<Either<ServerError, User>> getUser(int id) async {
    final baseUrl = "https://fakerestapi.azurewebsites.net/api/Users/$id";

    User user;
    final res = await http.get(baseUrl);

    if (res.statusCode == 200) {
      dynamic body = json.decode(res.body);
      user = User.fromJson(body);
      return Right(user);
    }
    if (res.statusCode == 404)
      return Left(ServerError("This user doesn't exist"));

    return Left(ServerError("unknown server error"));
  }

  // With Option
  Future<Option<User>> getUserOpt(int id) async {
    final baseUrl = "https://fakerestapi.azurewebsites.net/api/Users/$id";

    User user;
    final res = await http.get(baseUrl);

    if (res.statusCode == 200) {
      dynamic body = json.decode(res.body);
      user = User.fromJson(body);
      return Some(user);
    }
    return None();
  }
}
