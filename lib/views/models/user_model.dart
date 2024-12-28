
class Users {
  String? email;
  Metadata? metadata;

  // Constructor with optional parameters
  Users({this.email, this.metadata});

  // From JSON constructor
  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  // To JSON conversion
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? bio;
  String? sub;
  String? name;
  String? email;
  String? image;
  bool? emailVerified;
  bool? phoneVerified;

  // Constructor with optional parameters
  Metadata({
    this.bio,
    this.sub,
    this.name,
    this.email,
    this.image,
    this.emailVerified,
    this.phoneVerified,
  });

  // From JSON constructor
  Metadata.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    sub = json['sub'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
  }

  // To JSON conversion
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bio'] = bio;
    data['sub'] = sub;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['email_verified'] = emailVerified;
    data['phone_verified'] = phoneVerified;
    return data;
  }
}
