class ApiUserModel {
  final int id;
  final String username;
  final String avatar;
  final String bio;
  final String email;
  final String phoneNumber;
  final String gender;
  final String birthday;

  ApiUserModel(
      {required this.id,
      required this.username,
      required this.avatar,
      required this.bio,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.birthday});

  factory ApiUserModel.fromJson(Map<String, dynamic> data) {
    return ApiUserModel(
      id: data['ID'],
      username: data['username'],
      phoneNumber: data['phonenumber'],
      email: data['email'],
      avatar: data['avatar'],
      bio: data['bio'],
      gender: data['gender'],
      birthday: data['birthday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'username': username,
      'avatar': avatar,
      'bio': bio,
      'email': email,
      'phonenumber': phoneNumber,
      'gender': gender,
      'birthday': birthday,
    };
  }

  @override
  String toString() {
    return 'ApiUserModel{id: $id, username: $username, avatar: $avatar, bio: $bio, email: $email, phoneNumber: $phoneNumber, gender: $gender, birthday: $birthday}';
  }
}
