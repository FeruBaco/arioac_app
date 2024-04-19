import 'package:arioac_app/features/schedule/presentation/providers/schedules_provider.dart';
import 'package:arioac_app/features/shared/widgets/circular_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'schedule_list_item.dart';

class ScheduleList extends ConsumerStatefulWidget {
  const ScheduleList({super.key});

  @override
  ScheduleListState createState() => ScheduleListState();
}

class ScheduleListState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        if ((scrollController.position.pixels + 400) >=
            scrollController.position.maxScrollExtent) {
          ref.read(schedulesProvider.notifier).loadNextPage();
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
    final scheduleState = ref.watch(schedulesProvider);

    return scheduleState.isPageLoading
        ? const CircularLoadingIndicator()
        : SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PROGRAMA',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      '  DÍA 1',
                      style: TextStyle(
                          backgroundColor: Color(0xFFF8F7F7),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromRGBO(85, 176, 106, 1)),
                    ),
                  ],
                ),
                ListView.builder(
                  // controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: scheduleState.schedules.length,
                  itemBuilder: (context, index) {
                    final scheduleItem = scheduleState.schedules[index];

                    return ScheduleListItem(scheduleItem: scheduleItem);
                  },
                ),
              ],
            ));
  }
}
