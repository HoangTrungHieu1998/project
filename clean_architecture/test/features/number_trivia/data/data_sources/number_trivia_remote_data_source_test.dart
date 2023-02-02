import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  late MockClient mockClient;

  setUp((){
    mockClient = MockClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(
      client: mockClient
    );
  });

  group('getConcreteNumberTrivia', (){
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a url with number
       being the endpoint and with application/json header''',
      ()async{
        //arrange
        when(mockClient.get(any,headers: anyNamed('headers')))
            .thenAnswer((realInvocation) async => http.Response(fixture('trivia.json'),200));
        //act
        dataSourceImpl.getConcreteNumberTrivia(tNumber);

        //assert
        verify(mockClient.get(
            Uri.parse('http://numbersapi.com/$tNumber'),
          headers: {
              'Content-Type':'application/json'
          }
        ));
    });

    test(
        'should return NumberTrivia when the response code is 200 (success)',
            ()async{
          //arrange
          when(mockClient.get(any,headers: anyNamed('headers')))
              .thenAnswer((realInvocation) async => http.Response(fixture('trivia.json'),200));
          //act
          final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);

          //assert
          expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
            ()async{
          //arrange
          when(mockClient.get(any,headers: anyNamed('headers')))
              .thenAnswer((realInvocation) async => http.Response('Something went wrong',404));
          //act
          final result = dataSourceImpl.getConcreteNumberTrivia;

          //assert
          expect(()=>result(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a url with number
       being the endpoint and with application/json header''',
      ()async{
        //arrange
        when(mockClient.get(any,headers: anyNamed('headers')))
            .thenAnswer((realInvocation) async => http.Response(fixture('trivia.json'),200));
        //act
        dataSourceImpl.getRandomNumberTrivia();

        //assert
        verify(mockClient.get(
            Uri.parse('http://numbersapi.com/random'),
          headers: {
              'Content-Type':'application/json'
          }
        ));
    });

    test(
        'should return NumberTrivia when the response code is 200 (success)',
            ()async{
          //arrange
          when(mockClient.get(any,headers: anyNamed('headers')))
              .thenAnswer((realInvocation) async => http.Response(fixture('trivia.json'),200));
          //act
          final result = await dataSourceImpl.getRandomNumberTrivia();

          //assert
          expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
            ()async{
          //arrange
          when(mockClient.get(any,headers: anyNamed('headers')))
              .thenAnswer((realInvocation) async => http.Response('Something went wrong',404));
          //act
          final result = dataSourceImpl.getRandomNumberTrivia;

          //assert
          expect(()=>result(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}