import 'dart:convert';

import 'package:pack_it_v1/model/user.dart';

class Story {
  Story(this.id, this.title, this.body, this.user_id, this.user);
  Story.nonUser(this.id, this.title, this.body, this.user_id) {
    this.user = new User(this.user_id!, "");
  }

  int? id;
  String? title;
  String? body;
  int? user_id;
  User? user;

  static final columns = ["id", "title", "body", "user_id"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "body": body,
      "user_id": user_id,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    return new Story.nonUser(
        map["id"],
        map["title"],
        map["body"],
        map["user_id"]
    );
  }
}