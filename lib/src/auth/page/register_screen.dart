import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/generated/l10n.dart';
import 'package:meetroombooking/src/auth/controller/auth_controller.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/widgets/change_language_button.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../../../widgets/custom_buttons.dart';
import '../../constant/app_color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static final _formKey = GlobalKey<FormState>();

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
                          L.current.registerTitle,
                          style: TextStyle(
                            fontSize: 24,
                            fontVariations: [FontWeight.w600.getVariant],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: authCon.nameController.value,
                          lable: L.current.username,
                          onChanged: (v) {},
                          validator: (v) =>
                              v == '' ? Intl.message("Invalid Username") : null,
                        ),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: authCon.emailController.value,
                          keyboardType: TextInputType.emailAddress,
                          lable: L.current.email,
                          hintText: L.current.emailHintMgs,
                          onChanged: (v) {},
                          validator: (v) => v?.isEmail == false
                              ? Intl.message("Invalid Email Address")
                              : null,
                        ),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: authCon.pwController.value,
                          textInputAction: TextInputAction.done,
                          lable: L.current.password,
                          hintText: L.current.passwordHintMgs,
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
                                  : Icon(Icons.visibility_off,
                                      color: AppColors.primaryColor)),
                          validator: (v) => v == null || v == '' || v.length < 8
                              ? Intl.message("Invalid Password")
                              : null,
                          onChanged: (v) {},
                        ),
                        const SizedBox(height: 10),
                        CustomButtons(
                          title: L.current.register,
                          onTap: () {
                            final noError =
                                _formKey.currentState?.validate() == true;
                            if (noError) {
                              context.go('/rooms');
                            }
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
                  text: '${L.current.hasAccountMsg} ',
                  style: context.titleMedium,
                  children: [
                    TextSpan(
                      text: L.current.login,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/login');
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
