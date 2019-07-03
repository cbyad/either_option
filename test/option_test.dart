import 'package:either_option/src/either.dart';
import 'package:either_option/src/option.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Option<double> safeDivision(int a, int b) {
    if (b == 0) return None();
    return Some(a / b);
  }

  group('Test Option implementation', () {
    test('Basic option state', () {
      final a = safeDivision(2, 0);
      final b = safeDivision(4, 2);

      expect(a, None());
      expect(b, Some(4 / 2));

      expect(a.isEmpty, true);
      expect(a.isDefined, false);
      expect(b.isEmpty, false);
      expect(b.isDefined, true);
    });

    test('Static function utils', () {
      final a = Option.empty();
      final b = Option.of("either_option");
      final c = Option.of(null);
      final d = Some("either_option");

      expect(a, None());
      expect(b, Some("either_option"));
      expect(c, None());
      expect(a == c, true);
      expect(b == d, true);
    });

    test('All useful functions ', () {
      final a = safeDivision(2, 0);
      final b = safeDivision(4, 2);

      // fold
      expect(a.fold(() => "ko", (_) => "ok"), "ko");
      expect(b.fold(() => "ko", (_) => "ok"), "ok");
      // getorElse
      expect(a.getOrElse(0), 0);
      expect(b.getOrElse(0), 2);
      // orElse
      expect(a.orElse(Some(0)), Some(0));
      expect(b.orElse(Some(0)), Some(2));
      //map
      double triple(double val) => val * 3;
      expect(a.map(triple), None());
      expect(b.map(triple), Some(6));
      // flatMap
      Option<double> tripleOpt(double val) => Some(val * 3);
      expect(a.flatMap(tripleOpt), None());
      expect(b.flatMap(tripleOpt), Some(6));
      // toLeft
      expect(a.toLeft(0), Left(0));
      expect(b.toLeft(0), Left(2));
      //toRight
      expect(a.toRight(0), Right(0));
      expect(b.toRight(0), Right(2));
      //toEither
      expect(a.toEither(0), Left(0));
      expect(b.toEither(0), Right(2));
    });
  });
}
