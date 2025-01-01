import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/views/models/post_models.dart';
import 'package:thread/controllers/reply_controller.dart';
import 'package:thread/widets/image_select.dart';
import '../../services/supabase_service.dart';
import '../../utils/helper.dart';

class ActionsPost extends StatelessWidget {
  final PostModel post;
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  ActionsPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReplyController controller = Get.put(ReplyController());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // Placeholder action for favorite button
                },
                icon: Icon(Icons.favorite_outline),
              ),
              const SizedBox(width: 15),
              IconButton(
                onPressed: () {
                  // Show comments modal dialog when chat bubble icon is clicked
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      // Pass supabaseService to the CommentModal
                      return CommentModal(post: post, controller: controller, supabaseService: supabaseService);
                    },
                  );
                },
                icon: Icon(Icons.chat_bubble_outline),
              ),
              const SizedBox(width: 15),
              IconButton(
                onPressed: () {
                  // Placeholder action for send button
                },
                icon: Icon(Icons.send_rounded),
              ),
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

class CommentModal extends StatelessWidget {
  final PostModel post;
  final ReplyController controller;
  final SupabaseService supabaseService;  // Added supabaseService

  // Constructor now includes supabaseService
  CommentModal({required this.post, required this.controller, required this.supabaseService});

  @override
  Widget build(BuildContext context) {
    // Fetching the replies (comments) for this post
    controller.fetchPostReplies(post.id.toString());

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Header with the post title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Comments',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.grey),

          // Displaying the list of comments
          Expanded(
            child: Obx(() {
              if (controller.Postreplyloading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: controller.Postreply.length,
                itemBuilder: (context, index) {
                  final reply = controller.Postreply[index];
                  return ListTile(
                    leading: ImageSelect(
                      url: reply.user?.metadata?.image,
                    ),
                    title: Row(
                      children: [
                        Text(
                          post.users?.metadata?.name ?? "Unknown User", // Handle null `name`
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatDate(post.createdAt), // Safely format the date
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
                      reply.reply ?? "No reply text",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              );
            }),
          ),

          // Reply input area
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Avatar Circle
                CircleAvatar(
                  radius: 20,
                  child: ImageSelect(
                    url: supabaseService.currentUser.value?.userMetadata?["image"] ??
                        'assets/images/default_profile_pic.png',
                  ),
                ),
                SizedBox(width: 12.0),
                // TextField for reply input
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E1E), // Dark gray background
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            autofocus: true,
                            controller: controller.replyController,
                            onChanged: (value) => controller.reply.value = value,
                            style: TextStyle(
                              color: controller.reply.value.isNotEmpty ? Colors.black : Colors.white,
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(
                              hintText: controller.reply.value.isNotEmpty ? '' : 'Add a reply...',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16.0,
                              ),
                              border: InputBorder.none, // Removes default underline
                            ),
                            cursorColor: Colors.white, // Cursor color
                          ),
                        ),
                        // Send button inside a CircleAvatar
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(
                              Icons.send_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (controller.reply.isNotEmpty) {
                                controller.addReply(
                                  supabaseService.currentUser.value!.id,
                                  post.id!,
                                  post.userId!,
                                );

                                // Clear the text field after sending the comment
                                controller.replyController.clear();
                                controller.reply.value = '';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
