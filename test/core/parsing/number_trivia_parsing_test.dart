import 'package:clean_architecture/core/errors/failure.dart';
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

      test(
        "Number trivia parsing when error/failed",
        () {
          final result = NumberTriviaParsingImpl().toInt("abc1");
          expect(result,  Right(ParsingFailure()));
        },
      );
    },
  );
  ;
}
