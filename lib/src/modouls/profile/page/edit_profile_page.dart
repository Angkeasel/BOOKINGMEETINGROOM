import 'package:flutter/material.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../model/userModel.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel? userModel;
  const EditProfilePage({super.key, this.userModel});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();

  @override
  void initState() {
    usernameController.text = widget.userModel!.username!;
    emailContoller.text = widget.userModel!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
        child: Column(
          children: [
            CustomTextFormFiled(
              controller: usernameController,
              title: 'UserName',
            ),
            CustomTextFormFiled(
              controller: emailContoller,
              title: 'Email',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButtons(
              onTap: () {
                debugPrint('======> update profile info');
              },
              title: 'Update',
            )
          ],
        ),
      ),
    );
  }
}
