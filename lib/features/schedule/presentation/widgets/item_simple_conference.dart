import 'package:arioac_app/features/schedule/domain/entities/schedule.dart';
import 'package:flutter/material.dart';

class ItemSimpleConference extends StatelessWidget {
  final Schedule scheduleItem;
  const ItemSimpleConference({super.key, required this.scheduleItem});

  @override
  Widget build(BuildContext context) {
    List<int> rowColor = scheduleItem.color;
    final Color color = Color.fromRGBO(
      rowColor[0],
      rowColor[1],
      rowColor[2],
      1,
    );

    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${scheduleItem.title} - ${scheduleItem.subtitle}',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${scheduleItem.concept}  ',
                  style: Theme.of(context).textTheme.labelSmall,
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
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
