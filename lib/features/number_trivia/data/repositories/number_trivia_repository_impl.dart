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
  Future<Either<Failure, NumberTrivaEntity>> getConcreteNumberTrivia(int number) {
    networkInfo.isConnected();
    return Future.value(Left(ServerFailure()));
  }

  @override
  Future<Either<Failure, NumberTrivaEntity>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
  
}