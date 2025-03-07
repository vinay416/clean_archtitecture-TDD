import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TriviaSearchField extends StatefulWidget {
  const TriviaSearchField({super.key});

  @override
  State<TriviaSearchField> createState() => _TriviaSearchFieldState();
}

class _TriviaSearchFieldState extends State<TriviaSearchField> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return buildTextFiled();
    // return SizedBox(
    //   height: 40,
    //   child: Row(
    //     spacing: 20,
    //     children: [
    //       Expanded(child: ),
    //       SizedBox(
    //         height: 40,
    //         width: 40,
    //         child: buildSearchButton(),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget buildTextFiled() {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 2,
      ),
    );

    return Form(
      key: formKey,
      child: TextFormField(
        controller: textController,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value?.trim().isEmpty ?? false) {
            return "Number required";
          }
          return null;
        },
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: border.borderSide.copyWith(
              color: Colors.green[600]!,
            ),
          ),
          focusedErrorBorder: border,
          hintText: "Type any number",
          isDense: true,
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 40,
          ),
          suffixIcon: IconButton.filled(
            onPressed: onSearchTap,
            icon: const Icon(Icons.search),
            padding: const EdgeInsets.all(0),
            color: Colors.white,
            iconSize: 30,
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.green,
              ),
              shape: WidgetStatePropertyAll(CircleBorder()),
            ),
          ),
        ),
      ),
    );
  }

  void onSearchTap() {
    final bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      final numberString = textController.text.trim();
      context
          .read<NumberTriviaBloc>()
          .add(ConcreteNumberTriviaEvent(numberString));
      textController.clear();
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
