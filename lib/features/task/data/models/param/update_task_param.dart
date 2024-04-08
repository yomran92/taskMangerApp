
import 'package:todoapp/features/task/data/models/task_model.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';



class UpdateTaskParams extends ParamsModel<UpdateTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.PUT;

  @override
  String? get url => '/api/users';

  @override
  Map<String, String> get urlParams => {};

  UpdateTaskParams({UpdateTaskParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class UpdateTaskParamsBody extends BaseBodyModel {
  final TaskModel task;


  Map<String, dynamic> toJson() {
    return {
      'task': task,
    };
  }

  UpdateTaskParamsBody({
    required this.task,
  });
}
