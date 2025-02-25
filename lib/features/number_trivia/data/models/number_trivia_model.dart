import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';

class NumberTriviaModel extends NumberTrivaEntity {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });
}
