import 'dart:convert';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixtures.dart';
import 'my_dio_client.mocks.dart';

void main() {
  final dioMock = MockMyDioClient();
  final remoteSource = NumberTriviaRemoteSourceImpl(dioMock);

  group(
    "Trivia Remote Source Impl",
    () {
      const tNumber = 1;
      final triviaModel = NumberTriviaModel.fromJson(
          jsonDecode(Fixtures().call("trivia.json")));
      test(
        "Get concrete trivia when API success",
        () async {
          const url = "$CONCRETE_TRIVIA_API$tNumber";
          when(dioMock.get(any)).thenAnswer((_) => Future.value(Response(
                data: json.decode(Fixtures().call("trivia.json")),
                statusCode: 200,
                requestOptions: RequestOptions(
                  path: url,
                  contentType: "application/json",
                ),
              )));

          final result = await remoteSource.getConcreteNumberTrivia(tNumber);
          verify(dioMock.get(url));
          expect(result, triviaModel);
        },
      );

      test(
        "Get concrete trivia when API fails, throw Exception",
        () async {
          const url = "$CONCRETE_TRIVIA_API$tNumber";
          when(dioMock.get(any)).thenAnswer((_) => Future.value(Response(
                statusCode: 500,
                requestOptions: RequestOptions(
                  path: url,
                  contentType: "application/json",
                ),
              )));

          final result = remoteSource.getConcreteNumberTrivia(tNumber);
          verify(dioMock.get(url));
          expect(() async => await result, throwsA(const TypeMatcher<ServerException>()));
        },
      );


      test(
        "Get Random trivia when API success",
        () async {
          const url = RANDOM_TRIVIA_API;
          when(dioMock.get(any)).thenAnswer((_) => Future.value(Response(
                data: json.decode(Fixtures().call("trivia.json")),
                statusCode: 200,
                requestOptions: RequestOptions(
                  path: url,
                  contentType: "application/json",
                ),
              )));

          final result = await remoteSource.getRandomNumberTrivia();
          verify(dioMock.get(url));
          expect(result, triviaModel);
        },
      );

      test(
        "Get random trivia when API fails, throw Exception",
        () async {
          const url = RANDOM_TRIVIA_API;
          when(dioMock.get(any)).thenAnswer((_) => Future.value(Response(
                statusCode: 500,
                requestOptions: RequestOptions(
                  path: url,
                  contentType: "application/json",
                ),
              )));

          final result = remoteSource.getRandomNumberTrivia();
          verify(dioMock.get(url));
          expect(result, throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
