import 'package:flutter/material.dart';

import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/widget/custom_details_profile.dart';

import '../../../constant/app_color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile page',
        ),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber),
                child: Image.asset('assets/image/png/profile.png'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const CustomDetailProfile(
              lable: 'UserName',
              value: 'Muykea',
            ),
            const CustomDetailProfile(
              lable: 'Email',
              value: 'muykea@gmail.com',
            ),
            const CustomDetailProfile(
              lable: 'Gender',
              value: 'Female',
            ),
            const CustomDetailProfile(
              lable: 'Position',
              value: 'App programmer',
            ),
            const CustomDetailProfile(
              lable: 'ForgetPassword',
              icons: true,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                debugPrint('logout');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
