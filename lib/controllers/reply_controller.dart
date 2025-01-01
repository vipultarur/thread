import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thread/services/supabase_service.dart';
import '../utils/helper.dart';  // Assuming you have a helper file for snack bars or utilities
import '../views/models/ReplyModel.dart';

class ReplyController extends GetxController {
  final TextEditingController replyController = TextEditingController();
  var loading = false.obs;
  var reply = "".obs;
  var repliesloading = false.obs;
  var Postreplyuserloading = false.obs;
  var deleteloading = false.obs;
  var Postreplyloading = false.obs;
  RxList<ReplyModel> Postreply = RxList<ReplyModel>();

  @override
  void onClose() {
    replyController.dispose(); // Dispose the controller when the screen is closed
    super.onClose();
  }

  // Add a reply to a post
  void addReply(String userId, int postId, String postUserId) async {
    try {
      loading.value = true;

      // Increment the comment count
      await SupabaseService.client.rpc("comment_increment", params: {"count": 1, "row_id": postId});

      // Add notification for the post owner
      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "Commented on your post",
        "to_user_id": postUserId,
        "post_id": postId
      });

      // Add the reply/comment
      await SupabaseService.client.from("comments").insert({
        "post_id": postId,
        "user_id": userId,
        "reply": replyController.text,
      });

      loading.value = false;
      Get.snackbar("Success", "Replied successfully!"); // Show success message
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", "Something went wrong: $e"); // Show error message
    }
  }

  // Fetch the replies for a given post
  void fetchPostReplies(String postId) async {
    try {
      Postreplyloading.value = true;

      final List<dynamic> response = await SupabaseService.client
          .from("comments")
          .select('''
          user_id, post_id, reply, created_at,
          user:user_id(email, metadata)
        ''')
          .eq("post_id", postId)
          .order("created_at", ascending: false);


      Postreplyloading.value = false;

      if (response.isNotEmpty) {
        // If replies exist, map them to ReplyModel objects
        Postreply.value = [for (var item in response) ReplyModel.fromJson(item)];
      } else {
        Postreply.clear(); // Clear the replies list if none found
      }
    } catch (e) {
      Postreplyloading.value = false;
      showSnackBar("Error", "Something went wrong: $e"); // Show error message if something fails
    }
  }
  void fetchPostRepliesuser(String postId) async {
    try {
      Postreplyuserloading.value = true;

      final List<dynamic> response = await SupabaseService.client
          .from("comments")
          .select('''
          user_id, post_id, reply, created_at,
          user:user_id(email, metadata)
        ''')
          .eq("post_id", postId)
          .order("created_at", ascending: false).limit(3);


      Postreplyuserloading.value = false;

      if (response.isNotEmpty) {
        // If replies exist, map them to ReplyModel objects
        Postreply.value = [for (var item in response) ReplyModel.fromJson(item)];
      } else {
        Postreply.clear(); // Clear the replies list if none found
      }
    } catch (e) {
      Postreplyuserloading.value = false;
      showSnackBar("Error", "Something went wrong: $e"); // Show error message if something fails
    }
  }

  
  // Delete a comment
  void deleteComment(String commentId, String userId, String postUserId) async {
    try {
      deleteloading.value = true;

      // Check if the current user is either the post owner or the comment owner
      if (userId == postUserId || userId == commentId) {
        // Proceed with deleting the comment
        print("comment id ------------------:${commentId}");
        await SupabaseService.client.from("comments").delete().eq("id", commentId);

        deleteloading.value = false;
        Get.snackbar("Success", "Comment deleted successfully!");
      } else {
        deleteloading.value = false;
        Get.snackbar("Error", "You are not authorized to delete this comment.");
      }
    } catch (e) {
      deleteloading.value = false;
      Get.snackbar("Error", "Something went wrong: $e");
      print("exception : ${e}");
    }
  }
}
