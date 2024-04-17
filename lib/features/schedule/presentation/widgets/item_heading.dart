import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:flutter/material.dart';

class ItemHeading extends StatelessWidget {
  final Schedule scheduleItem;

  const ItemHeading({super.key, required this.scheduleItem});

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
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(scheduleItem.title,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white)),
            Positioned(
              right: 0,
              child: Text(
                scheduleItem.hour,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
