import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';
import 'package:meetroombooking/src/config/router/router.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/profile/controller/profile_controller.dart';

import 'package:meetroombooking/src/modouls/widget/custom_details_profile.dart';
import 'package:meetroombooking/src/util/helper/local_storage/local_storage.dart';
import '../../../constant/app_color.dart';
import '../../../util/helper/snackbar/alert_snackbar.dart';
import '../../widget/custom_photo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileCon = Get.put(ProfileController());
  final lController = Get.find<LanguageController>();

  @override
  void initState() {
    profileCon.getProfile();
    super.initState();
  }

  Future<void> _onRefresh() async {
    await profileCon.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child:  Text(
            'My Profile ',
          ),
        ),
        titleTextStyle: context.appBarTextStyle.copyWith(
            color: AppColors.secondaryColor, fontWeight: FontWeight.w700),
      ),
      body: Obx(
        () => profileCon.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: context.height,
                            maxWidth: context.width > 500
                                ? context.width * .3
                                : context.width),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: CustomPhoto(
                                imageFile: null,
                                imageWeb: null,
                                imageNetwork: profileCon.userModel.value.avatar,
                                onTap: () {
                                  context.go(
                                    Uri(
                                        path: '/profile/edit-profile',
                                        queryParameters: {
                                          'username': profileCon
                                              .userModel.value.username,
                                          'email':
                                              profileCon.userModel.value.email,
                                          'image':
                                              profileCon.userModel.value.avatar
                                        }).toString(),
                                  );
                                },
                              )
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${profileCon.userModel.value.email}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${profileCon.userModel.value.role}',
                              style: const TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomDetailProfile(
                              iconData: Icons.person,
                              lable: 'Edit Profile',
                              icons: true,
                              onTap: () {
                                debugPrint(
                                    '====> get profile id :${profileCon.userModel.value.id}');
                                context.go(
                                  Uri(
                                      path: '/profile/edit-profile',
                                      queryParameters: {
                                        'username':
                                            profileCon.userModel.value.username,
                                        'email':
                                            profileCon.userModel.value.email,
                                        'image':
                                            profileCon.userModel.value.avatar
                                      }).toString(),
                                );
                              },
                            ),
                            CustomDetailProfile(
                              iconData: Icons.language,
                              lable: 'Language',
                              icons: true,
                              isText: true,
                              language: lController.isKhmer
                                  ? 'ភាសាខ្មែរ'
                                  : 'English (US)',
                              onTap: () {
                                lController.toggleLanguage();
                                debugPrint('====> print change language ');
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                debugPrint('logout');
                                showDialogConfirmation(
                                  context: context,
                                  txt: 'LogOut',
                                  accept: 'Yes',
                                  cancel: 'Cancel',
                                  onTap: () async {
                                    await LocalStorage.storeData(
                                        key: 'access_token', value: '');
                                    router.go('/login');
                                  },
                                );

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
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: context.width > 500
                                        ? context.width * .3
                                        : context.width),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Text(
                                      "LogOut",
                                      style: TextStyle(
                                          color: AppColors.backgroundColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
