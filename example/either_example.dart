import 'package:either_option/src/either.dart';

main() {
  print("--------Example--------");

  Either<String, double> divide(int a, int b) {
    if (b == 0) return Left("Invalid operation");
    return Right(a / b);
  }

  print("--------------------");
  print(divide(2, 0).isLeft);
  print(divide(4, 5).isRight);
  print(divide(4, 5).isLeft);

  final res0 = divide(5, 0);
  final res1 = divide(5, 3);

  print("--------PROCEDURAL STYLE ------------");
  if (res0.isLeft) {
    print(res0.left.value);
  } else {
    print(res0.right.value);
  }
  print("--------FUNCTIONNAL STYLE------------");

  print(res0.fold((l) => l, (r) => "Result is $r"));
  print(res1.fold((l) => l, (r) => "Result is $r"));

  print("----------COMPOSE RESULT-------------");
  print(res0.left.map((left) => 0));
  print(res0.left.flatMap((left) => divide(0, 5)));

  print("----------PROJECTION----------");
  print("Left => ${res0.left.value}");
  // print("Right => ${res1.left.value}"); // throw execption

  print("-----SWAP------");
  final Either<String, int> l = Left("left");
  final Either<int, String> r = l.swap(); // Result: Right("left")
  print(l);
  print(r);
  final Either<String, int> a = Left("flower");
  final Either<String, int> b = Right(12);
  print(a.left.map((_) => _.length)); // Either<int, int> // Left(6)

  print(b.left.map((_) => _.length)); // Either<int, int> // Right(12)
  print(a.right
      .map((_) => _.toDouble())); // Either<String, Double> // Left("flower")
  print(b.right.map((_) => (_))); // Either<String, Double> // Right(12.0)
}
