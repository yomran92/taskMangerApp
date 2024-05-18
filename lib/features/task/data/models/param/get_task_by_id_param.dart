import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';

class GetTaskByIDParams extends ParamsModel<GetTaskByIDParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'todos/${body!.id}';

  @override
  Map<String, String> get urlParams => {};

  GetTaskByIDParams({GetTaskByIDParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetTaskByIDParamsBody extends BaseBodyModel {
  final int id;

  Map<String, dynamic> toJson() {
    return {};
  }

  GetTaskByIDParamsBody({required this.id});
}
