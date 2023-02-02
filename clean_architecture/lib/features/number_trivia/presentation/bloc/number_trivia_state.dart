part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  final List? propss;
  const NumberTriviaState([this.propss]);
  @override
  List<Object?> get props => (propss ?? []);
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({required this.trivia});
}

class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});
}
