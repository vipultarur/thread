import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../views/models/post_models.dart';

class PostController extends GetxController {
  var posts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    listenToNewPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await Supabase.instance.client
          .from('posts')
          .select()
          .order('created_at', ascending: false);

      if (response is List) {
        posts.assignAll(response.map((e) => PostModel.fromJson(e)).toList());
      } else {
        print('Unexpected response: $response');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  void listenToNewPosts() {
    try {
      Supabase.instance.client
          .from('posts')
          .stream(primaryKey: ['id']) // Replace 'id' with the table's primary key column
          .order('created_at', ascending: false)
          .listen((data) {
        for (final record in data) {
          final newPost = PostModel.fromJson(record);
          if (!posts.any((post) => post.id == newPost.id)) {
            posts.insert(0, newPost); // Add new post at the top
          }
        }
      });
    } catch (e) {
      print('Error listening to new posts: $e');
    }
  }
}
