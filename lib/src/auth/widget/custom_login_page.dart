
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:meetroombooking/src/constant/app_textstyle.dart';

// import '../../../generated/l10n.dart';
// import '../../../widgets/change_language_button.dart';
// import '../../../widgets/custom_buttons.dart';
// import '../../../widgets/custom_text_form_filed.dart';
// import '../../config/font/font_controller.dart';
// import '../../constant/app_color.dart';
// import '../../constant/app_size.dart';
// import '../controller/auth_controller.dart';

// class CustomLoginPage extends StatefulWidget {
//   final double? screen;
//   const CustomLoginPage({super.key, this.screen});

//   @override
//   State<CustomLoginPage> createState() => _CustomLoginPageState();
// }

// class _CustomLoginPageState extends State<CustomLoginPage> {
//   static final _formKey = GlobalKey<FormState>();
//   final lController = Get.find<LanguageController>();
//   final authCon = Get.put(AuthController());

//   @override
//   void initState() {
//     authCon.emailController.text = '';
//     authCon.pwController.text = '';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return Column(
//                     children: [
//                       isResponsive
//                           ? const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Align(
//                                 alignment: Alignment.centerRight,
//                                 child: SizedBox(
//                                     height: 50, child: ChangeLanguageButton()),
//                               ),
//                             )
//                           : const SizedBox(),
//                       isResponsive
//                           ? Image.asset(
//                               'assets/image/png/KOFI LOGO-01 1.png',
//                               height: 120,
//                             )
//                           : const SizedBox(),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: padding),
//                           child: Form(
//                             key: _formKey,
//                             child: Center(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(height: context.height * .02),
//                                   Text(
//                                     "Kofi Room Reservation",
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontVariations: [
//                                         FontWeight.w600.getVariant
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 30),
//                                   CustomTextFormFiled(
//                                     width: isResponsive
//                                         ? context.width * 0.3
//                                         : context.width,
//                                     lable: L.current.email,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     keyboardType: TextInputType.emailAddress,
//                                     hintText: L.current.emailHintMgs,
//                                     controller: authCon.emailController,
//                                     onChanged: (v) {},
//                                     validator: (v) => v == ''
//                                         ? Intl.message("Invalid Username")
//                                         : null,
//                                   ),
//                                   CustomTextFormFiled(
//                                     width: isResponsive
//                                         ? context.width * 0.3
//                                         : context.width,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     lable: L.current.password,
//                                     textInputAction: TextInputAction.done,
//                                     hintText: L.current.passwordHintMgs,
//                                     controller: authCon.pwController,
//                                     onChanged: (v) {},
//                                     obscureText: authCon.hidePassword.value,
//                                     suffixIcon: IconButton(
//                                       onPressed: () {
//                                         authCon.hidePassword.value =
//                                             !authCon.hidePassword.value;
//                                       },
//                                       icon: Icon(
//                                         authCon.hidePassword.value
//                                             ? Icons.visibility_rounded
//                                             : Icons.visibility_off,
//                                         color: AppColors.primaryColor,
//                                       ),
//                                     ),
//                                     validator: (v) =>
//                                         v == null || v == '' || v.length < 6
//                                             ? Intl.message("Invalid Password")
//                                             : null,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       debugPrint(
//                                           "========> go to forget pw screen");
//                                     },
//                                     child: SizedBox(
//                                       width: isResponsive
//                                           ? context.width * 0.3
//                                           : context.width,
//                                       child: Text(
//                                         textAlign: TextAlign.right,
//                                         L.current.forgetPassword,
//                                         style: context.labelLarge.copyWith(
//                                           color: AppColors.primaryColor,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 30),
//                                   CustomButtons(
//                                     width: isResponsive
//                                         ? context.width * 0.3
//                                         : context.width,
//                                     title: L.current.login,
//                                     onTap: () {
//                                       const noError =
//                                           // _formKey.currentState?.validate() ==
//                                           true;
//                                       if (noError) {
//                                         // context.go('/rooms');
//                                         authCon.onLogin();
//                                       }
//                                       // final fontController =
//                                       //     Get.find<LanguageController>();
//                                       // if (fontController.locale == const Locale('en')) {
//                                       //   fontController.changeLanguage(Language.km);
//                                       // } else {
//                                       //   fontController.changeLanguage(Language.en);
//                                       // }
//                                       // setState(() {});
//                                     },
//                                   ),
//                                 ],
//                               ).animate().slideY(
//                                     begin: .05,
//                                     end: 0,
//                                     duration: 200.ms,
//                                   ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       RichText(
//                         text: TextSpan(
//                           text: '${L.current.noAccountMsg} ',
//                           style: context.titleMedium.copyWith(
//                               // fontFamily: 'KantumruyPro',
//                               // color: Colors.black,
//                               // fontSize: 18,
//                               ),
//                           // style: const TextStyle(
//                           //   inherit: true,
//                           //   color: Colors.black,
//                           //   fontSize: 18,
//                           // ),
//                           children: [
//                             TextSpan(
//                               text: L.current.register,
//                               style: TextStyle(
//                                 color: AppColors.primaryColor,
//                                 decoration: TextDecoration.underline,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   debugPrint("=======>go REGISTER");
//                                   GoRouter.of(context).go('/register');
//                                 },
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       )
//                     ],
//                   );
//   }
// }
