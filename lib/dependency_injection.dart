import 'dart:io';

import 'package:clean_architecture/core/parsing/number_trivia_parsing.dart';
import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_local_source.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_source.dart';
import 'package:clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concerete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> injectDependencies() async {
  di.registerFactory<NumberTriviaBloc>(
    () => NumberTriviaBloc(
      concreteNumberTrivia: di(),
      randomNumberTrivia: di(),
      numberTriviaParsing: di(),
    ),
  );

  di.registerLazySingleton<GetConcreteNumberTrivia>(
    () => GetConcreteNumberTrivia(di()),
  );
  di.registerLazySingleton<GetRandomNumberTrivia>(
    () => GetRandomNumberTrivia(di()),
  );
  di.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: di(),
      remoteDataSource: di(),
      networkInfo: di(),
    ),
  );
  di.registerLazySingleton<NumberTriviaLocalSource>(
    () => NumberTriviaLocalSourceImpl(di()),
  );
  di.registerLazySingleton<NumberTriviaRemoteSource>(
    () => NumberTriviaRemoteSourceImpl(di()),
  );

  //** CORE
  di.registerLazySingleton<NumberTriviaParsing>(
    () => NumberTriviaParsingImpl(),
  );
  di.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(di()),
  );

  //** EXTERNAL
  final prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => prefs);
  di.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(contentType: ContentType.json.value),
    ),
  );
  di.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
}
