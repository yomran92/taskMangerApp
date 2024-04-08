import 'package:equatable/equatable.dart';

import '../../data/remote/models/responses/user_model.dart';

class LogInEntity extends Equatable {
  late bool? success;
  late String? message;
 late UserModel userModel;

  LogInEntity(
      {this.success,
      this.message,
        required   this.userModel,
       });

  @override
  List<Object?> get props => [message];
}
