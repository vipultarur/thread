import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thread/views/models/post_models.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;

  const PostHeader({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          post.users!.metadata!.name!,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              _formatDate(post.createdAt),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'No Date';
    }
    try {
      DateTime dateTime = DateTime.parse(dateStr);
      return DateFormat('yMMMd').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
