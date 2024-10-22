import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetroombooking/src/modouls/profile/controller/profile_controller.dart';
import 'package:meetroombooking/src/modouls/widget/custom_photo.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';
import '../../../../widgets/custom_showbottomsheet.dart';

class EditProfilePage extends StatefulWidget {
  final String? username;
  final String? email;
  final String? image;
  const EditProfilePage({super.key, this.email, this.username, this.image});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileCon = Get.put(ProfileController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    usernameController.text = widget.username!;
    emailContoller.text = widget.email!;
    profileCon.imageNetwork.value = widget.image!;
    //=======>  to clear both web and mobile
    profileCon.pickImageInBytes.value = null;
    profileCon.image = null;
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
        leading: IconButton(
            onPressed: () {
              context.go('/profile');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
        () => Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth:
                      context.width > 500 ? context.width * .3 : context.width),
              child: Column(
                children: [
                  CustomPhoto(
                    imageFile: profileCon.image,
                    imageNetwork: profileCon.imageNetwork.value,
                    imageWeb: profileCon.pickImageInBytes.value,
                    onTap: () {
                      if (kIsWeb) {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              width: 500,
                              // color: Colors.white,
                              child: CupertinoActionSheet(
                                actions: <Widget>[
                                  CupertinoActionSheetAction(
                                    child: const Text("Camera"),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      XFile? pickedFile =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      if (pickedFile != null) {
                                        profileCon.pickImageInBytes.value =
                                            await pickedFile.readAsBytes();
                                      }
                                      profileCon.update();
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                      child: const Text("Gallery"),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        XFile? pickedFile =
                                            await _picker.pickImage(
                                                source: ImageSource.gallery);
                                        if (pickedFile != null) {
                                          profileCon.pickImageInBytes.value =
                                              await pickedFile.readAsBytes();
                                        }
                                        profileCon.update();
                                        // debugPrint(
                                        //     'find image profile:${profileCon.pickImageInBytes.value}');
                                      }),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        Platform.isIOS
                            ? showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoActionSheet(
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        child: const Text("Camera"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final pickedFile =
                                              await _picker.pickImage(
                                                  source: ImageSource.camera);
                                          setState(() {
                                            if (pickedFile != null) {
                                              profileCon.image =
                                                  File(pickedFile.path);
                                            }
                                          });
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: const Text("Gallery"),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final pickedFile =
                                              await _picker.pickImage(
                                                  source: ImageSource.gallery);
                                          setState(() {
                                            if (pickedFile != null) {
                                              profileCon.image =
                                                  File(pickedFile.path);
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                              )
                            : showBottomsheet(
                                isDismissible: false,
                                enableDrag: false,
                                context: context,
                                height: context.height * 0.2,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15, bottom: 25),
                                onTapCamera: () async {
                                  Navigator.pop(context);
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  setState(() {
                                    if (pickedFile != null) {
                                      profileCon.image = File(pickedFile.path);
                                    }
                                  });
                                },
                                onTapCancel: () {
                                  context.pop();
                                },
                                onTapGallery: () async {
                                  Navigator.pop(context);
                                  final pickedFile = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  setState(() {
                                    if (pickedFile != null) {
                                      profileCon.image = File(pickedFile.path);
                                    }
                                  });
                                });
                      }
                    },
                  ),
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
                      profileCon.image != null
                          ? profileCon.uploadImage(
                              'http://localhost:3000/api/profile/update/image',
                              profileCon.image!)
                          : profileCon.pickImageInBytes.value != null
                              ? profileCon.uploadBytes(
                                  'http://localhost:3000/api/profile/upload/image',
                                  profileCon.pickImageInBytes.value!)
                              : profileCon.userModel.value.avatar ??
                                  Image.asset('assets/image/png/profile.png');
                      context.go('/profile');
                    },
                    title: 'Update',
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
