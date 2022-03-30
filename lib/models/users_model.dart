class UsersModel {
  List? users;

  UsersModel({
    this.users,
  });

  factory UsersModel.fromJson(List json) {
    return UsersModel(
      users: json,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "users": users,
    };
  }
}
