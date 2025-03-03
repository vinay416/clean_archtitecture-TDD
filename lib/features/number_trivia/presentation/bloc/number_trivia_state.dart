part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}

final class NumberTriviaEmptyState extends NumberTriviaState {}

final class NumberTriviaLoadingState extends NumberTriviaState {}

final class NumberTriviaDataState extends NumberTriviaState {
  const NumberTriviaDataState(this.numberTriva);
  final NumberTrivaEntity numberTriva;

  @override
  List<Object> get props => [numberTriva];
}

final class NumberTriviaErrorState extends NumberTriviaState {
  const NumberTriviaErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
