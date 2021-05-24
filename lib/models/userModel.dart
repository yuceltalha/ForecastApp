// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.id,
    this.userName,
    this.userPassword,
    this.userAdminStatus,
  });

  int id;
  String userName;
  String userPassword;
  int userAdminStatus;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    userName: json["userName"],
    userPassword: json["userPassword"],
    userAdminStatus: json["userAdminStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userName": userName,
    "userPassword": userPassword,
    "userAdminStatus": userAdminStatus,
  };
}
