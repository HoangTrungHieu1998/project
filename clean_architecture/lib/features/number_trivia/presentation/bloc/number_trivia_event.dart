part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  final List? propss;
  const NumberTriviaEvent([this.propss]);
  @override
  List<Object?> get props => (propss ?? []);
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent{
  final String numberString;

  const GetTriviaForConcreteNumber(this.numberString);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent{

  const GetTriviaForRandomNumber();
}