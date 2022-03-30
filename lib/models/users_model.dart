class UsersModel {
  List? users;

  UsersModel({
    this.users,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      users: json['data'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "users": users,
    };
  }
}
