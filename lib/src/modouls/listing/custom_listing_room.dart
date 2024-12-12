import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    String? image_path = dotenv.env['image_path'];
    //String? image_path = 'http://192.168.120.214:3000/';
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 2,
              //     blurRadius: 3,
              //     offset: const Offset(0, 2), // changes position of shadow
              //   ),
              // ],
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
                    imageUrl:image != null? "$image_path""$image" :"https://www.shutterstock.com/image-vector/image-icon-600nw-211642900.jpg" ,
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
