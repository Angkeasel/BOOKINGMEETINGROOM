import 'package:flutter/foundation.dart';
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
        title: kIsWeb
            ? const SizedBox()
            : Image.asset(
                'assets/image/png/KOFI LOGO-01 1.png',
                height: 100,
              ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: kIsWeb
            ? []
            : [const ChangeLanguageButton(), const SizedBox(width: 10)],
      ),
      body: SafeArea(
        minimum: defaultMinSafeArea,
        child: Obx(
          () => Center(
            child: kIsWeb
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.width > 500
                          ? context.width * 0.4
                          : context.width * .8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, right: 10),
                              height: 50,
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: ChangeLanguageButton(),
                              ),
                            ),
                            Expanded(
                              flex: -1,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/image/png/KOFI LOGO-01 1.png',
                                      height: 100,
                                    ),
                                    Text(
                                      L.current.registerTitle,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontVariations: [
                                          FontWeight.w600.getVariant
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: context.width > 500
                                              ? context.width * .3
                                              : context.width),
                                      child: CustomTextFormFiled(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: authCon.nameController,
                                        lable: L.current.username,
                                        onChanged: (v) {},
                                        validator: (v) => v == ''
                                            ? Intl.message("Invalid Username")
                                            : null,
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: context.width > 500
                                              ? context.width * .3
                                              : context.width),
                                      child: CustomTextFormFiled(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: authCon.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        lable: L.current.email,
                                        hintText: L.current.emailHintMgs,
                                        onChanged: (v) {},
                                        validator: (v) => v?.isEmail == false
                                            ? Intl.message(
                                                "Invalid Email Address")
                                            : null,
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: context.width > 500
                                              ? context.width * .3
                                              : context.width),
                                      child: CustomTextFormFiled(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: authCon.pwController,
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
                                                    color:
                                                        AppColors.primaryColor,
                                                  )
                                                : Icon(Icons.visibility_off,
                                                    color: AppColors
                                                        .primaryColor)),
                                        validator: (v) => v == null ||
                                                v == '' ||
                                                v.length < 8
                                            ? Intl.message("Invalid Password")
                                            : null,
                                        onChanged: (v) {},
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    CustomButtons(
                                      title: L.current.register,
                                      onTap: () {
                                        final noError =
                                            _formKey.currentState?.validate() ==
                                                true;
                                        if (noError) {
                                          // context.go('/rooms');

                                          authCon.onRegister();
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
                            const SizedBox(
                              height: 60,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
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
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: -1,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: context.height * .05),
                                Text(
                                  L.current.registerTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontVariations: [
                                      FontWeight.w600.getVariant
                                    ],
                                  ),
                                ),
                                SizedBox(height: context.height * .05),
                                CustomTextFormFiled(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: authCon.nameController,
                                  lable: L.current.username,
                                  onChanged: (v) {},
                                  validator: (v) => v == ''
                                      ? Intl.message("Invalid Username")
                                      : null,
                                ),
                                CustomTextFormFiled(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: authCon.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  lable: L.current.email,
                                  hintText: L.current.emailHintMgs,
                                  onChanged: (v) {},
                                  validator: (v) => v?.isEmail == false
                                      ? Intl.message("Invalid Email Address")
                                      : null,
                                ),
                                CustomTextFormFiled(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: authCon.pwController,
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
                                  validator: (v) =>
                                      v == null || v == '' || v.length < 8
                                          ? Intl.message("Invalid Password")
                                          : null,
                                  onChanged: (v) {},
                                ),
                                const SizedBox(height: 10),
                                CustomButtons(
                                  title: L.current.register,
                                  onTap: () {
                                    final noError =
                                        _formKey.currentState?.validate() ==
                                            true;
                                    if (noError) {
                                      // context.go('/rooms');

                                      authCon.onRegister();
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
                        // const SizedBox(
                        //   height: 60,
                        // ),
                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     text: '${L.current.hasAccountMsg} ',
                        //     style: context.titleMedium,
                        //     children: [
                        //       TextSpan(
                        //         text: L.current.login,
                        //         style: TextStyle(
                        //           color: AppColors.primaryColor,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             context.go('/login');
                        //           },
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
