import 'package:flutter/foundation.dart';
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
    // final isResponsive = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: kIsWeb
            ? const SizedBox()
            : Image.asset(
                'assets/image/png/KOFI LOGO-01 1.png',
                height: 100,
              ),
        elevation: 0,
        actions: const [
          kIsWeb ? SizedBox() : ChangeLanguageButton(),
          SizedBox(width: 10)
        ],
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
                            : context.width * 0.8),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
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
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //image
                                      Image.asset(
                                        'assets/image/png/KOFI LOGO-01 1.png',
                                        height: 120,
                                      ),
                                      Text(
                                        "Kofi Room Reservation",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors.primaryColor,
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
                                          lable: L.current.email,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          hintText: L.current.emailHintMgs,
                                          controller: authCon.emailController,
                                          onChanged: (v) {},
                                          validator: (v) => v == ''
                                              ? Intl.message("Invalid Username")
                                              : null,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: context.width > 500
                                                    ? context.width * .3
                                                    : context.width),
                                            child: CustomTextFormFiled(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              lable: L.current.password,
                                              textInputAction:
                                                  TextInputAction.done,
                                              hintText:
                                                  L.current.passwordHintMgs,
                                              controller: authCon.pwController,
                                              onChanged: (v) {},
                                              obscureText:
                                                  authCon.hidePassword.value,
                                              suffixIcon: IconButton(
                                                onPressed: () {
                                                  authCon.hidePassword.value =
                                                      !authCon
                                                          .hidePassword.value;
                                                },
                                                icon: Icon(
                                                  authCon.hidePassword.value
                                                      ? Icons.visibility_rounded
                                                      : Icons.visibility_off,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                              validator: (v) => v == null ||
                                                      v == '' ||
                                                      v.length < 6
                                                  ? Intl.message(
                                                      "Invalid Password")
                                                  : null,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              debugPrint(
                                                  "========> go to forget pw screen");
                                            },
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              L.current.forgetPassword,
                                              style:
                                                  context.labelLarge.copyWith(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20),
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
                            const SizedBox(
                              height: 60,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
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
                                  ),
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
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: context.height * .05),
                                  Text(
                                    "Kofi Room Reservation",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontVariations: [
                                        FontWeight.w600.getVariant
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  CustomTextFormFiled(
                                    lable: L.current.email,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    hintText: L.current.emailHintMgs,
                                    controller: authCon.emailController,
                                    onChanged: (v) {},
                                    validator: (v) => v == ''
                                        ? Intl.message("Invalid Username")
                                        : null,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomTextFormFiled(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
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
                                        validator: (v) => v == null ||
                                                v == '' ||
                                                v.length < 6
                                            ? Intl.message("Invalid Password")
                                            : null,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          debugPrint(
                                              "========> go to forget pw screen");
                                        },
                                        child: SizedBox(
                                          child: Text(
                                            textAlign: TextAlign.right,
                                            L.current.forgetPassword,
                                            style: context.labelLarge.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                        const SizedBox(
                          height: 40,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: '${L.current.hasAccountMsg} ',
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
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
