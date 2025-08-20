class UserModel {
  final String userName;
  final String password;
  final String token;

  UserModel({
    required this.userName,
    required this.password,
    required this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['username'] as String,
      password: json['password'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'token': token,
    };
  }
}

