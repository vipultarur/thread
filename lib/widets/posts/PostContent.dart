import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/views/models/post_models.dart';
import 'package:thread/utils/helper.dart';

class ContentPost extends StatelessWidget {
  final PostModel post;

  const ContentPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          if (post.image != null)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: context.height * 0.60,
                maxWidth: context.width * 0.80,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  getbukket1url(post.image!),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}
