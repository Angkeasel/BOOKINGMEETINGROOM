// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:meetroombooking/src/constant/app_textstyle.dart';
// import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';

// import '../../../constant/app_color.dart';
// import '../widget/custom_list_datails.dart';
// import 'view_detail.page.dart';

// class BookingRoomDetailsPage extends StatelessWidget {
//   const BookingRoomDetailsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bookingCon = Get.put(BookingController());

//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Booking Room Details Page"),
//           titleTextStyle: context.appBarTextStyle.copyWith(
//             color: AppColors.textLightColor,
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: bookingCon.eventList.asMap().entries.map((e) {
//                 return CustomListDetails(
//                     title: e.value.meetingTopic,
//                     date: e.value.startTime,
//                     timeFrom: e.value.from,
//                     timeTo: e.value.to,
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return ViewDetailsPage(
//                           email: e.value.email,
//                           topic: e.value.eventName,
//                           firstName: e.value.firstName,
//                           lastName: e.value.lastName,
//                           phone: e.value.phone,
//                           location: e.value.location,
//                           date: e.value.from,
//                           startTime: e.value.from,
//                           endTime: e.value.to,
//                           duration: e.value.duration,
//                         );
//                       }));
//                     });
//               }).toList(),
//             ),
//           ),
//         ));
//   }
// }
