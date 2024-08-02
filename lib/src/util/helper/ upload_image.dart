// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:http/http.dart' as http;

// class UploadFileImage {
//   Future<dynamic> uploadImage(Uint8List bytes, String fileName) async {
//     Uri url = Uri.parse('http://localhost:8000/api/profile/upload');
//     var request = http.MultipartRequest("POST", url);
//     var myFile = http.MultipartFile(
//         "profile", http.ByteStream.fromBytes(bytes), bytes.length,
//         filename: fileName);
//     request.files.add(myFile);
//     final response = await request.send();
//     if (response.statusCode == 201) {
//       var data = await response.stream.bytesToString();
//       return jsonDecode(data);
//     } else {
//       return null;
//     }
//   }
// }

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'local_storage/local_storage.dart';

class FileUpload {
  late Dio dio;
  FileUpload() {
    dio = Dio();
  }

  Future<Response> uploadImage({
    required File file,
    required String keyName,
    required String url,
  }) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      keyName: await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final token = await LocalStorage.getStringValue(key: 'access_token');
    var response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );

    debugPrint('submit url: $url');
    debugPrint('submit keyName: $keyName');
    debugPrint('submit file: $file');
    return response;
  }
}
