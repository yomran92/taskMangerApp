
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel {
  @HiveField(0)


  String? id;
  @HiveField(1)

  String? email;
  @HiveField(2)

  String? password;
  @HiveField(3)

  String? token;


  //
  UserModel(
      {this.id,
      this.email,
      this.password,
      this.token,
    });

  UserModel.fromJson(Map<String, dynamic> json) {
    try {
       id = json['id'];
      email = json['email'];
       password = json['password'];
       token = json['token'];

    } catch (e) {
      print(e.toString());
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['token'] = this.token;
    data['password'] = this.password;

    return data;
  }

 }
