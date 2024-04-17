import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:flutter/material.dart';

class ItemPanelConference extends StatelessWidget {
  final Schedule scheduleItem;

  const ItemPanelConference({super.key, required this.scheduleItem});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<int> rowColor = scheduleItem.color;
    final Color color = Color.fromRGBO(
      rowColor[0],
      rowColor[1],
      rowColor[2],
      1,
    );

    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInImage(
                  height: 30,
                  image: NetworkImage(scheduleItem.logos![0]),
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeOutDuration: const Duration(milliseconds: 100),
                  fit: BoxFit.contain,
                  placeholderFit: BoxFit.scaleDown,
                  placeholder: const AssetImage('images/placeholder.gif'),
                ),
                Column(
                  children: [
                    Text(
                      scheduleItem.speakers[0].name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      scheduleItem.speakers[0].jobTitle,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 5,
              ),
              child: const Divider(
                height: 5,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInImage(
                  alignment: Alignment.center,
                  height: 30,
                  image: NetworkImage(scheduleItem.logos![1]),
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeOutDuration: const Duration(milliseconds: 100),
                  fit: BoxFit.contain,
                  placeholderFit: BoxFit.scaleDown,
                  placeholder: const AssetImage('images/placeholder.gif'),
                ),
                Column(
                  children: [
                    Text(
                      scheduleItem.speakers[1].name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      scheduleItem.speakers[1].jobTitle,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth / 5,
              ),
              child: const Divider(
                height: 5,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${scheduleItem.concept}  ',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white),
                ),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '  ${scheduleItem.hour}',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
