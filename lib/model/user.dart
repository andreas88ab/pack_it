class User {


  User(this.id, this.username);

  final int id;
  final String username;

  static final columns = ["id", "username"];

  Map<String, dynamic> toMap() {
    return {
      "username": username,
    };
  }

  static fromMap(Map map) {
    User user = new User(map["id"], map["username"]);

    return user;
  }
}