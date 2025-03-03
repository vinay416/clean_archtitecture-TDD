import 'package:clean_architecture/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaParsing {
  Either<Failure, int> toInt(String number);
}

class NumberTriviaParsingImpl implements NumberTriviaParsing {
  @override
  Either<Failure, int> toInt(String number) {
    try {
      final intNumber = int.parse(number);
      return Right(intNumber);
    } catch (e) {
      
    }
    throw UnimplementedError();
  }
}
