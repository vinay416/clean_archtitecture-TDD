import 'package:clean_architecture/core/parsing/number_trivia_parsing.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concerete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GetConcreteNumberTriviaUsecase])
class GetConcreteNumberTriviaUsecase extends Mock
    implements GetConcreteNumberTrivia {}

@GenerateMocks([GetRandomNumberTriviaUsecase])
class GetRandomNumberTriviaUsecase extends Mock
    implements GetRandomNumberTrivia {}

@GenerateMocks([TriviaParsing])
class TriviaParsing extends Mock implements NumberTriviaParsing {}
