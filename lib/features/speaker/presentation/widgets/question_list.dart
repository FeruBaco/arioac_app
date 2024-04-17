import 'package:arioac_app/features/shared/widgets/circular_loading_indicator.dart';
import 'package:arioac_app/features/speaker/presentation/providers/providers.dart';
import 'package:arioac_app/features/speaker/presentation/widgets/qa_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class QuestionList extends ConsumerStatefulWidget {
  const QuestionList({super.key});

  @override
  QuestionListState createState() => QuestionListState();
}

class QuestionListState extends ConsumerState<QuestionList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        if ((scrollController.position.pixels + 200) >=
            scrollController.position.maxScrollExtent) {
          ref.read(speakerProvider.notifier).loadNextPage();
        }
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qas = ref.watch(speakerProvider);
    const Color even = Colors.white;
    const Color odd = Color.fromRGBO(202, 253, 198, 1);

    return qas.isPageLoading
        ? const CircularLoadingIndicator()
        : RefreshIndicator(
            onRefresh: ref.read(speakerProvider.notifier).pullRefresh,
            child: ListView.builder(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 6),
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: qas.qas.length,
              itemBuilder: (context, index) {
                final question = qas.qas[index];
                final Color selectedColor = (index % 2 == 0) ? even : odd;

                return Column(
                  children: [
                    QAListItem(
                      question: question,
                      cardColor: selectedColor,
                    ),
                  ],
                );
              },
            ),
          );
  }
}
