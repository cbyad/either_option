class ServerError {
  final String message;
  ServerError(this.message);
  @override
  String toString() => "ServerError($message)";
}
