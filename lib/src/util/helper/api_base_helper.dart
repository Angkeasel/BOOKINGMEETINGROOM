import 'dart:convert';
// import 'package:get/get_connect.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'local_storage/local_storage.dart';

class ErrorModel {
  final int? statusCode;
  final dynamic bodyString;
  const ErrorModel({this.statusCode, this.bodyString});
}

enum METHODE {
  get,
  post,
  delete,
  update,
}

class ApiBaseHelper {
  //String? baseurl = dotenv.env['base_url'];
  String? baseurl = 'http://localhost:3000/api';
  // String? baseurl = 'http://10.0.2.2:3000/api';
  Future<dynamic> onNetworkRequesting({
    required String url,
    Map<String, String>? header,
    Map<String, dynamic>? body,
    required METHODE? methode,
    required bool isAuthorize,
    String baseUrl = '',
  }) async {
    if (baseUrl != '') baseurl = baseUrl;
    // var token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MjFlZTNiZGJjMTY5YTE2NjE4ZTk5YSIsImVtYWlsIjoiQWRtaW5AZ21haWwuY29tIiwidXNlcm5hbWUiOiJhZG1pbnMiLCJpYXQiOjE3MTUxNTczOTMsImV4cCI6MTcxNTI0Mzc5M30.JlugFgKmEwihlxka5RGc6LnU-1EFyocNvd0JofyIy-g';
    var token = await LocalStorage.getStringValue(key: "access_token");
    debugPrint('get token $token');
    final fullUrl = baseurl! + url;
    Map<String, String> headerDefault = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': isAuthorize ? 'Bearer $token' : '',
    };

    debugPrint('💎 $fullUrl');

    try {
      switch (methode) {
        case METHODE.get:
          final response = await http.get(Uri.parse(fullUrl),
              headers: header ?? headerDefault);
          return _returnResponse(response, fullUrl);
        case METHODE.post:
          if (body != null) {
            final response = await http.post(Uri.parse(fullUrl),
                body: json.encode(body), headers: headerDefault);
            debugPrint('RESPONSE :${response.statusCode} ');
            return _returnResponse(response, fullUrl);
          }
          return Future.error(
              const ErrorModel(bodyString: 'Body must be included'));
        case METHODE.delete:
          final response =
              await http.delete(Uri.parse(fullUrl), headers: headerDefault);
          return _returnResponse(response);
        case METHODE.update:
          if (body != null) {
            final response = await http.put(Uri.parse(fullUrl),
                body: json.encode(body), headers: headerDefault);
            return _returnResponse(response);
          }
          return Future.error(
              const ErrorModel(bodyString: 'Body must be included'));
        default:
          break;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  dynamic _returnResponse(response, [String url = '']) {
    switch (response.statusCode) {
      case 200:
        var responseJson = url.contains('goo.gl') || url.contains('google')
            ? response.body
            : json.decode(response.body);
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 202:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 404:
        return Future.error(ErrorModel(
            statusCode: response.statusCode,
            bodyString: url.contains('goo.gl') || url.contains('google')
                ? response.body
                : json.decode(response.body)));
      case 400:
        return Future.error(ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.body)));
      case 401:
      case 403:
        return Future.error(ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.body)));
      case 500:
        break;
      default:
        return Future.error(ErrorModel(
            statusCode: response.statusCode,
            bodyString: json.decode(response.body)));
    }
  }
}
