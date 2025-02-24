import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository repo;
  GetRandomNumberTrivia(this.repo);

  Future<Either<Failure, NumberTrivaEntity>> call () async {
    return await repo.getRandomNumberTrivia();
  }
}
