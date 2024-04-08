import 'package:todoapp/features/account/data/remote/models/responses/user_model.dart';

import '../../../../domain/entities/login_entity.dart';

class LogInModel {
  late bool success;
  late String? message;
 late UserModel userModel;

  LogInModel({required this.success,required this.userModel,this.message});

  LogInModel.fromJson(Map<String, dynamic> json) {
    success = json['AlCode'] == 0 ? true : false;
    if (success) {
      userModel=json['user'];
    }
    message = json['Mess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AlCode'] = this.success;
    data['Mess'] = this.message;
    data['user'] = this.userModel;

    return data;
  }

  @override
  LogInModel fromJson(Map<String, dynamic> json) {
    return LogInModel.fromJson(json);
  }

  @override
  LogInEntity toEntity() {
    return LogInEntity(
        success: success,
        message: message,
        userModel:userModel
        );
  }
}
