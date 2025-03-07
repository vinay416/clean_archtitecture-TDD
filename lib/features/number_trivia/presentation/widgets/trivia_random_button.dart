import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaRandomButton extends StatelessWidget {
  const TriviaRandomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onTapRandom(context),
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.green),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        child: const Text(
          "Get Random",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  void onTapRandom(BuildContext context) {
    context.read<NumberTriviaBloc>().add(const RandomNumberTriviaEvent());
  }
}
