import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalSource {
  Future<NumberTriviaModel> getCachedNumberTrivia();
  Future<bool> cacheNumberTrivia(NumberTriviaModel trivia);
}
