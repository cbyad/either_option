import 'package:either_option/src/either.dart';

///Simple Option monad implementation
abstract class Option<A> {
  /// Return [None] Option
  static Option<A> empty<A>() => _none();

  /// Return [None] if null else [Some] of A
  static Option<A> of<A>(A? a) => a != null ? _some(a) : _none();

  /// Applies [onNone] if this is a [None] or [onSome] if this is a [Some] of A
  Z fold<Z>(Z Function() onNone, Z Function(A a) onSome);

  /// True if Some of A else false
  bool get isDefined => fold(() => false, (_) => true);

  /// True if None else false
  bool get isEmpty => !isDefined;

  /// Return [a] inside [Some] else  supplied [caseElse] if None
  A getOrElse(A caseElse) => fold(() => caseElse, (A a) => a);

  /// Return inchanged Option if [Some] else supplied [caseElse] if None
  Option<A> orElse(Option<A> caseElse) =>
      fold(() => caseElse, (A a) => this); // or  (A a) => some(a)

  /// Return Some of Application of [f] on [a] inside [Some] if [isDefined] else None
  Option<Z> map<Z>(Z Function(A a) f) => fold(_none, (A a) => _some(f(a)));

  /// Return Application of [f] on [a] inside [Some] if [isDefined] else `None`
  Option<Z> flatMap<Z>(Option<Z> Function(A a) f) => fold(_none, (A a) => f(a));

  /// Return current [Option] if it's nonempty and [predicate] application return true. Otherwise return [None]
  Option<A> filter(bool Function(A a) predicate) =>
      (this.isEmpty || predicate((this as Some).value)) ? this : _none();

  /// Return [true] if this Option is a Some and value inside equal [candidate]
  bool contains(A candidate) => isDefined && Some(candidate) == this;

  /// Return [true] if this option is nonempty and the predicate returns true Otherwise return [false]
  bool exists(bool Function(A a) predicate) =>
      (this.isDefined && predicate((this as Some).value)) ? true : false;

  /// If the condition is satify then return [value] in [Some] else None
  static Option<A> cond<A>(bool test, A value) =>
      test ? Option.of(value) : _none();

  /// Return [Left] from Option
  Either<A, A> toLeft(A caseNone) =>
      fold(() => Left(caseNone), (A a) => Left(a));

  /// Return [Right] from Option
  Either<A, A> toRight(A caseNone) =>
      fold(() => Right(caseNone), (A a) => Right(a));

  /// Consider that None is a [Left](something) and [Some](a) is a Right(a)
  Either<L, A> toEither<L>(L leftValue) =>
      fold(() => Left<L, A>(leftValue), (A a) => Right<L, A>(a));

  @override
  String toString() =>
      fold(() => "None", (A a) => a is String ? "Some('$a')" : "Some($a)");
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

Option<A> _some<A>(A a) => Some(a);
Option<A> _none<A>() => None();
