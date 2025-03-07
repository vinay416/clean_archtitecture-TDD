import 'package:clean_architecture/dependency_injection.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/appbar/home_app_bar.dart';
import '../widgets/trivia_random_button.dart';
import '../widgets/trivia_title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<NumberTriviaBloc>(),
      child: const Scaffold(
        appBar: HomeAppBar(),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            spacing: 30,
            children: [
              TriviaTitleWidget(),
              TriviaSearchField(),
              TriviaRandomButton(),
              SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
