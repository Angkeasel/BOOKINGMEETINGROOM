import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../../constant/app_color.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCon = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/image/png/KOFI LOGO-01 1.png',
          height: 100,
        ),
        elevation: 0,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Kofi Room Reservation",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextFormFiled(
                  lable: 'Email Address',
                  hintText: 'Please Enter Your Email Address',
                  controller: authCon.emailController.value,
                  onChanged: (v) {},
                ),
                CustomTextFormFiled(
                  lable: 'Password',
                  hintText: 'Please Enter Your Password',
                  controller: authCon.pwController.value,
                  onChanged: (v) {},
                  obscureText: authCon.hidePassword.value,
                  suffixIcon: IconButton(
                      onPressed: () {
                        authCon.hidePassword.value =
                            !authCon.hidePassword.value;
                      },
                      icon: authCon.hidePassword.value
                          ? Icon(
                              Icons.visibility_rounded,
                              color: AppColors.primaryColor,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: AppColors.primaryColor,
                            )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButtons(
                    title: 'Login',
                    onTap: () {
                      GoRouter.of(context).go("/room");
                    },
                  ),
                ),
                const Spacer(),
                RichText(
                    text: TextSpan(
                        text: "Don't Have an account yet?  ",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                        children: [
                      TextSpan(
                          text: 'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint("=======>go REGISTER");
                              GoRouter.of(context).go('/register');
                            })
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
