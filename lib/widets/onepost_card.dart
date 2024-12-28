import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/views/models/post_models.dart';
import 'package:thread/widets/post_componets/PostActions.dart';
import 'package:thread/widets/post_componets/PostContent.dart';
import 'package:thread/widets/post_componets/PostHeader.dart';
import 'package:thread/widets/post_componets/UserProfile.dart';


class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfile(post: post),
              const SizedBox(width: 10),
              SizedBox(
                width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostHeader(post: post),
                    PostContent(post: post),
                    PostActions(
                      post: post, // Pass the post object
                      likeCount: post.likeCount, // No need for toInt() since it's now non-nullable
                      commentsCount: post.commentsCount, // No need for toInt() since it's now non-nullable
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xff242424)),
        ],
      ),
    );
  }
}
