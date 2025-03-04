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

      test(
        "When parsing successful -> NumberTriviaDataState",
        () async {
          when(mockTriviaParsing.toInt(any)).thenReturn(const Right(tNumber));
          when(mockConcreteUsecase.call(any))
              .thenAnswer((_) async => const Right(trivia));

          bloc.add(const ConcreteNumberTriviaEvent(tNumberString));
          await untilCalled(mockTriviaParsing.toInt(tNumberString));
          expect(bloc.state, NumberTriviaLoadingState());
          await untilCalled(mockConcreteUsecase.call(tNumber));

          expectLater(bloc.state, const NumberTriviaDataState(trivia));
          verify(mockTriviaParsing.toInt(tNumberString));
          verify(mockConcreteUsecase.call(tNumber));
        },
      );

      test(
        "When parsing successful but server fails -> NumberTriviaErrorState",
        () async {
          when(mockTriviaParsing.toInt(any)).thenReturn(const Right(tNumber));
          when(mockConcreteUsecase.call(any))
              .thenAnswer((_) async => Left(ServerFailure()));

          bloc.add(const ConcreteNumberTriviaEvent(tNumberString));
          await untilCalled(mockTriviaParsing.toInt(tNumberString));
          expect(bloc.state, NumberTriviaLoadingState());
          await untilCalled(mockConcreteUsecase.call(tNumber));

          expectLater(bloc.state, const NumberTriviaErrorState(SERVER_ERROR));
          verify(mockTriviaParsing.toInt(tNumberString));
          verify(mockConcreteUsecase.call(tNumber));
        },
      );

      test(
        "When parsing successful but Cache fails -> NumberTriviaErrorState",
        () async {
          when(mockTriviaParsing.toInt(any)).thenReturn(const Right(tNumber));
          when(mockConcreteUsecase.call(any))
              .thenAnswer((_) async => Left(CacheFailure()));

          bloc.add(const ConcreteNumberTriviaEvent(tNumberString));
          await untilCalled(mockTriviaParsing.toInt(tNumberString));
          expect(bloc.state, NumberTriviaLoadingState());
          await untilCalled(mockConcreteUsecase.call(tNumber));

          expectLater(bloc.state, const NumberTriviaErrorState(CACHED_ERROR));
          verify(mockTriviaParsing.toInt(tNumberString));
          verify(mockConcreteUsecase.call(tNumber));
        },
      );
    },
  );
}
