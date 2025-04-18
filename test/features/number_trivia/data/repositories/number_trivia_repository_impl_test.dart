import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_data_souces.mocks.dart';

void main() {
  final mockNetworkInfo = MockTestNetworkInfo();
  final mockLocalDataSource = MockTestNumberTriviaLocalSource();
  final mockRemoteDataSource = MockTestNumberTriviaRemoteSource();
  final triviaRepoImpl = NumberTriviaRepositoryImpl(
    networkInfo: mockNetworkInfo,
    localDataSource: mockLocalDataSource,
    remoteDataSource: mockRemoteDataSource,
  );

  group(
    "Network Connected Test",
    () {
      setUp(
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        },
      );
      const tNumber = 1;
      test(
        "getConcreteNumberTrivia",
        () {
          triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockNetworkInfo.isConnected());
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );

      test(
        "getRandomNumberTrivia",
        () {
          triviaRepoImpl.getRandomNumberTrivia();
          verify(mockNetworkInfo.isConnected());
          verifyNoMoreInteractions(mockNetworkInfo);
        },
      );
    },
  );

  group(
    "getConcreteNumberTrivia Remote Data Source Test when Device online",
    () {
      setUp(
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        },
      );
      const tNumber = 1;
      const triviaData =
          NumberTriviaModel(text: "Test trivia", number: tNumber);
      test(
        "Device is online and API call success",
        () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenAnswer((_) => Future.value(triviaData));
          final result = await triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, const Right(triviaData));
        },
      );

      test(
        "Device is online and API call failed throw Server Eception",
        () async {
          when(mockRemoteDataSource.getConcreteNumberTrivia(any))
              .thenThrow((_) => (ServerException()));
          final result = await triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );

  group(
    "getRandomNumberTrivia Remote Data Source Test when Device online",
    () {
      setUp(
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
        },
      );
      const tNumber = 1;
      const triviaData =
          NumberTriviaModel(text: "Test trivia", number: tNumber);
      test(
        "Device is online and API call success",
        () async {
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenAnswer((_) => Future.value(triviaData));
          final result = await triviaRepoImpl.getRandomNumberTrivia();
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, const Right(triviaData));
        },
      );

      test(
        "Device is online and API call failed throw Server Eception",
        () async {
          when(mockRemoteDataSource.getRandomNumberTrivia())
              .thenThrow((_) => (ServerException()));
          final result = await triviaRepoImpl.getRandomNumberTrivia();
          verify(mockRemoteDataSource.getRandomNumberTrivia());
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );

  group(
    "getConcreteNumberTrivia Local Data Source when device offline Test",
    () {
      const tNumber = 1;
      const triviaData =
          NumberTriviaModel(text: "Test trivia", number: tNumber);

      setUp(
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
          reset(mockRemoteDataSource);
        },
      );

      test(
        "Device is offline, get Local data Success",
        () async {
          when(mockLocalDataSource.getCachedNumberTrivia())
              .thenAnswer((_) => Future.value(triviaData));
          final result = await triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockLocalDataSource.getCachedNumberTrivia());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, const Right(triviaData));
        },
      );

      test(
        "Device is offline, get Local data failed throw Exception",
        () async {
          when(mockLocalDataSource.getCachedNumberTrivia())
              .thenThrow((_) => CacheException());
          final result = await triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockLocalDataSource.getCachedNumberTrivia());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, Left(CacheFailure()));
        },
      );
    },
  );

  group(
    "getRandomNumberTrivia Local Data Source when device offline Test",
    () {
      const tNumber = 1;
      const triviaData =
          NumberTriviaModel(text: "Test trivia", number: tNumber);

      setUp(
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
          reset(mockRemoteDataSource);
        },
      );

      test(
        "Device is offline, get Local data Success",
        () async {
          when(mockLocalDataSource.getCachedNumberTrivia())
              .thenAnswer((_) => Future.value(triviaData));
          final result = await triviaRepoImpl.getRandomNumberTrivia();
          verify(mockLocalDataSource.getCachedNumberTrivia());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, const Right(triviaData));
        },
      );

      test(
        "Device is offline, get Local data failed throw Exception",
        () async {
          when(mockLocalDataSource.getCachedNumberTrivia())
              .thenThrow((_) => CacheException());
          final result = await triviaRepoImpl.getRandomNumberTrivia();
          verify(mockLocalDataSource.getCachedNumberTrivia());
          verifyZeroInteractions(mockRemoteDataSource);
          expect(result, Left(CacheFailure()));
        },
      );
    },
  );
}
