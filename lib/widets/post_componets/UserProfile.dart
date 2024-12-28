import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/widets/image_select.dart';
import 'package:thread/views/models/post_models.dart';

class UserProfile extends StatelessWidget {
  final PostModel post;

  const UserProfile({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: context.width * 0.12,
          child: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: ImageSelect(
              url: post.users?.metadata?.image,
            ),
          ),
        ),
        Container(
          height: context.height / 1.7,
          width: 2,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ImageSelect(
                    radius: 7,
                    url: post.users?.metadata?.image,
                  ),
                ),
                Positioned(
                  left: 7,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ImageSelect(
                      radius: 7,
                      url: post.users?.metadata?.image,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
