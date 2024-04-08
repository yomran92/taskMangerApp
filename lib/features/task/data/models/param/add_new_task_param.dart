import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';
import '../task_model.dart';



class AddTaskParams extends ParamsModel<AddTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => '/api/users';

  @override
  Map<String, String> get urlParams => {};

  AddTaskParams({AddTaskParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class AddTaskParamsBody extends BaseBodyModel {
  final TaskModel task;


  Map<String, dynamic> toJson() {
    return {
      'task': task,
     };
  }

  AddTaskParamsBody({
   required this.task,
   });
}
