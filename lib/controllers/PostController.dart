import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../views/models/post_models.dart';

class PostController extends GetxController {
  RxList<PostModel> posts=RxList<PostModel>();
  var deletepost=false.obs;
  var loading=false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    listenToNewPosts();
  }

  Future<void> fetchPosts() async {
    try {
      loading.value=true;
      final response = await Supabase.instance.client
          .from('post')
          .select()
          .order('created_at', ascending: false);

      if (response is List) {
        loading.value=false;

        posts.assignAll(response.map((e) => PostModel.fromJson(e)).toList());
      } else {
        print('Unexpected response: $response');
      }
    } catch (e) {
      if (e is PostgrestException) {
        loading.value=false;
        print('PostgrestException: ${e.message}');
        print('Details: ${e.details}');
        print('Hint: ${e.hint}');
      } else {
        print('Error fetching posts: $e');
      }
    }
  }



    Future<void> deletePost(postId) async {
      try {
        deletepost.value=true;
        final response = await Supabase.instance.client
            .from('post')
            .delete()
            .eq('id', postId)
            .select();

        if (response is List && response.isNotEmpty) {
          deletepost.value=false;
          posts.removeWhere((post) =>
          post.id == postId); // Remove the deleted post
          print('Post deleted successfully');
        } else {
           deletepost.value=false;
          print('No rows affected. Response: $response');
        }
      } catch (e) {
         deletepost.value=false;
        print('Error deleting post: $e');
      }
    }




    void listenToNewPosts() {
    try {
      Supabase.instance.client
          .from('post')
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
