import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meetroombooking/src/modouls/profile/model/userModel.dart';
import 'package:meetroombooking/src/util/helper/api_base_helper.dart';

import '../../../util/helper/local_storage/local_storage.dart';

class ProfileController extends GetxController {
  final api = ApiBaseHelper();
  //====================> Pick Image <========================
  Future<void> uploadImage(String url, File image) async {
    final token = await LocalStorage.getStringValue(key: 'access_token');
    debugPrint('=======> token :$token');
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.assignAll({"Authorization": "Bearer $token"});
    request.files.add(
      http.MultipartFile(
        'profile',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
        contentType: DioMediaType(
          'image',
          'jpg',
        ), // Change this as needed
      ),
    );
    final response = await request.send();
    if (response.statusCode == 200) {
      debugPrint('Image uploaded successfully');
    } else {
      debugPrint('Image upload failed with status: ${response.statusCode}');
    }
  }

// ==========================> upload image with api <=========================
  Future<void> uploadImages() async {}

  //=======================> get profile <=========================
  final userModel = UserModel().obs;
  final isLoading = false.obs;
  Future getProfile() async {
    isLoading(true);
    try {
      await api
          .onNetworkRequesting(
              url: '/profile/info', methode: METHODE.get, isAuthorize: true)
          .then((value) {
        debugPrint('show profile information : $value ');
        userModel.value = UserModel.fromJson(value);
      }).onError((ErrorModel error, stackTrace) {
        debugPrint("=========> get Profile Error $error");
        isLoading(false);
      });
    } catch (e) {
      debugPrint('err catch profile information $e');
      isLoading(false);
    }
    return userModel.value;
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
