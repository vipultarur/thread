
import 'package:thread/views/models/user_model.dart';

class NotificationModel {
  final int? id;
  final int? postId;
  final String? notification;
  final String? createdAt;
  final String? userId;
  final Users? user;

  NotificationModel({
    this.id,
    this.postId,
    this.notification,
    this.createdAt,
    this.userId,
    this.user,
  });

  // Factory constructor for creating an instance from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      postId: json['post_id'] as int?,
      notification: json['notification'] as String?,
      createdAt: json['created_at'] as String?,
      userId: json['user_id'] as String?,
      user: json['user'] != null ? Users.fromJson(json['user']) : null,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'notification': notification,
      'created_at': createdAt,
      'user_id': userId,
      if (user != null) 'user': user!.toJson(),
    };
  }
}
