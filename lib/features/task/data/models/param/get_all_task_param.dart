
import '../../../../../core/constants.dart';
import '../../../../../core/params/params_model.dart';



class GetAllTaskParams extends ParamsModel<GetAllTaskParamsBody> {
  @override
  Map<String, String>? get additionalHeaders => {};

  @override
  RequestType? get requestType => RequestType.GET;

  @override
  String? get url => '/api/users';

  @override
  Map<String, String> get urlParams => {
     'page': body!.pageNumber.toString()
  };

  GetAllTaskParams({GetAllTaskParamsBody? body}) : super(body: body, baseUrl: BaseUrl);

  @override
  List<Object?> get props => [url, urlParams, requestType, body];
}

class GetAllTaskParamsBody extends BaseBodyModel {

  final int? pageNumber;

  Map<String, dynamic> toJson() {
    return {
      };
  }

  GetAllTaskParamsBody({required this.pageNumber}
    );
}
