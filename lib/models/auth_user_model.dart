class AuthUserModel {
  int? id;
  String? token;
  String? name;
  String? email;

  AuthUserModel({
    this.id,
    this.token,
    this.name,
    this.email,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['Id'] ?? 0,
      token: json['Token'] ?? '',
      name: json['Name'] ?? '',
      email: json['Email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "token": token,
      "name": name,
      "email": email,
    };
  }
}
