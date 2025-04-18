import 'dart:async';

import 'package:clean_architecture/core/errors/failure.dart';
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
  ) async {
    if (event is ConcreteNumberTriviaEvent) {
      await _onConcreteTriviaEvent(event, emit);
    }
    if (event is RandomNumberTriviaEvent) {
      await _onRandomTriviaEvent(event, emit);
    }
  }

  Future<void> _onConcreteTriviaEvent(
    ConcreteNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    final errorOrNumber = numberTriviaParsing.toInt(event.number).fold(
          (failure) => NumberTriviaErrorState(_errorMsg(failure)),
          (number) => number,
        );
    if (errorOrNumber is NumberTriviaErrorState) {
      emit(errorOrNumber);
      return;
    }
    final number = errorOrNumber as int;
    emit(NumberTriviaLoadingState());
    final response = await concreteNumberTrivia.call(number);
    response.fold(
      (failure) => emit(NumberTriviaErrorState(_errorMsg(failure))),
      (trivia) => emit(NumberTriviaDataState(trivia)),
    );
  }

  Future<void> _onRandomTriviaEvent(
    RandomNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());
    final response = await randomNumberTrivia.call();
    final state = response.fold(
      (failure) => NumberTriviaErrorState(_errorMsg(failure)),
      (trivia) => NumberTriviaDataState(trivia),
    );
    emit(state);
  }

  String _errorMsg(Failure failure) {
    final error = switch (failure.runtimeType) {
      const (ServerFailure) => SERVER_ERROR,
      const (CacheFailure) => CACHED_ERROR,
      const (ParsingFailure) => PARSING_ERROR,
      Type() => "Undefined error",
    };
    return error;
  }
}
