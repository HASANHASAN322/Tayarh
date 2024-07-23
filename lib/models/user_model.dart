
import 'dart:convert';

UserModel welcomeFromJson(String str) => UserModel.fromJson(json.decode(str));

String welcomeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phoneCode;
  String? phone;
  String? role;
  int? code;
  String? image;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.phoneCode,
        this.phone,
        this.role,
        this.code,
        this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phoneCode: json["phone_code"],
      phone: json["phone"],
      role: json["role"],
      code: json["code"],
      image: json['image']);

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_code": phoneCode,
    "phone": phone,
    "role": role,
    "code": code,
    "image": image
  };
}