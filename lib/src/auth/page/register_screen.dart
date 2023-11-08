import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/auth/controller/auth_controller.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../../../widgets/custom_buttons.dart';
import '../../constant/app_color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCon = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/image/png/KOFI LOGO-01 1.png',
          height: 100,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextFormFiled(
                controller: authCon.nameController.value,
                lable: "UserName",
                hintText: "Please Enter your username",
                onChanged: (v) {},
                validator: (v) =>
                    v == '' ? Intl.message("Invalid Username") : null,
              ),
              CustomTextFormFiled(
                controller: authCon.emailController.value,
                lable: "Email Address",
                hintText: "Please Enter your email",
                onChanged: (v) {},
                validator: (v) =>
                    v == '' ? Intl.message("Invalid Email Address") : null,
              ),
              CustomTextFormFiled(
                controller: authCon.pwController.value,
                lable: "Password",
                obscureText: authCon.hidePassword.value,
                suffixIcon: IconButton(
                    onPressed: () {
                      authCon.hidePassword.value = !authCon.hidePassword.value;
                    },
                    icon: authCon.hidePassword.value
                        ? Icon(
                            Icons.visibility_rounded,
                            color: AppColors.primaryColor,
                          )
                        : Icon(Icons.visibility_off,
                            color: AppColors.primaryColor)),
                hintText: "Please Enter your password",
                validator: (v) =>
                    v == '' ? Intl.message("Invalid Password") : null,
                onChanged: (v) {},
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("========> go to forget pw screen");
                    },
                    child: Text(
                      "Forget password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButtons(
                  title: 'Register',
                  onTap: () {
                    debugPrint('============> 1 welcome to my page');
                    GoRouter.of(context).go("/room");
                  },
                ),
              ),
              const Spacer(),
              RichText(
                  text: TextSpan(
                      text: "Already Have an account!    ",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                      children: [
                    TextSpan(
                        text: "SIGNIN",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint("=======>go SIGNIN");
                            GoRouter.of(context).go('/login');
                          })
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
