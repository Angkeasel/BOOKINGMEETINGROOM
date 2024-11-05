import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomListingRoom extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final bool isClick;
  final String? image;
  const CustomListingRoom(
      {super.key, this.title, this.onTap, this.isClick = false, this.image});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
              color: isClick ? AppColors.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: isClick ? Colors.white : AppColors.primaryColor,
                  width: 1.5)),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: context.width,
                    imageUrl: image ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      child: Image.network(
                        "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                  child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w700,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
