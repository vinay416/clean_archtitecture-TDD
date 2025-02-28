import 'dart:convert';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalSource {
  Future<NumberTriviaModel> getCachedNumberTrivia();
  Future<bool> cacheNumberTrivia(NumberTriviaModel trivia);
}

// ignore: constant_identifier_names
const NUMBER_TRIVIA_PREFS_KEY = "cachedTrivia";

class NumberTriviaLocalSourceImpl implements NumberTriviaLocalSource {
  const NumberTriviaLocalSourceImpl(this.preferences);
  final SharedPreferences preferences;

  @override
  Future<bool> cacheNumberTrivia(NumberTriviaModel trivia) {
    // TODO: implement cacheNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getCachedNumberTrivia() async {
    final triviaString = preferences.getString(NUMBER_TRIVIA_PREFS_KEY);
    if (triviaString == null) throw CacheException();
    return NumberTriviaModel.fromJson(jsonDecode(triviaString));
  }
}
