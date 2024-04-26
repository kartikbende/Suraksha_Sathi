class UserModel {
  String name;
  String email;
  String bio;
  String createdAt;
  String PhoneNumber;
  String uid;
  String guardian1;
  String guardian2;

  UserModel(
      {required this.name,
      required this.email,
      required this.bio,
      required this.createdAt,
      required this.PhoneNumber,
      required this.uid,
      required this.guardian1,
      required this.guardian2});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      createdAt: map['createdAt'] ?? '',
      PhoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
      guardian1: map['guardian1'] ?? '',
      guardian2: map['guardian2'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "bio": bio,
      "phoneNumber": PhoneNumber,
      "createdAt": createdAt,
      "guardian1": guardian1,
      "guardian2": guardian2,
    };
  }
}

class Friendship {
  final String userId;
  final String friendId;

  Friendship({required this.userId, required this.friendId});
}

class Users {
  final String id;
  final String name;
  final String additionalInfo;
  final String phoneNumber;

  Users(
      {required this.id,
      required this.name,
      required this.additionalInfo,
      required this.phoneNumber});
}
