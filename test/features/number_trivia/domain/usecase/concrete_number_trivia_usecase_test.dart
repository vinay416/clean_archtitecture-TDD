import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concerete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/number_trivia_repository.mocks.dart';

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockBaseNumberTriviaRepository mockRepo;

  setUp(() {
    mockRepo = MockBaseNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockRepo);
  });

  const excepted = NumberTrivaEntity(text: "1", number: 1);
  const int tNumber = 1;

  test(
    'GetConcereteNumberTrivia',
    () async {
      when(mockRepo.getConcreteNumberTrivia(any)).thenAnswer(
        (_) async => const Right(excepted)
      );

      final result = await usecase(tNumber);
      expect(result, const Right(excepted));
      // Verify that the method has been called on the Repository
      verify(mockRepo.getConcreteNumberTrivia(tNumber));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRepo);
    },
  );
}
