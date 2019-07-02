import 'package:either_option/src/either.dart';

/**
 * Simple Option monad implementation 
 */

abstract class Option<A> {
  static Option<A> empty<A>() => none();

  static Option<A> of<A>(A a) => a != null ? some(a) : none();

  Z fold<Z>(Z Function() onNone, Z Function(A a) onSome);

  bool get isDefined => fold(() => false, (_) => true);

  bool get isEmpty => !isDefined;

  A getOrElse(A caseElse) => fold(() => caseElse, (A a) => a);

  Option<A> orElse(Option<A> caseElse) =>
      fold(() => caseElse, (A a) => this); // or  (A a) => some(a)

  Option<Z> map<Z>(Z Function(A a) f) => fold(none, (A a) => some(f(a)));

  Option<Z> flatMap<Z>(Option<Z> Function(A a) f) => fold(none, (A a) => f(a));

  Either<A, A> toLeft(A caseNone) =>
      fold(() => Left(caseNone), (A a) => Left(a));

  Either<A, A> toRight(A caseNone) =>
      fold(() => Right(caseNone), (A a) => Right(a));

  /**
   * Consider that None is a Left(something) and Some(a) is a Right(a)
   */
  Either<L, A> toEither<L>(L leftValue) =>
      fold(() => Left<L, A>(leftValue), (A a) => Right<L, A>(a));

  @override
  String toString() => fold(() => "None", (A a) => "Some($a)");
}

class Some<A> extends Option<A> {
  final A _a;
  Some(this._a);
  A get value => _a;

  @override
  bool operator ==(that) => that is Some && that._a == _a;

  @override
  int get hashCode => _a.hashCode;

  @override
  Z fold<Z>(Z Function() onNone, Z Function(A a) onSome) => onSome(_a);
}

class None<A> extends Option<A> {
  @override
  bool operator ==(that) => that is None;

  @override
  int get hashCode => 0;

  @override
  Z fold<Z>(Z Function() onNone, Z Function(A a) onSome) => onNone();
}

Option<A> some<A>(A a) => Some(a);
Option<A> none<A>() => None();
