import 'package:arioac_app/features/schedule/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../domain/domain.dart';

class ScheduleListItem extends StatelessWidget {
  final Schedule scheduleItem;
  const ScheduleListItem({super.key, required this.scheduleItem});

  @override
  Widget build(BuildContext context) {
    final conferenceType = scheduleItem.type;

    return Builder(builder: (context) {
      if (conferenceType == ConferenceType.heading) {
        return ItemHeading(scheduleItem: scheduleItem);
      }

      if (conferenceType == ConferenceType.simpleConference) {
        return ItemSimpleConference(scheduleItem: scheduleItem);
      }

      if (conferenceType == ConferenceType.panelConference) {
        return ItemPanelConference(scheduleItem: scheduleItem);
      }

      // Default conference
      return ItemConference(scheduleItem: scheduleItem);
    });
  }
}
