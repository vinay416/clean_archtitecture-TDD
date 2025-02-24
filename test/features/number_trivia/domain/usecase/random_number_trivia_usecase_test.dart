import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/number_trivia_repository.mocks.dart';

void main() {
  late GetRandomNumberTrivia usecase;
  late MockBaseNumberTriviaRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockRepo);
  });

  const excepted = NumberTrivaEntity(text: "12", number: 12);

  test(
    'GetRandomNumberTrivia',
    () async {
      when(mockRepo.getRandomNumberTrivia()).thenAnswer(
        (_) async => const Right(excepted)
      );

      final result = await usecase.execute();
      expect(result, const Right(excepted));
      // Verify that the method has been called on the Repository
      verify(mockRepo.getRandomNumberTrivia());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
