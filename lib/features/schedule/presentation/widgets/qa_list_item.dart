import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/presentation/providers/qa_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QAListItem extends ConsumerStatefulWidget {
  final QA question;
  final Color cardColor;
  const QAListItem({
    super.key,
    required this.question,
    this.cardColor = Colors.white,
  });

  @override
  QAListItemState createState() => QAListItemState();
}

class QAListItemState extends ConsumerState<QAListItem> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 5,
                  spreadRadius: 12,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: ExpansionTile(
                backgroundColor: widget.cardColor,
                shape: const Border(),
                collapsedIconColor: Colors.green,
                collapsedBackgroundColor: widget.cardColor,
                iconColor: Colors.green,
                title: Text(
                  question.question,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                subtitle: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    _customTileExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    if (!question.userVoted) {
                      ref.read(qaProvider.notifier).voteQuestion(question.id);
                    }
                  },
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        question.userVoted
                            ? Icons.thumb_up_alt
                            : Icons.thumb_up_off_alt,
                      ),
                      Text(question.votes.toString())
                    ],
                  ),
                ),
                children: [
                  ListTile(
                    title: Text(
                      question.answer.isEmpty
                          ? 'Sin respuesta'
                          : question.answer,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    _customTileExpanded = expanded;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
