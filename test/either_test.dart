import 'package:either_option/src/either.dart';
import 'package:test/test.dart';

void main() {
  final message = "Invalid operation";
  Either<String, double> safeDivision(int a, int b) {
    if (b == 0) return Left(message);
    return Right(a / b);
  }

  group('Test Either implementation', () {
    test('Basic Either state', () {
      final a = safeDivision(2, 0);
      final b = safeDivision(4, 2);

      expect(a.isLeft, true);
      expect(b.isRight, true);
      expect(a.isRight, false);
      expect(b.isLeft, false);
    });

    test('All useful functions ', () {
      final a = safeDivision(2, 0);
      final b = safeDivision(4, 2);

      // fold
      expect(a.fold((_) => "ko", (_) => "ok"), "ko");
      expect(b.fold((_) => "ko", (_) => "ok"), "ok");

      // swap
      expect(a.swap(), Right(message));
      expect(b.swap(), Left(2));

      //map on projection
      double triple(double val) => val * 3;
      int onLeft(String msg) => msg.length;

      expect(a.left.map((l) => onLeft(l)), Left(message.length));
      expect(a.right.map((l) => onLeft(l)), Left(message));
      expect(b.right.map((l) => triple(l)), Right(6));
      expect(b.left.map((l) => onLeft(l)), Right(2));

      // flatMap
      onRigthEth(double val) => Right(val * 3);
      onLeftEth(String msg) => Left(msg.length);

      expect(a.left.flatMap((l) => onLeftEth(l)), Left(message.length));
      expect(a.right.flatMap((r) => onRigthEth(r)), Left(message));
      expect(b.right.flatMap((r) => onRigthEth(r)), Right(6));
      expect(b.left.flatMap((l) => onLeftEth(l)), Right(2));
    });
  });
}
