import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../views/models/post_models.dart';
import '../image_select.dart';

class HeaderPost extends StatelessWidget {
  final PostModel post;

  const HeaderPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ImageSelect(
          url: post.users?.metadata?.image,
        ),
      ),
      title: Row(
        children: [
          Text(
            post.users!.metadata!.name!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            _formatDate(post.createdAt),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.more_horiz),
        ],
      ),
      subtitle: Text(
        post.content!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
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
