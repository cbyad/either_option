class User {
  final int id;
  final String username;
  final String password;

  User({required this.id, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['ID'], username: json['UserName'], password: json['Password']);
  }

  @override
  String toString() => "User($id, $username, $password)";
}
