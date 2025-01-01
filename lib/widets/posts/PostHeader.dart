import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:thread/controllers/PostController.dart';

import '../../services/supabase_service.dart';
import '../../views/models/post_models.dart';
import '../image_select.dart';

class HeaderPost extends StatelessWidget {
  final PostModel post;
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final PostController controller = Get.put(PostController());

   HeaderPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListTile(
      leading: CircleAvatar(
        child: ImageSelect(
          url: post.users?.metadata?.image ?? 'lib/assets/images/avatar.png', // Provide a default image
        ),
      ),
      title:
      Row(
        children: [
          Text(
            post.users?.metadata?.name ?? "Unknown User",
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz),
            onSelected: (value) async {
              if (value == 'delete') {
                // Check if the current user is the owner of the post
                if (post.userId == SupabaseService.client.auth.currentUser?.id) {
                  await controller.deletePost(post.id);
                } else {
                  print('You can only delete your own posts.');
                }
              } else if (value == 'report') {
                print('Report post logic here');
              } else if (value == 'share') {
                print('Share post logic here');
              }
            },
            itemBuilder: (context) => [
              if (post.userId == SupabaseService.client.auth.currentUser?.id)
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete',style: TextStyle(color: Colors.red),),
                ),
              const PopupMenuItem(
                value: 'report',
                child: Text('Report'),
              ),
              const PopupMenuItem(
                value: 'share',
                child: Text('Share'),
              ),
            ],
          ),
        ],
      ),
      subtitle: Text(
        post.content ?? "No Content", // Handle null `content`
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
      return 'Invalid Date';
    }
  }
}
