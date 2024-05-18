import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';
import '../../../../../core/state/appstate.dart';
import '../../../../../service_locator.dart';

class GetAllTaskParams extends ParamsModel<GetAllTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => 'todos/user/${sl<AppStateModel>().user!.id}';

  @override
  Map<String, String> get urlParams => {
        'limit': body!.limit.toString(),
        'skip': body!.skip.toString(),
      };

  GetAllTaskParams({GetAllTaskParamsBody? body})
      : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetAllTaskParamsBody extends BaseBodyModel {
  final int? limit;
  final int? skip;

  Map<String, dynamic> toJson() {
    return {};
  }

  GetAllTaskParamsBody({required this.skip, required this.limit});
}
