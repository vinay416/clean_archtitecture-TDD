import 'dart:convert';
import 'dart:math';

import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixtures.dart';

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

      test(
        "Trivia model from json",
        () {
          final stringTrivia = Fixtures().call("trivia.json");
          final Map<String, dynamic> decoded = jsonDecode(stringTrivia);
          final trivia = NumberTriviaModel.fromJson(decoded);
          expect(trivia, testTrivia);
        },
      );

      test(
        "Trivia model from json with double value",
        () {
          final stringTrivia = Fixtures().call("trivia_double.json");
          final Map<String, dynamic> decoded = jsonDecode(stringTrivia);
          final trivia = NumberTriviaModel.fromJson(decoded);
          expect(trivia, testTrivia);
        },
      );

      test(
        "Trivia model to Map",
        () {
          final triviaMap = testTrivia.toMap();
          final expected = {
            "text": "Test Trivia 1",
            "number": 1,
          };
          expect(triviaMap, expected);
        },
      );
    },
  );
}
