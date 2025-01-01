import 'package:flutter/material.dart';
import 'package:thread/views/models/ReplyModel.dart';

import '../utils/helper.dart';
import 'comment_card.dart';

class CommentCardTopbar extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const CommentCardTopbar({
    required this.reply,
    this.isAuthCard = false,
    this.callback,
    super.key, required ReplyModel comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reply.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formatDate(reply.createdAt!)),
            const SizedBox(width: 10),
            isAuthCard
                ? GestureDetector(
              onTap: () {
                confirmBox(
                    "Are you sure ?", "This action can't be undone.", () {
                  callback!(reply);
                });
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
                : const Icon(Icons.more_horiz),
          ],
        )
      ],
    );
  }
}