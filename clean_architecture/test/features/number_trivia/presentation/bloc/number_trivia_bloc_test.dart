
import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecases.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia,GetRandomNumberTrivia,InputConverter])
void main(){
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp((){
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter
    );
  });

  test('initialState should be empty', (){
    // Assert that the initial state is correct.
    expect(bloc.state, equals(Empty()));
  });
  
  group('GetTriviaForConcreteNumber', (){
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);
    
    test('should call the Input Converter to validate and convert the string to an unsigned integer', ()async{
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(const Right(tNumberParsed));
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    blocTest<NumberTriviaBloc,NumberTriviaState>(
      'should emit [Error] when the input is invalid',
      build: (){
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Empty(),
        const Error(message: INVALID_INPUT_FAILURE_MESSAGE)
      ],
    );

    test('should get data from the correct use case', ()async{
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(const Right(tNumberParsed));
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)));
    });

    blocTest<NumberTriviaBloc,NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: (){
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Empty(),
        Loading(),
        const Loaded(trivia: tNumberTrivia)
      ],
    );

    blocTest<NumberTriviaBloc,NumberTriviaState>(
      'should emit [Loading, Error] when data is gotten fail',
      build: (){
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      expect: () => [
        Empty(),
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ],
    );
  });

  group('GetTriviaForRandomNumber', (){
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should get data from the random use case', ()async{
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
      //act
      bloc.add(const GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));
      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    blocTest<NumberTriviaBloc,NumberTriviaState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: (){
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        const Loaded(trivia: tNumberTrivia)
      ],
    );

    blocTest<NumberTriviaBloc,NumberTriviaState>(
      'should emit [Loading, Error] when data is gotten fail',
      build: (){
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE)
      ],
    );
  });
}