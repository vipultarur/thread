import 'package:thread/views/models/user_model.dart';

class PostModel {
  int? id;
  String? content;
  String? image;
  String? createdAt;
  int commentsCount; // Changed to non-nullable
  int likeCount; // Changed to non-nullable
  String? userId;
  Users? users;

  PostModel({
    this.id,
    this.content,
    this.image,
    this.createdAt,
    this.commentsCount = 0, // Default value
    this.likeCount = 0, // Default value
    this.userId,
    this.users,
  });

  // From JSON constructor
  PostModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        image = json['image'],
        createdAt = json['created_at'],
        commentsCount = json['comments_count'] ?? 0, // Default to 0 if null
        likeCount = json['like_count'] ?? 0, // Default to 0 if null
        userId = json['user_id'],
        users = json['users'] != null ? Users.fromJson(json['users']) : null;

  // To JSON conversion
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['comments_count'] = commentsCount;
    data['like_count'] = likeCount;
    data['user_id'] = userId;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}