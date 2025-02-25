import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testTrivia = NumberTriviaModel(text: "Test Trivia 1", number: 1);
  group(
    "Number trivia model",
    () {
      test(
        "Is a subtype of entity",
        () {
          expect(testTrivia, isA<NumberTrivaEntity>());
        },
      );
    },
  );
}
