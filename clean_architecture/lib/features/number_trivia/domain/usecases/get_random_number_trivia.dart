import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/usecases/usecases.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia,NoParams>{
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure,NumberTrivia>> call(NoParams params)async{
    return await repository.getRandomNumberTrivia();
  }
}

