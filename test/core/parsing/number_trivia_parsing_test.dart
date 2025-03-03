import 'package:clean_architecture/core/parsing/number_trivia_parsing.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Number trivia parsing",
    () {
      test(
        "Number trivia parsing when successful",
        () {
          final result = NumberTriviaParsingImpl().toInt("1");
          expect(result, const Right(1));
        },
      );
    },
  );
  ;
}
