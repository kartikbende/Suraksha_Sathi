class UserModel {
  String name;
  String email;
  String bio;
  String createdAt;
  String PhoneNumber;
  String uid;

  UserModel(
      {required this.name,
      required this.email,
      required this.bio,
      required this.createdAt,
      required this.PhoneNumber,
      required this.uid});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        bio: map['bio'] ?? '',
        createdAt: map['createdAt'] ?? '',
        PhoneNumber: map['phoneNumber'] ?? '',
        uid: map['uid'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "phoneNumber": PhoneNumber,
      "createdAt": createdAt
    };
  }
}
