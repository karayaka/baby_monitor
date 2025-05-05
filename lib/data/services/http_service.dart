import 'dart:async';
import 'dart:io';
import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/models/base_models/base_http_model.dart';
import 'package:baby_monitor/models/base_models/base_result.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class HttpService {
  static HttpService? _instance;
  static HttpService? get instance {
    _instance ??= HttpService._init();
    return _instance;
  }

  Dio? _dio;
  HttpService._init() {
    var header = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'AppKey': ProjectConst.APP_KEY,
    };
    final baseOptions = BaseOptions(
        contentType: Headers.jsonContentType,
        headers: header,
        baseUrl: ProjectUrls.base_url);

    _dio = Dio(baseOptions);
  }
  Future<Response?> basePost(String path, Object? data,
      {String? token = ""}) async {
    try {
      (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      _dio?.options.headers.addAll({"Authorization": "Bearer $token"});
      return await _dio?.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> post<T extends BaseHttpModel?>(
      String path, T? model, Object? data,
      {String? token}) async {
    try {
      final response = await basePost(path, data, token: token);
      var res = _resultBody(response, model);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> get<T extends BaseHttpModel?>(String path, T? model,
      {Map<String, dynamic>? params, String token = ""}) async {
    try {
      _dio?.options.headers.addAll({"Authorization": "Bearer $token"});
      final response = await _dio?.get(path, queryParameters: params);
      return _resultBody(response, model);
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResult> delete<T extends BaseHttpModel?>(String path, T? model,
      {String? token}) async {
    try {
      _dio?.options.headers.addAll({"Authorization": "Bearer $token"});
      final response = await _dio?.delete(path);
      return _resultBody(response, model);
    } catch (e) {
      rethrow;
    }
  }

  BaseResult _resultBody<T extends BaseHttpModel?>(
      Response? response, T? model) {
    try {
      var result = BaseResult();
      result.statusCode = response?.statusCode ?? 400;
      if (response?.statusCode == 200) {
        var data = response?.data;
        result.message = data["message"];
        var dataBody = data["data"];
        if (dataBody is int || dataBody is bool || dataBody is String) {
          result.data = dataBody;
        } else if (dataBody != null && model != null) {
          result.data = _prepareData(dataBody, model);
        }
        return result;
      } else {
        result.message = "gl002";
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  _prepareData<T extends BaseHttpModel?>(body, T model) {
    try {
      if (model != null) {
        if (body is List) {
          return body.map((e) => model.fromJson(e)).cast<T>().toList();
        } else {
          T fechData = model.fromJson(body);
          return fechData;
        }
      }
    } catch (x) {
      rethrow;
    }
  }
}
