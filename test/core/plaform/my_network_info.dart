import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([MyNetworkInfo])
class MyNetworkInfo extends Mock implements InternetConnectionChecker {}
