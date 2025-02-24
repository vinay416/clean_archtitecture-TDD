import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BaseNumberTriviaRepository])
class BaseNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}
