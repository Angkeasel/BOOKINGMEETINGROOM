import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meetroombooking/src/util/helper/api_base_helper.dart';
import '../../../util/helper/local_storage/local_storage.dart';
import '../model/userModel.dart';

class ProfileController extends GetxController {
  final api = ApiBaseHelper();
  final imageNetwork = ''.obs;
  File? image;
  Rx<Uint8List?> pickImageInBytes = Rx(null);
  Future<void> uploadBytes(String url, Uint8List imageBytes) async {
    final token = await LocalStorage.getStringValue(key: 'access_token');
    debugPrint('=======> token :$token');
    var request = http.MultipartRequest("PUT", Uri.parse(url));
    request.headers.assignAll({"Authorization": "Bearer $token"});
    request.files.add(http.MultipartFile.fromBytes('profile', imageBytes,
        filename: 'image.jpg'));
    debugPrint('======> uplosdBytes $request');
    final response = await request.send();
    if (response.statusCode == 200) {
      debugPrint('Image uploaded successfully');
      await getProfile();
    } else {
      debugPrint('Image upload failed with status: ${response.statusCode}');
    }
  }

  //====================> Pick Image <========================
  Future<void> uploadImage(String url, File image) async {
    final token = await LocalStorage.getStringValue(key: 'access_token');
    debugPrint('=======> token :$token');
    final request = http.MultipartRequest('PUT', Uri.parse(url));
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
      await getProfile();
    } else {
      debugPrint('Image upload failed with status: ${response.statusCode}');
    }
  }

// ==========================> upload image with api <=========================
  // Future<void> uploadImages() async {}

  //=======================> get profile <=========================
  final userModel = UserModel().obs;
  final isLoading = false.obs;
  Future<UserModel> getProfile() async {
    try {
      isLoading(true);
      await api
          .onNetworkRequesting(
              url: '/profile/info', methode: METHODE.get, isAuthorize: true)
          .then((value) {
        debugPrint('show profile information : $value ');
        userModel.value = UserModel.fromJson(value['profile']);
        debugPrint('====> test value : ${userModel.value}');
        isLoading(false);
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

  // ========================> Update Profile Info <=============================
  Future<void> updateProfile({String? userName, String? email}) async {
    final body = {"username": userName, "email": email};
    try {
      await api
          .onNetworkRequesting(
              url: '/profile/update/info',
              methode: METHODE.update,
              isAuthorize: true,
              body: body)
          .then((value) {
        debugPrint('===========> update Profile Info $value');
      });
    } catch (e) {
      debugPrint('err catch profile information $e');
    }
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
