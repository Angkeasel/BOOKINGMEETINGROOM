import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';

class CustomPhoto extends StatelessWidget {
  final File? imageFile;
  final Uint8List? imageWeb;
  final String? imageNetwork;
  final GestureTapCallback? onTap;
  const CustomPhoto(
      {super.key,
      this.imageFile,
      this.onTap,
      this.imageWeb,
      this.imageNetwork});

  @override
  Widget build(BuildContext context) {
    //final profileCon = Get.put(ProfileController());
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: AppColors.primaryColor, width: 2)),
          child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: imageFile != null ||
                      imageWeb != null ||
                      imageNetwork != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )
                          : imageWeb != null
                              ? Image.memory(
                                  imageWeb!,
                                  fit: BoxFit.cover,
                                )
                              : imageNetwork != null
                                  ? Image.network(
                                      '$imageNetwork',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('assets/image/png/profile.png'),
                    )
                  : Image.asset('assets/image/png/profile.png')),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              height: 26,
              width: 26,
              child: const Icon(
                Icons.edit,
                size: 15,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
