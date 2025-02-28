import 'dart:convert';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_local_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixtures.dart';
import 'mock_shared_prefes.mocks.dart';

void main() {
  final mockPrefes = MockMySharedPrefrences();
  final localSource = NumberTriviaLocalSourceImpl(mockPrefes);

  final triviaMapString = Fixtures().call("trivia_prefs.json");
  final trivia = NumberTriviaModel.fromJson(jsonDecode(triviaMapString));

  group(
    "Local Data source Impl",
    () {
      test(
        "Get Trivia - When we have the cached trivia",
        () async {
          when(mockPrefes.getString(any)).thenReturn(triviaMapString);

          final result = await localSource.getCachedNumberTrivia();
          verify(mockPrefes.getString(NUMBER_TRIVIA_PREFS_KEY));
          expect(result, trivia);
        },
      );

      test(
        "Get Trivia - no cached trivia",
        () async {
          when(mockPrefes.getString(any)).thenThrow(CacheException());

          final result = await localSource.getCachedNumberTrivia();
          verify(mockPrefes.getString(NUMBER_TRIVIA_PREFS_KEY));
          expect(result, CacheException());
        },
      );
    },
  );
}
