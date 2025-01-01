import 'package:thread/views/models/user_model.dart';

class ReplyModel {
  final String? userId;
  final int? postId;
  final String? reply;
  final String? createdAt;
  final Users? user;

  ReplyModel({
    this.userId,
    this.postId,
    this.reply,
    this.createdAt,
    this.user,
  });

  // Factory constructor for creating an instance from JSON
  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      userId: json['user_id'] as String?,
      postId: json['post_id'] as int?,
      reply: json['reply'] as String?,
      createdAt: json['created_at'] as String?,
      user: json['user'] != null ? Users.fromJson(json['user']) : null,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'post_id': postId,
      'reply': reply,
      'created_at': createdAt,
      if (user != null) 'user': user!.toJson(),
    };
  }

}
