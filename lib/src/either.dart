/// Simple Either monad implementation
abstract class Either<L, R> {
  /// Projects this [Either] as a [Left]
  LeftProjection<L, R> get left => LeftProjection(this);

  /// Projects this [Either] as a [Right]
  RightProjection<L, R> get right => RightProjection(this);

  /// Applies [onLeft] if this is a Left or [onRight] if this is a Right
  Z fold<Z>(Z Function(L) onLeft, Z Function(R) onRight);

  /// If this is a [Left], then return the left value in [Right] or vice versa.
  Either<R, L> swap() => fold((L r) => Right<R, L>((this as Left<L, R>)._value),
      (R r) => Left<R, L>((this as Right<L, R>)._value));

  /// Returns true if this is a right, false otherwise.
  bool get isRight => fold((_) => false, (_) => true);

  /// Returns true if this is a Left, false otherwise.
  bool get isLeft => !isRight;

  /// If the condition is satify then return [rightValue] in [Right] else [leftValue] in [Left]
  static Either<L, R> cond<L, R>(bool test, R rightValue, L leftValue) =>
      test ? Right(rightValue) : Left(leftValue);

  @override
  String toString() => fold((L l) => l is String ? "Left('$l')" : "Left($l)",
      (R r) => r is String ? "Right('$r')" : "Right($r)");
}

class LeftProjection<L, R> {
  final Either<L, R> _either;
  LeftProjection(this._either);

  Either<C, R> map<C, R>(C Function(L) f) => _either.fold(
      (L l) => Left<C, R>(f(this._value)),
      (_) => Right<C, R>((_either as Right)._value));

  Either<C, RR> flatMap<C, RR, R extends RR>(Either<C, RR> Function(L) f) =>
      _either.fold((L l) => f(this._value),
          (_) => Right<C, RR>((_either as Right)._value));

  L get _value => _either.isLeft
      ? (_either as Left<L, R>)._value
      : throw Exception("NoSuchElement : Either.left.value on Right");
}

class RightProjection<L, R> {
  final Either<L, R> _either;
  RightProjection(this._either);

  Either<L, C> map<L, C>(C Function(R) f) => _either.fold(
      (_) => Left<L, C>((_either as Left)._value),
      (R r) => Right<L, C>(f(this._value)));

  Either<LL, C> flatMap<C, LL, L extends LL>(Either<LL, C> Function(R) f) =>
      _either.fold((_) => Left<LL, C>((_either as Left)._value),
          (R r) => f(this._value));

  R get _value => _either.isLeft
      ? throw Exception("NoSuchElement : Either.right.value on Left")
      : (_either as Right<L, R>)._value;
}

class Left<L, R> extends Either<L, R> {
  final L _value;
  L get value => _value;
  Left(this._value);

  @override
  Z fold<Z>(Z Function(L) onLeft, Z Function(R) onRight) => onLeft(_value);

  @override
  bool operator ==(that) => that is Left && that._value == _value;

  @override
  int get hashCode => _value.hashCode;
}

class Right<L, R> extends Either<L, R> {
  final R _value;
  R get value => _value;
  Right(this._value);

  @override
  bool operator ==(that) => that is Right && that._value == _value;

  @override
  int get hashCode => _value.hashCode;

  @override
  Z fold<Z>(Z Function(L l) onLeft, Z Function(R r) onRight) => onRight(_value);
}
