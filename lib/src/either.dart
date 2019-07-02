/**
 * Simple Either monad implementation 
 */
abstract class Either<L, R> {
  /**
   * Projects this Either as a Left.
   */
  LeftProjection get left => LeftProjection(this);

  /**
   * Projects this Either as a Right.
   */
  RightProjection get right => RightProjection(this);

  /**
   * Applies onLeft if this is a Left or onRight if this is a Right
   * ```
   * // Example : Use of [fold]
   * Either<String, double> divide(int a, int b) {
   *    if (b == 0) return Left("Invalid operation");
   *    return Right(a / b);
   *  }
   * 
   * final res0 = divide(5, 0);
   * final res1 = divide(5, 3);
   * res0.fold((l) => l, (r) => "Result is $r"); // Invalid operation
   * res1.fold((l) => l, (r) => "Result is $r") // Result is 1.6666666666666667
   *  ```
   */
  Z fold<Z>(Z Function(L) onLeft, Z Function(R) onRight) {
    if (isLeft) return onLeft((this as Left<L, R>)._value);
    return onRight((this as Right<L, R>)._value);
  }

  /**
   * If this is a Left, then return the left value in Right or vice versa.
   * ```
   * // Example use of [swap]
   * final Either<String, int> l = Left("left");
   * final Either<int, String> r = l.swap(); // Result: Right("left")
   * ```
   * */
  Either<R, L> swap() {
    if (isLeft) return Right<R, L>((this as Left<L, R>)._value);
    return Left<R, L>((this as Right<L, R>)._value);
  }

  /**
   * Returns true if this is a right, false otherwise.
   */
  bool get isRight;

  /**
   * Returns true if this is a Left, false otherwise.
   */
  bool get isLeft;
}

class LeftProjection<L, R> {
  final Either<L, R> _either;
  LeftProjection(this._either);

  /**
   * ``` 
   * // Example : Use of [map]
   * final Either<String, int> a = Left("flower");
   * final Either<String, int> b = Right(12);
   * a.left.map((_) => _.length); // Either<int, int> // Left(6)
   * b.left.map((_) => _.length); // Either<int, int> // Right(12)
   * a.right.map((_) => _.toDouble()); // Either<String, Double> // Left("flower")
   * b.right.map((_) => (_)); // Either<String, Double> // Right(12.0)
  ```
   */
  Either<C, R> map<C, R>(C Function(L) f) {
    if (_either.isLeft) {
      return Left<C, R>(f(this.value));
    }
    return Right<C, R>((_either as Right)._value);
  }

  Either<C, RR> flatMap<C, RR, R extends RR>(Either<C, RR> Function(L) f) {
    if (_either.isLeft) return f(this.value);
    return Right<C, RR>((_either as Right)._value);
  }

  L get value => _either.isLeft
      ? (_either as Left<L, R>)._value
      : throw Exception("NoSuchElement : Either.left.value on Right");
}

class RightProjection<L, R> {
  final Either<L, R> _either;
  RightProjection(this._either);

  Either<L, C> map<L, C>(C Function(R) f) {
    if (_either.isRight) {
      return Right<L, C>(f(this.value));
    }
    return Left<L, C>((_either as Left)._value);
  }

  Either<LL, C> flatMap<C, LL, L extends LL>(Either<LL, C> Function(R) f) {
    if (_either.isLeft) return Left<LL, C>((_either as Left)._value);
    return f(this.value);
  }

  R get value => _either.isLeft
      ? throw Exception("NoSuchElement : Either.right.value on Left")
      : (_either as Right<L, R>)._value;
}

class Left<L, R> extends Either<L, R> {
  final L _value;
  L get value => _value;
  Left(this._value);

  @override
  bool get isRight => false;

  @override
  bool get isLeft => true;
}

class Right<L, R> extends Either<L, R> {
  final R _value;
  R get value => _value;
  Right(this._value);

  @override
  bool get isRight => true;

  @override
  bool get isLeft => false;
}
