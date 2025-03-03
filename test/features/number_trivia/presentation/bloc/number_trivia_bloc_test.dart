import 'package:clean_architecture/features/number_trivia/domain/entities/number_triva_entity.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final bloc = NumberTriviaBloc();
  const tNumberString = "1";
  const trivia = NumberTrivaEntity(text: "Test trivia", number: 1);

  group(
    "NumberTriviaBloc Test",
    () {
      test(
        "Initial State",
        () {
          expect(bloc.state, const NumberTriviaEmptyState());
        },
      );

      test(
        "Event ConcreteNumberTriviaEvent -> State NumberTriviaDataState",
        () {
          const expected =  [
            NumberTriviaEmptyState(),
            NumberTriviaDataState(trivia),
          ];
          expectLater(bloc.state, emitsInOrder(expected));
          bloc.add(const ConcreteNumberTriviaEvent(tNumberString));
        },
      );
    },
  );
}
