import 'package:arioac_app/features/schedule/presentation/providers/providers.dart';
import 'package:arioac_app/features/schedule/presentation/screens/screens.dart';
import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemConference extends ConsumerWidget {
  final Schedule scheduleItem;
  const ItemConference({super.key, required this.scheduleItem});

  double calcContainerHeight() {
    int nameLength = scheduleItem.title.length;
    if (nameLength >= 52) {
      return 140;
    }
    return 140;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> rowColor = scheduleItem.color;
    final greenColor = Color.fromRGBO(
      rowColor[0],
      rowColor[1],
      rowColor[2],
      1,
    );

    return GestureDetector(
      onTap: () {
        ref.read(qaProvider.notifier).setConference(scheduleItem.id);
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return MainConferenceScreen(conferenceId: scheduleItem.id);
          },
        );
      },
      child: Container(
        height: calcContainerHeight(),
        margin: const EdgeInsets.only(left: 8, right: 8),
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: FadeInImage(
                    image: NetworkImage(scheduleItem.logoUrl!),
                    fadeInDuration: const Duration(milliseconds: 200),
                    fadeOutDuration: const Duration(milliseconds: 100),
                    fit: BoxFit.contain,
                    placeholderFit: BoxFit.scaleDown,
                    placeholder: const AssetImage('images/placeholder.gif'),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(left: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            scheduleItem.title,
                            textAlign: TextAlign.left,
                            softWrap: true,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          // padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                right: 14,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${scheduleItem.concept}  ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '  ${scheduleItem.hour}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
