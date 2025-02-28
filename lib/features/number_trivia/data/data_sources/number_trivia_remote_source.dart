import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';

abstract class NumberTriviaRemoteSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

// ignore: constant_identifier_names
const CONCRETE_TRIVIA_API = 'numberapi.com/';
// ignore: constant_identifier_names
const RANDOM_TRIVIA_API = 'numberapi.com/random';

class NumberTriviaRemoteSourceImpl implements NumberTriviaRemoteSource {
  const NumberTriviaRemoteSourceImpl(this.dioClient);
  final Dio dioClient;

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final url = "$CONCRETE_TRIVIA_API$number";
    final Response response = await dioClient.get(url);
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(response.data);
    }
    throw ServerException();
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
