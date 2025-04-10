import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/number_triva_entity.dart';
import '../utils/trivia_textsyle.dart';

class TriviaTitleWidget extends StatelessWidget {
  const TriviaTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
            builder: (context, state) {
              if (state is NumberTriviaLoadingState) {
                return buildLoading();
              } else if (state is NumberTriviaErrorState) {
                return buildError(state.message);
              } else if (state is NumberTriviaDataState) {
                return buildTrivia(state.numberTriva);
              } else {
                return const Text(
                  "Search with a number\nor\nTap on random",
                  style: kTitleTextStyle,
                  textAlign: TextAlign.center,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTrivia(NumberTrivaEntity trivia) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${trivia.number}",
          style: kTitleTextStyle.copyWith(
            color: Colors.green,
            fontSize: 40,
          ),
        ),
        Text(
          trivia.text,
          style: kDsecTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildError(String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$errorMessage!",
          style: kErrorTextStyle,
        ),
        const Text(
          "Please try again later.",
          style: kSubTitleTextStyle,
        ),
      ],
    );
  }

  Widget buildLoading() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        CircularProgressIndicator(
          color: Colors.green,
        ),
        Text("Loading..."),
      ],
    );
  }
}
