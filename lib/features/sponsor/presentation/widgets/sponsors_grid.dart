import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:arioac_app/features/sponsor/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SponsorGrid extends ConsumerStatefulWidget {
  const SponsorGrid({super.key});

  @override
  SponsorGridState createState() => SponsorGridState();
}

class SponsorGridState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        if ((scrollController.position.pixels + 400) >=
            scrollController.position.maxScrollExtent) {
          ref.read(sponsorsProvider.notifier).loadNextPage();
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
    final sponsorState = ref.watch(sponsorsProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        child: GridView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: sponsorState.sponsors.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            final sponsor = sponsorState.sponsors[index];

            return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.63,
                        child: SponsorScreen(
                          sponsor: sponsor,
                        ),
                      );
                    },
                  );
                },
                child: SponsorCard(sponsor: sponsor));
          },
        ),
      ),
    );
  }
}
