import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:thread/routes/routes_names.dart';

import '../../views/models/post_models.dart';

class PostActions extends StatelessWidget {
  final PostModel post; // Accept the post model
  final int likeCount;
  final int commentsCount;

  const PostActions({
    required this.post,
    required this.likeCount,
    required this.commentsCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
            IconButton(
              onPressed: () {
                Get.toNamed(RoutesNames.addreply, arguments: post);
              },
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_rounded)),
          ],
        ),
        Row(
          children: [
            Text("$likeCount likes"),
            const SizedBox(width: 10),
            Text("$commentsCount replies"),
          ],
        ),
      ],
    );
  }
}