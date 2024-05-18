import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? username;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? firstName;
  @HiveField(4)
  String? lastName;
  @HiveField(5)
  String? gender;
  @HiveField(6)
  String? image;
  @HiveField(7)
  String? token;

  //
  UserModel(
      {this.id,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.gender,
      this.image,
      this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      username = json['username'];
      email = json['email'];
      firstName = json['firstName'];
      lastName = json['lastName'];
      gender = json['gender'];
      image = json['image'];
      token = json['token'];
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}
