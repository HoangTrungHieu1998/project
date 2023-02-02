import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main(){
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSourceImpl;

  setUp((){
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences
    );
  });

  group('getLastNumberTrivia', (){
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cache.json')));

    test('should return NumberTrivia from SharePreferences when there is one in the cache', ()async{
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cache.json'));
      //act
      final result = await dataSourceImpl.getLastNumberTrivia();

      //assert
      verify(mockSharedPreferences.getString(CACHE_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a CacheException when there is not a cache value', ()async{
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(null);
      //act
      final result = dataSourceImpl.getLastNumberTrivia;

      //assert
      expect(()=>result(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', (){
    const tNumberTriviaModel = NumberTriviaModel(number: 1,text: 'test trivia');

    test('should call SharePreferences to cache the data', ()async{
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      //act
      dataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);

      //assert
      final expectJson = json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(CACHE_NUMBER_TRIVIA, expectJson));
    });
  });
}
