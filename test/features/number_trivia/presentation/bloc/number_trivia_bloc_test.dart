import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock/mock_number_trivia_usecase.mocks.dart';

void main() {
  final mockConcreteUsecase = MockGetConcreteNumberTriviaUsecase();
  final mockRandomUsecase = MockGetRandomNumberTriviaUsecase();
  final mockTriviaParsing = MockTriviaParsing();

  final bloc = NumberTriviaBloc(
    concreteNumberTrivia: mockConcreteUsecase,
    randomNumberTrivia: mockRandomUsecase,
    numberTriviaParsing: mockTriviaParsing,
  );
  const tNumberString = "1";
  const tNumber = 1;
  const trivia = NumberTrivaEntity(text: "Test trivia", number: 1);

  group(
    "NumberTriviaBloc Test",
    () {
      test(
        "Initial State",
        () {
          expect(bloc.state, const NumberTriviaEmptyState());
        },
      );

      test(
        "When parsing failed -> NumberTriviaErrorState",
        () async {
          when(mockTriviaParsing.toInt(any)).thenReturn(Left(ParsingFailure()));

          bloc.add(const ConcreteNumberTriviaEvent(tNumberString));
          await untilCalled(mockTriviaParsing.toInt(tNumberString));

          expectLater(bloc.state, const NumberTriviaErrorState(PARSING_ERROR));
          verify(mockTriviaParsing.toInt(tNumberString));
        },
      );
    },
  );
}
