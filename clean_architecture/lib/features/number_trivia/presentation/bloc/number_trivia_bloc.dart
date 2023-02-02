import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecases.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter
  }) : super(Empty()){
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  void _onGetTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event,
      Emitter<NumberTriviaState> emit,
      )async{
    emit(Empty());
    final input = inputConverter.stringToUnsignedInteger(event.numberString);
    input.fold(
            (failure) async=> emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
            (data)async{
              emit(Loading());
              final result = await getConcreteNumberTrivia(Params(number: data));
              result.fold(
                      (failure) => emit(Error(
                          message: _mapFailureToMessage(failure)
                      )),
                      (number) => emit(Loaded(trivia: number))
              );
            }
    );
  }

  void _onGetTriviaForRandomNumber(
      GetTriviaForRandomNumber event,
      Emitter<NumberTriviaState> emit,
      )async{
    emit(Loading());
    final result = await getRandomNumberTrivia(NoParams());
    result.fold(
            (failure) => emit(Error(
            message: _mapFailureToMessage(failure)
        )),
            (number) => emit(Loaded(trivia: number))
    );
  }

  String _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
