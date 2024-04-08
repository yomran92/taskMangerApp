import '../../../../../../core/constants.dart';
import '../../../../../../core/params/params_model.dart';

class LogInParams extends ParamsModel<LogInParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.POST;

  @override
  String? get url => '/api/login';

  @override
  Map<String, String> get urlParams => {};

  LogInParams({LogInParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class LogInParamsBody extends BaseBodyModel {
  final String? email;
  final String? password;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  LogInParamsBody({
    this.email,
    this.password,
  });
}
