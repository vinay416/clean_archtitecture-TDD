import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivaEntity>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivaEntity>> getRandomNumberTrivia();
}
