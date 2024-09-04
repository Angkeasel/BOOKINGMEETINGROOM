// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:meetroombooking/generated/l10n.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/widgets/change_language_button.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../../constant/app_color.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static final _formKey = GlobalKey<FormState>();
  final lController = Get.find<LanguageController>();
  final authCon = Get.put(AuthController());
  @override
  void initState() {
    authCon.emailController.text = '';
    authCon.pwController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/image/png/KOFI LOGO-01 1.png',
          height: 100,
        ),
        elevation: 0,
        actions: const [ChangeLanguageButton(), SizedBox(width: 10)],
      ),
      body: SafeArea(
        minimum: defaultMinSafeArea,
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: context.height * .05),
                        Text(
                          "Kofi Room Reservation",
                          style: TextStyle(
                            fontSize: 24,
                            fontVariations: [FontWeight.w600.getVariant],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFormFiled(
                          lable: L.current.email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          hintText: L.current.emailHintMgs,
                          controller: authCon.emailController,
                          onChanged: (v) {},
                          validator: (v) =>
                              v == '' ? Intl.message("Invalid Username") : null,
                        ),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          lable: L.current.password,
                          textInputAction: TextInputAction.done,
                          hintText: L.current.passwordHintMgs,
                          controller: authCon.pwController,
                          onChanged: (v) {},
                          obscureText: authCon.hidePassword.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              authCon.hidePassword.value =
                                  !authCon.hidePassword.value;
                            },
                            icon: Icon(
                              authCon.hidePassword.value
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          validator: (v) => v == null || v == '' || v.length < 6
                              ? Intl.message("Invalid Password")
                              : null,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              debugPrint("========> go to forget pw screen");
                            },
                            child: Text(
                              L.current.forgetPassword,
                              style: context.labelLarge.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButtons(
                          title: L.current.login,
                          onTap: () {
                            const noError =
                                // _formKey.currentState?.validate() ==
                                true;
                            if (noError) {
                              // context.go('/rooms');
                              authCon.onLogin();
                            }
                            // final fontController =
                            //     Get.find<LanguageController>();
                            // if (fontController.locale == const Locale('en')) {
                            //   fontController.changeLanguage(Language.km);
                            // } else {
                            //   fontController.changeLanguage(Language.en);
                            // }
                            // setState(() {});
                          },
                        ),
                      ],
                    ).animate().slideY(
                          begin: .05,
                          end: 0,
                          duration: 200.ms,
                        ),
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${L.current.noAccountMsg} ',
                  style: context.titleMedium.copyWith(
                      // fontFamily: 'KantumruyPro',
                      // color: Colors.black,
                      // fontSize: 18,
                      ),
                  // style: const TextStyle(
                  //   inherit: true,
                  //   color: Colors.black,
                  //   fontSize: 18,
                  // ),
                  children: [
                    TextSpan(
                      text: L.current.register,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          debugPrint("=======>go REGISTER");
                          GoRouter.of(context).go('/register');
                        },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
