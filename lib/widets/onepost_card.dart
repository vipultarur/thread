import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thread/widets/posts/PostActions.dart';
import 'package:thread/widets/posts/PostContent.dart';
import 'package:thread/widets/posts/PostHeader.dart';

import '../controllers/reply_controller.dart';
import '../views/models/post_models.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

   PostCard({required this.post, super.key});
  final ReplyController controller = Get.put(ReplyController());

  @override
  Widget build(BuildContext context) {
    return
      Container(
      margin: EdgeInsets.symmetric(
          vertical: 10), // Margin for spacing between posts
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Column(
            children: [
              HeaderPost(post: post),
              ContentPost(post: post),
              ActionsPost(post: post),
            ],
          ),
          Positioned(
            left: 35,
            top: 70, // Adjust top as needed
            bottom: 40, // Extend to bottom of content area
            child: Container(
              width: 3,
              height: 100, // Adjust height for divider
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius:
                    BorderRadius.circular(12), // Set your desired radius here
              ),
            ),
          ),
          Positioned(
            right: 330,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    right: 0,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/images/avatar.png'),
                      radius: 9,
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    top: 10,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/images/avatar.png'),
                      radius: 7,
                    ),
                  ),
                  const Positioned(
                    right: 8,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('lib/assets/images/avatar.png'),
                      radius: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
