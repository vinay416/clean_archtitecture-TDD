import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_local_source.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_source.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  const NumberTriviaRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });
  final NetworkInfo networkInfo;
  final NumberTriviaLocalSource localDataSource;
  final NumberTriviaRemoteSource remoteDataSource;

  @override
  Future<Either<Failure, NumberTrivaEntity>> getConcreteNumberTrivia(
    int number,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        final trivia = await remoteDataSource.getConcreteNumberTrivia(number);
        return Right(trivia);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getCachedNumberTrivia();
        return Right(localTrivia);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivaEntity>> getRandomNumberTrivia() async {
    networkInfo.isConnected();
    try {
      final trivia = await remoteDataSource.getRandomNumberTrivia();
      return Right(trivia);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
