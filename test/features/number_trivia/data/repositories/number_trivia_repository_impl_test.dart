import 'package:clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../data_sources/mock_data_souces.mocks.dart';

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
    "mockNetworkInfo Test",
    () {
      const tNumber = 1;
      test(
        "Network Connected",
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
          triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockNetworkInfo.isConnected());
        },
      );
    },
  );

  group(
    "NumberTriviaRepositoryImpl Test",
    () {
      const tNumber = 1;
      test(
        "Network Connected",
        () {
          when(mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
          triviaRepoImpl.getConcreteNumberTrivia(tNumber);
          verify(mockNetworkInfo.isConnected());
        },
      );
    },
  );
}
