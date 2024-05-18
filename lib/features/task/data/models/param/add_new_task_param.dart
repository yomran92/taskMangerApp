import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';

class AddTaskParams extends ParamsModel<AddTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => 'todos/add';

  @override
  Map<String, String> get urlParams => {};

  AddTaskParams({AddTaskParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class AddTaskParamsBody extends BaseBodyModel {
  String? todo;

  bool? completed;

  int? userId;

  Map<String, dynamic> toJson() {
    return {
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  AddTaskParamsBody({
    required this.todo,
    required this.completed,
    required this.userId,
  });
}
