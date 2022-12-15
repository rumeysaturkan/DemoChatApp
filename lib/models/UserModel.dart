class UserModel {
  final String uid;
  final String email;
  final String fullname;
  final String password;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullname,
    required this.password,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      fullname: data['fullname'] ?? '',
      password: data['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "fullname": fullname,
        "password": password,
      };
}
