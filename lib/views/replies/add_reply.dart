import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/controllers/reply_controller.dart';
import 'package:thread/routes/routes_names.dart';
import 'package:thread/views/models/post_models.dart';
import '../../services/supabase_service.dart';
import '../../widets/image_select.dart';
import '../../widets/posts/PostContent.dart';
import '../../widets/posts/PostHeader.dart';

class AddReply extends StatelessWidget {
  final List<String> threadMessages = [
    "This is the first message in the thread.",
    "Here is another comment in the thread.",
    "What do you think about this topic?",
  ];
  final PostModel post=Get.arguments;
  AddReply({super.key}); // Ensure the argument is of type PostModel

  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ReplyController replyController = Get.put(ReplyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back(result: post); // Pass the `post` object back to the previous page
            },
            icon: Icon(Icons.close),
          ),
        title: const Text("Reply"),
        actions: [TextButton(onPressed: (){}, child: const Text("Reply"))],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child:
        Column(
          children: [
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
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1E1E1E), // Dark gray background
                borderRadius: BorderRadius.circular(24.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Avatar Circle
                  CircleAvatar(
                    radius: 16.0,
                     child: ImageSelect(
                       url: supabaseService.currentUser.value?.userMetadata?["image"] ?? 'assets/images/default_profile_pic.png',
                     ), // Replace with your image asset
                  ),
                  SizedBox(width: 12.0),
                  // TextField
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'add a reply',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16.0,
                        ),
                        border: InputBorder.none, // Removes default underline
                      ),
                      cursorColor: Colors.white, // Cursor color
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


}