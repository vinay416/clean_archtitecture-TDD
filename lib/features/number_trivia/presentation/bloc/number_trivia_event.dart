part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

final class ConcreteNumberTriviaEvent extends NumberTriviaEvent {
  const ConcreteNumberTriviaEvent(this.number);
  final String number;

  @override
  List<Object> get props => [number];
}

final class RandomNumberTriviaEvent extends NumberTriviaEvent {
  const RandomNumberTriviaEvent();
}
