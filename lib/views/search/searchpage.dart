import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostModel {
  final String username;
  final String avatarUrl;
  final String content;
  final String imageUrl;
  final String timestamp;
  final int likes;
  final int replies;

  PostModel({
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.replies,
  });
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<PostModel> posts = []; // Placeholder for posts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final post = posts[index];
                return CartPost(post: post); // Placeholder widget
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}

class CartPost extends StatelessWidget {
  final PostModel post;

  const CartPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeaderPost(post: post), // Placeholder widget
          ContentPost(post: post), // Placeholder widget
          ActionsPost(post: post), // Placeholder widget
        ],
      ),
    );
  }
}

class HeaderPost extends StatelessWidget {
  final PostModel post;

  const HeaderPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(post.avatarUrl), // Placeholder for avatar
      ),
      title: Text(post.username),
      subtitle: Text(post.content),
      trailing: const Icon(Icons.more_horiz), // Placeholder action
    );
  }
}

class ContentPost extends StatelessWidget {
  final PostModel post;

  const ContentPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: post.imageUrl.isNotEmpty
          ? Image.asset(post.imageUrl) // Placeholder for image
          : const SizedBox.shrink(),
    );
  }
}

class ActionsPost extends StatelessWidget {
  final PostModel post;

  const ActionsPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.favorite_outline), // Placeholder action
        SizedBox(width: 10),
        Icon(Icons.chat_bubble_outline), // Placeholder action
        SizedBox(width: 10),
        Icon(Icons.send), // Placeholder action
      ],
    );
  }
}
