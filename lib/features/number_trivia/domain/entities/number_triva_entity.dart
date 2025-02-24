import 'package:equatable/equatable.dart';

class NumberTrivaEntity extends Equatable {
  const NumberTrivaEntity({
    required this.text,
    required this.number,
  });
  final String text;
  final int number;

  @override
  List<Object?> get props => [text,number];
}
