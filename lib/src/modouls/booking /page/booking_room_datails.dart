import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';

import '../../../constant/app_color.dart';
import '../models/meeting/meeting_model.dart';
import '../widget/custom_list_datails.dart';
import 'view_detail.page.dart';

class BookingRoomDetailsPage extends StatefulWidget {
  const BookingRoomDetailsPage({super.key});

  @override
  State<BookingRoomDetailsPage> createState() => _BookingRoomDetailsPageState();
}

class _BookingRoomDetailsPageState extends State<BookingRoomDetailsPage> {
  String date = '2024-06-30';
  final bookingCon = Get.put(BookingController());

  @override
  void initState() {
    bookingCon.bookingList.clear();
    fetchDate();
    super.initState();
  }

  List<Meeting> bookingByDateList = [];
  Future<List<Meeting>> fetchDate() async {
    bookingCon.getBookingByDate(date: date).then((value) {
      debugPrint('get Date by Date $value');
      setState(() {
        bookingByDateList = value;
      });
    });
    return bookingByDateList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Booked Listing "),
          titleTextStyle: context.appBarTextStyle.copyWith(
            color: AppColors.textLightColor,
          ),
        ),
        body: bookingCon.bookingList.isEmpty
            ? const Center(
                child: Text(
                'No Event Listings',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey),
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: bookingCon.bookingList.asMap().entries.map((e) {
                      return CustomListDetails(
                          title: e.value.meetingTopic,
                          date: e.value.date,
                          timeFrom: e.value.startTime,
                          timeTo: e.value.endTime,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ViewDetailsPage(
                                email: e.value.email,
                                topic: e.value.meetingTopic,
                                firstName: e.value.firstName,
                                lastName: e.value.lastName,
                                phone: e.value.phoneNumber,
                                location: e.value.location,
                                date: e.value.date,
                                startTime: e.value.startTime,
                                endTime: e.value.endTime,
                                duration: e.value.duration,
                              );
                            }));
                          });
                    }).toList(),
                  ),
                ),
              ));
  }
}
