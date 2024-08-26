import 'package:flutter/material.dart';
import 'package:meetroombooking/src/modouls/profile/model/userModel.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

class EditProfilePage extends StatelessWidget {
  final UserModel? userModel;
  const EditProfilePage({super.key, this.userModel});
  //final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final profileCon = Get.put(ProfileController());
    // usernameController.text = userModel!.email!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
        child: Column(
          children: [
            CustomTextFormFiled(
                // controller: usernameController,
                ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormFiled(
                // controller: usernameController,
                ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormFiled(
                // controller: usernameController,
                ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormFiled(
                // controller: usernameController,
                ),
            SizedBox(
              height: 20,
            ),
            CustomButtons(
              title: 'Update',
            )
          ],
        ),
      ),
    );
  }
}
