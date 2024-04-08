import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';

class DeleteTodoParams {
  final String id;

  DeleteTodoParams({required this.id});
}

class DeleteTaskParams extends ParamsModel<DeleteTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.DELETE;

  @override
  String? get url => '/api/users';

  @override
  Map<String, String> get urlParams => {};

  DeleteTaskParams({DeleteTaskParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class DeleteTaskParamsBody extends BaseBodyModel {
  final String id;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }

  DeleteTaskParamsBody({
    required this.id,
  });
}
