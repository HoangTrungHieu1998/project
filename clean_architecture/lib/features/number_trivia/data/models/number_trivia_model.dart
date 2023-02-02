import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({required super.text, required super.number});

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      // found: json['found'],
      number: (json['number'] as num).toInt(),
      text: json['text'],
      // type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['found'] = this.found;
    data['number'] = number;
    data['text'] = text;
    // data['type'] = this.type;
    return data;
  }
}
