import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../service_locator.dart';
import '../constants.dart';
import '../error/app_exceptions.dart';
import '../params/params_model.dart';
import '../state/appstate.dart';

abstract class RemoteDataSource {
  // Client client = Client();
  final baseUrl = BaseUrl;
  var token;
  String? refreshToken;
  static final _dio = Dio(BaseOptions(
    receiveTimeout: 20000, // 15 seconds
    connectTimeout: 15000,
    sendTimeout: 15000,
  ));

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  RemoteDataSource() {
    // add base headers
    headers.addAll({});
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw new NoInternetException();
    }
  }

  Future<dynamic> get(ParamsModel model, {bool withToken = true}) async {
    var responseJson;
    var response;

    try {
      if (withToken) {
        initTokenAndHeaders();
      } else {
        headers.remove("Authorization");
      }
      await checkConnectivity();
      final url = model.baseUrl ?? baseUrl;
      response = await _dio.get(
        url + model.url.toString(),
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
        queryParameters: model.urlParams,
      );
      if (response == null) throw FetchDataException();
      responseJson = _returnResponse(response);
      print('post response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw e;
    }
    return responseJson;
  }

  Future<dynamic> put(ParamsModel model, {bool withToken = true}) async {
    var responseJson;
    var response;

    try {
      if (withToken) {
        initTokenAndHeaders();
      } else {
        headers.remove("Authorization");
      }

      await checkConnectivity();
      final url = model.baseUrl ?? baseUrl;
      response = await _dio.put(
        url + model.url.toString(),
        data: model.body!.toJson(),
        options: Options(
          headers: headers,
          // responseType: ResponseType.plain,
        ),
        queryParameters: model.urlParams,
      );

      if (response == null) throw FetchDataException();
//      responseJson = json.decode(response.body.toString());
      responseJson = _returnResponse(response);
      print('post response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw e;
    }
    return responseJson;
  }

  initTokenAndHeaders() {
    // token header
    // token = sl<AppStateModel>().user!.token;
    headers.remove("Authorization");

    print('token :$token');
    if (token != null)
      headers.putIfAbsent("Authorization", () => "Bearer $token");

    print(headers);
  }

  Future<dynamic> post(ParamsModel model, {bool withToken = true}) async {
    var response;
    var responseJson;
    try {
      if (withToken) {
        initTokenAndHeaders();
      } else {
        headers.remove("Authorization");
      }
      await checkConnectivity();

      final url = model.baseUrl ?? baseUrl;
      response = await _dio.post(
        url + model.url.toString(),
        data: model.body!.toJson(),
        queryParameters: model.urlParams,
        options: Options(headers: this.headers),
      );
      print("post request completed");

      if (response == null) throw FetchDataException();
//      responseJson = json.decode(response.body.toString());
      responseJson = _returnResponse(response);
      print('post response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw NoInternetException();
      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw e;
    }

    return responseJson;
  }

  Future<dynamic> delete(ParamsModel model, {bool withToken = true}) async {
    var responseJson;
    var response;

    try {
      if (withToken) {
        initTokenAndHeaders();
      } else {
        headers.remove("Authorization");
      }
      await checkConnectivity();
      final url = model.baseUrl ?? baseUrl;
      response = await _dio.delete(
        url + model.url.toString(),
        options: Options(
          headers: headers,
          responseType: ResponseType.plain,
        ),
        queryParameters: model.urlParams,
      );
      if (response == null) throw FetchDataException();
      responseJson = _returnResponse(response);
      print('post response: $responseJson');
    } on DioError catch (e) {
      if (e.response == null) throw CacheException();

      _returnResponse(e.response!);
    } on Exception catch (e) {
      throw CacheException();
    }
    return responseJson;
  }

  _returnResponse(Response response) {
    var responseJson =
        response.toString().isEmpty ? null : json.decode(response.toString());
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (responseJson == null) {
          throw InvalidInputException(
            message: "error happened",
          );
        }
        return responseJson;
      case 400:
      case 422:
        throw FetchDataException(message: responseJson["message"]);
      case 409:
        throw InvalidInputException(
          message: responseJson["error"]["message"],
        );

      case 401:
      case 403:
        throw FetchDataException(message: responseJson["message"]);
      case 404:
      case 405:
        throw InvalidInputException(
            message: responseJson["message"], data: responseJson["data"]);
      case 400:
        throw BadRequestException(data: responseJson);
      case 500:
        throw ServerErrorException(data: responseJson);
      default:
        throw InvalidInputException(
          message: "error happened",
        );
    }
  }
}
