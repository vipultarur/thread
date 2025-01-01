import 'package:flutter/material.dart';
import 'package:thread/views/models/ReplyModel.dart';
import 'package:thread/widets/image_select.dart';
import '../utils/helper.dart';

typedef DeleteCallback = void Function(ReplyModel reply);

class CommentCard extends StatelessWidget {
  final ReplyModel reply;
  final bool isAuthCard; // Indicates if the comment belongs to the authenticated user
  final DeleteCallback? callback; // Callback for delete action

  const CommentCard({
    Key? key,
    required this.reply,
    this.isAuthCard = false,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.black, // Background color
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 20, // Adjust size as needed
                    backgroundColor: Colors.grey[800],
                    child:  ImageSelect(url: reply.user?.metadata?.image,), // Placeholder color
                  ),
                  const SizedBox(width: 8),
                  // Username and Timestamp
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reply.user?.metadata?.name ?? "Username",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "33m", // Replace with dynamic timestamp
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Options Icon
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Handle options button action
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Content Text
              Text(
                reply.reply ?? "hey, threads 👀",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // User name
        Text(
          reply.user?.metadata?.name ?? "Unknown User",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Row(
          children: [
            // Created date
            Text(
              formatDate(reply.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            // Delete or More icon
            isAuthCard
                ? GestureDetector(
              onTap: () {
                confirmBox(
                  "Are you sure?",
                  "This action cannot be undone.",
                      () => callback?.call(reply),
                );
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 20,
              ),
            )
                : const Icon(
              Icons.more_horiz,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ],
    );
  }
}
