import 'dart:async';

import 'package:clean_architecture/core/parsing/number_trivia_parsing.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concerete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

// ignore: constant_identifier_names
const PARSING_ERROR = "Parsing error, expected integer";
// ignore: constant_identifier_names
const CACHED_ERROR = "Cached error";
// ignore: constant_identifier_names
const SERVER_ERROR = "Server error";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concreteNumberTrivia;
  final GetRandomNumberTrivia randomNumberTrivia;
  final NumberTriviaParsing numberTriviaParsing;
  NumberTriviaBloc({
    required this.concreteNumberTrivia,
    required this.randomNumberTrivia,
    required this.numberTriviaParsing,
  }) : super(const NumberTriviaEmptyState()) {
    on<NumberTriviaEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) {
    if (event is ConcreteNumberTriviaEvent) {
      numberTriviaParsing.toInt(event.number).fold(
        (failure) {
          emit(const NumberTriviaErrorState(PARSING_ERROR));
        },
        (number) async {
          final response = await concreteNumberTrivia.call(number);
          response.fold(
            (failure) {},
            (trivia) => emit(NumberTriviaDataState(trivia)),
          );
        },
      );
    }
  }
}
