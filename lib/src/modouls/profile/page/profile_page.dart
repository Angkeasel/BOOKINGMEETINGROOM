import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:image_picker/image_picker.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/profile/controller/profile_controller.dart';
import 'package:meetroombooking/src/modouls/profile/page/language_page.dart';
import 'package:meetroombooking/src/modouls/widget/custom_details_profile.dart';
import '../../../../widgets/custom_showbottomsheet.dart';
import '../../../constant/app_color.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final profileCon = Get.put(ProfileController());

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        debugPrint('=========> pickedFile path : ${pickedFile.path}');
        profileCon.uploadImage(
            'http://localhost:8000/api/profile/upload/profile', _image!);
      }
    });
  }

  @override
  void initState() {
    profileCon.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final profileCon = Get.put(ProfileController());
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
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/image/png/profile.png'),
                  ),
                  GetBuilder(
                    init: ProfileController(),
                    builder: (_) => GestureDetector(
                      onTap: () {
                        Platform.isIOS
                            ? showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoActionSheet(
                                    // title: const Text("Option"),
                                    actions: <Widget>[
                                      CupertinoActionSheetAction(
                                        child: const Text("Camera"),
                                        onPressed: () {
                                          pickImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: const Text("Gallery"),
                                        onPressed: () async {
                                          pickImage(ImageSource.gallery);

                                          Navigator.pop(context);
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
                                onTapCamera: () {
                                  pickImage(ImageSource.camera);
                                  context.pop();
                                },
                                onTapCancel: () {
                                  context.pop();
                                },
                                onTapGallery: () {
                                  pickImage(ImageSource.gallery);
                                  context.pop();
                                });

                        // onShowBottomSheet(
                        //   isDimissible: true,
                        //   enableDrag: true,
                        //   context: context,
                        //   height: context.height * 1 / 3,
                        //   child: Column(
                        //     children: [
                        //       Column(
                        //         children: [
                        //           CustomSeletedItemWidget(
                        //             label: 'View Photo',
                        //             onTap: () {
                        //               context.pop();
                        //               Navigator.of(context, rootNavigator: true)
                        //                   .push(
                        //                 MaterialPageRoute(
                        //                   builder: (context) => Container(),
                        //                   //         ImageViewFullScreen(
                        //                   //   imageFile:
                        //                   //       profileCon
                        //                   //           .imagePath
                        //                   //           .value,
                        //                   //   isImageFile: profileCon
                        //                   //           .imagePath
                        //                   //           .value
                        //                   //           .isNotEmpty
                        //                   //       ? true
                        //                   //       : false,
                        //                   //   isUrl: e.value.isLatest ==
                        //                   //               true ||
                        //                   //           e.value.imageUrl!.isNotEmpty &&
                        //                   //               profileCon.imagePath.value.isEmpty
                        //                   //       ? true
                        //                   //       : false,
                        //                   //   urlImage: e
                        //                   //       .value
                        //                   //       .imageUrl,
                        //                   // ),
                        //                   maintainState: false,
                        //                 ),
                        //               );
                        //             },
                        //           ),
                        //           Divider(
                        //             color: Colors.grey.withOpacity(0.2),
                        //             height: 0.01,
                        //           ),
                        //           CustomSeletedItemWidget(
                        //             label: 'Gallery',
                        //             onTap: () async {
                        //               profileCon.pickedImage(
                        //                 ImageSource.gallery,
                        //               );
                        //               // profileCon
                        //               //     .onSubmitProfilePicutre();

                        //               profileCon.update();
                        //               context.pop();
                        //             },
                        //           ),
                        //           Divider(
                        //             color: Colors.grey.withOpacity(0.2),
                        //             height: 0.01,
                        //           ),
                        //           CustomSeletedItemWidget(
                        //             label: 'Camera',
                        //             onTap: () {
                        //               profileCon.pickedImage(
                        //                 ImageSource.camera,
                        //               );
                        //             },
                        //           ),
                        //         ],
                        //       ),
                        //       Divider(
                        //         color: Colors.grey.withOpacity(0.2),
                        //         height: 0.01,
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 8.0),
                        //         child: CustomSeletedItemWidget(
                        //           label: 'Cancel',
                        //           onTap: () {
                        //             context.pop();
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        height: 25,
                        width: 25,
                        child: const Icon(
                          Icons.edit,
                          size: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Admin',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Text(
              'muykea@gmail.com',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 30,
            ),

            // const CustomDetailProfile(
            //   lable: 'UserName',
            //   value: 'Muykea',
            // ),
            // const CustomDetailProfile(
            //   lable: 'Email',
            //   value: 'muykea@gmail.com',
            // ),
            // const CustomDetailProfile(
            //   lable: 'Gender',
            //   value: 'Female',
            // ),
            // const CustomDetailProfile(
            //   lable: 'Position',
            //   value: 'App programmer',
            // ),
            CustomDetailProfile(
              iconData: Icons.person,
              lable: 'Edit Profile',
              icons: true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditProfilePage(
                    userModel: profileCon.userModel.value,
                  );
                }));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomDetailProfile(
              iconData: Icons.notifications_sharp,
              lable: 'Notification',
              icons: true,
              onTap: () {},
            ),
            CustomDetailProfile(
              iconData: Icons.language,
              lable: 'Language',
              icons: false,
              isText: true,
              language: 'English (US)',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LanguagePage();
                }));
              },
            ),
            CustomDetailProfile(
              iconData: Icons.key,
              lable: 'Change Password',
              icons: true,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                debugPrint('logout');

                // profileCon.onSubmitProfile();
                // final ImagePicker picker = ImagePicker();
                // final XFile? image;
                // image = await picker.pickImage(source: ImageSource.gallery);
                // if (image != null) {
                //   Uint8List bytes = await image.readAsBytes();
                //   UploadFileImage()
                //       .uploadImage(bytes, image.name)
                //       .then((value) {
                //     setState(() {});
                //     debugPrint(
                //         "Upload Successfully with link ${value.toString()}");
                //   }).onError((error, stackTrac) {
                //     debugPrint("$error");
                //   });
                // }
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
            ),
            const SizedBox(
              height: 10,
            ),
            //Image.network('src')
          ],
        ),
      ),
    );
  }
}
