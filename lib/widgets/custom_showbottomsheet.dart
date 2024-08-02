import 'package:flutter/material.dart';

import '../src/constant/app_color.dart';

showBottomsheet({
  required BuildContext context,
  Function()? onTapCamera,
  Function()? onTapGallery,
  Function()? onTapCancel,
  bool isDismissible = true,
  bool enableDrag = true,
  EdgeInsetsGeometry? padding,
  double? height,
}) {
  showModalBottomSheet(
      enableDrag: false,
      isDismissible: isDismissible,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      useRootNavigator: true,
      builder: (context) {
        return Container(
          padding: padding,
          height: height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: onTapGallery,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 26.0,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ))),
              Divider(
                color: Colors.grey.withOpacity(0.2),
                height: 0.01,
              ),
              Expanded(
                  child: InkWell(
                      onTap: onTapCamera,
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 25.0,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ))),
              Divider(
                color: Colors.grey.withOpacity(0.2),
                height: 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: onTapCancel,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Center(
                        child: Text(
                      'Cancle',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    )),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // )
            ],
          ),
        );
      });
}

// void showCupertinoModalBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) => CupertinoActionSheet(
//       title: const Text('Title'),
//       actions: [
//         CupertinoActionSheetAction(
//           child: const Text('Item 1'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         CupertinoActionSheetAction(
//           child: const Text('Item 2'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ],
//       // cancelButton: CupertinoActionButton(
//       //   child: Text('Close'),
//       //   onPressed: () {
//       //     Navigator.pop(context);
//       //   },
//       // ),
//     ),
//   );
// }

// import 'package:flutter/material.dart';

// onShowBottomSheet({
//   required BuildContext context,
//   String? title,
//   Function? ontab,
//   String? subtitle,
//   Widget? child,
//   double? height,
//   bool? appbar = false,
//   bool? isTitle = false,
//   bool? isSubtitle = false,
//   Color? colors,
//   EdgeInsets? padding,
//   bool? isContainer = false,
//   bool? isWidget = false,
//   bool? enableDrag,
//   bool? isDimissible,
// }) {
//   showModalBottomSheet(
//       // isDismissible: isDimissible ?? false,
//       // enableDrag: enableDrag ?? false,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//         ),
//       ),
//       useRootNavigator: true,
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: padding,
//           height: height,
//           child: Column(
//             children: [
//               if (appbar == true)
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                     color: colors,
//                   ),
//                   padding: const EdgeInsets.only(
//                     top: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (isContainer == false)
//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               height: 4,
//                               width: 35,
//                               decoration: const BoxDecoration(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(20),
//                                 ),
//                                 color: Color(0xffBFBFBF),
//                               ),
//                             ),
//                           ),
//                         ),
//                       if (isTitle == false)
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       if (isTitle == false)
//                         Center(
//                           child: Text(
//                             '$title',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.black),
//                           ),
//                         ),
//                       if (isSubtitle == false)
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       if (isSubtitle == false)
//                         Text(
//                           '$subtitle',
//                           style: Theme.of(context)
//                               .textTheme
//                               .displaySmall!
//                               .copyWith(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xff565656),
//                                   height: 1.5),
//                         ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       const Divider(
//                         thickness: 1,
//                         color: Colors.black12,
//                         height: 1,
//                       )
//                     ],
//                   ),
//                 ),
//               if (isWidget == false)
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: Container(
//                       child: child,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         );
//       });
// }
