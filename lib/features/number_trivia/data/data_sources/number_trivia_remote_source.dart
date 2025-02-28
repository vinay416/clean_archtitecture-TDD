import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';

abstract class NumberTriviaRemoteSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const CONCRETE_TRIVIA_API = 'numberapi.com/';

class NumberTriviaRemoteSourceImpl implements NumberTriviaRemoteSource{
  const NumberTriviaRemoteSourceImpl(this.dioClient);
  final Dio dioClient;
  
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    throw UnimplementedError();
  }
  
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

}