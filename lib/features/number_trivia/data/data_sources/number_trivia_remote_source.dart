import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';

abstract class NumberTriviaRemoteSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

// ignore: constant_identifier_names
const CONCRETE_TRIVIA_API = 'numberapi.com/';

class NumberTriviaRemoteSourceImpl implements NumberTriviaRemoteSource{
  const NumberTriviaRemoteSourceImpl(this.dioClient);
  final Dio dioClient;
  
  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async{
    final url = "$CONCRETE_TRIVIA_API$number";
    final Response response = await dioClient.get(url);
    return NumberTriviaModel.fromJson(response.data);
    throw UnimplementedError();
  }
  
  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

}