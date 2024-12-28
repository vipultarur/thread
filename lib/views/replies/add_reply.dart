import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/reply_controller.dart';
import 'package:thread/views/models/post_models.dart';
import 'package:thread/widets/image_select.dart';
import '../../services/supabase_service.dart';

class AddReply extends StatelessWidget {
  final PostModel post;

  AddReply({super.key}) : post = Get.arguments as PostModel; // Ensure the argument is of type PostModel

  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ReplyController replyController = Get.put(ReplyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
        title: const Text("Reply"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Obx(
                  () => replyController.loading.value
                  ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(),
              )
                  : Text("Reply"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: ImageSelect(url: post.users?.metadata?.image),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.users!.metadata!.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(post.content!),
                  if (post.image != null)
                  // PostImage(postId: post.id!, url: post.image!),
                    TextField(
                      autofocus: true,
                      controller: replyController.replyController,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 10,
                      minLines: 1,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        hintText: "Reply to ${post.users!.metadata!.name!}",
                        border: InputBorder.none,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}