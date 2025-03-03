import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([properties]);
  final List properties = const <dynamic>[];

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class ParsingFailure extends Failure {}
