import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';

class UpdateTaskParams extends ParamsModel<UpdateTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.PUT;

  @override
  String? get url => 'todos/${body!.taskId}';

  @override
  Map<String, String> get urlParams => {};

  UpdateTaskParams({UpdateTaskParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class UpdateTaskParamsBody extends BaseBodyModel {
  final bool completed;
  final int taskId;

  Map<String, dynamic> toJson() {
    return {
      'completed': completed,
    };
  }

  UpdateTaskParamsBody({
    required this.completed,
    required this.taskId,
  });
}
