import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:thread/routes/routes_names.dart';

import '../../views/models/post_models.dart';

class ActionsPost extends StatelessWidget {
  final PostModel post;

  const ActionsPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Row(
            children: [
              IconButton(onPressed: () { Get.toNamed(RoutesNames.settings); }, icon: Icon(Icons.favorite_outline),),
              const SizedBox(width: 15),
              IconButton(onPressed: () { Get.toNamed(RoutesNames.addreply,arguments: post); }, icon: Icon(Icons.chat_bubble_outline),),
              const SizedBox(width: 15),
              IconButton(onPressed: () { Get.toNamed(RoutesNames.settings); }, icon: Icon(Icons.send_rounded),),
              const SizedBox(width: 15),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.bottomLeft,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Text(
              '${post.commentsCount} replies.${post.likeCount} likes',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
