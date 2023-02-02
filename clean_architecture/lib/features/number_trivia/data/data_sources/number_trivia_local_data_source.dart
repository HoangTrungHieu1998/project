import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource{
  ///Gets the cached [NumberTriviaModel] which were gotten the last time
  ///the user had an internet connection
  ///
  ///Throws a [CacheException] if no cache data is present
  Future<NumberTriviaModel> getLastNumberTrivia();


  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHE_NUMBER_TRIVIA = 'CACHE_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        CACHE_NUMBER_TRIVIA,
        json.encode(triviaToCache.toJson())
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    // TODO: implement getLastNumberTrivia
    final jsonString = sharedPreferences.getString(CACHE_NUMBER_TRIVIA) ?? "";
    if(jsonString.isEmpty){
      throw CacheException();
    }else{
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }
  }
}