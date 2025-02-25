import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';

class NumberTriviaModel extends NumberTrivaEntity {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json["text"] as String,
      number: (json["number"] as num).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "number": number,
    };
  }
}
