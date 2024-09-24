import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/util/helper/api_base_helper.dart';
import 'package:meetroombooking/src/util/helper/snackbar/alert_snackbar.dart';
import '../../config/router/router.dart';
import '../../util/helper/local_storage/local_storage.dart';

class AuthController extends GetxController {
  ApiBaseHelper api = ApiBaseHelper();
  final hidePassword = true.obs;
  var signUpLoading = false.obs;
  var isLoading = false.obs;
// textfiled register & login
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
// Register
  Future<void> onRegister() async {
    signUpLoading.value = true;
    try {
      var bodys = {
        "username": nameController.text,
        "email": emailController.text,
        "password": pwController.text
      };
      await api
          .onNetworkRequesting(
              url: '/auth/register/',
              methode: METHODE.post,
              isAuthorize: false,
              body: bodys)
          .then((response) async {
        debugPrint('on register to get token $response');
        await LocalStorage.storeData(
            key: "access_token", value: response['data']['access_token']);
        debugPrint('value ${response['data']['access_token']}');
        router.go('/rooms');
        signUpLoading(false);
      }).onError((ErrorModel error, stackTrace) {
        signUpLoading(false);
        alertErrorSnackbar(
            title: 'Error', message: error.bodyString['message'].toString());
        debugPrint('fail to register $error');
      });
    } catch (e) {
      debugPrint('Error show $e');
      alertErrorSnackbar(title: 'Error', message: e);
    }
  }

  // Login
  Future<void> onLogin() async {
    if (emailController.text.isEmpty || pwController.text.isEmpty) {
      alertErrorSnackbar(
          title: 'Error', message: 'Please input valid email or password');
    } else {
      isLoading(true);
      var loginBody = {
        "email": emailController.text,
        "password": pwController.text,
      };
      await api
          .onNetworkRequesting(
              url: '/auth/login',
              methode: METHODE.post,
              isAuthorize: false,
              body: loginBody)
          .then((value) async {
        debugPrint('login value : $value');
        debugPrint('accessToken: ${value['token']}');
        // var token = value['token'];
        // if (!token) {
        //   await LocalStorage.storeData(key: 'access_token', value: '');
        //   router.go('/login');
        // }
        await LocalStorage.storeData(
            key: 'access_token', value: value['token']);

        isLoading(false);
        router.go('/rooms');
      }).onError((ErrorModel error, stackTrace) {
        isLoading(false);

        alertErrorSnackbar(
            title: "Error", message: error.bodyString["message"].toString());
      });
    }
  }
}
