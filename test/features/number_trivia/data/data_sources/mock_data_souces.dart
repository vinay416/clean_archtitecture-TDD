import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_local_source.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([TestNetworkInfo])
class TestNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([TestNumberTriviaLocalSource])
class TestNumberTriviaLocalSource extends Mock
    implements NumberTriviaLocalSource {}

@GenerateMocks([TestNumberTriviaRemoteSource])
class TestNumberTriviaRemoteSource extends Mock
    implements NumberTriviaRemoteSource {}
