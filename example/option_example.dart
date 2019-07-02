import 'package:either_option/src/option.dart';

main() {
  print("--------Example--------");

  Option<double> divide(int a, int b) {
    if (b == 0) return None();
    return Some(a / b);
  }

  print("--------------------");
  print(divide(2, 0).isEmpty);
  print(divide(4, 5).isDefined);
  print(divide(4, 5).isEmpty);
  print("--------------------");
  print(divide(2, 0));
  print(divide(4, 5));
  print(divide(4, 5));
  print(Option.empty());
  print(Option.of(4));

  print("---getOrElse---");
  final n = Option.empty();
  final s = Option.of("Hello");
  print(n);
  print(s);
  print(n.getOrElse(10));
  print(s.getOrElse("oups"));

  print("-----orElse-----");
  final nr = Option.empty();
  final sr = Option.of("Hello");
  print(nr);
  print(sr);
  print(nr.orElse(Some("oups")));
  print(sr.orElse(Some("oups")));

  print("----toEither----");

  print(nr.toEither("error"));
  print(sr.toEither("error"));
}
