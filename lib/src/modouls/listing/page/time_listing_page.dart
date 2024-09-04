import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';
import '../../../config/font/font_controller.dart';
import '../../booking /controller/booking_contoller.dart';
import '../../booking /models/meeting/meeting_model.dart';

class TimeListingPage extends StatefulWidget {
  final String date;
  final RoomListingModel? roomListingModel;
  final bool isEdit;
  final Meeting? meetingModel;

  const TimeListingPage(
      {super.key,
      required this.date,
      this.roomListingModel,
      this.isEdit = false,
      this.meetingModel});

  @override
  State<TimeListingPage> createState() => _TimeListingPageState();
}

class _TimeListingPageState extends State<TimeListingPage> {
  final roomCon = Get.put(RoomController());
  final bookingCon = Get.put(BookingController());
  final now = DateTime.now();

  String formatTime(String time) {
    DateTime parsedTime = DateFormat('MM/dd/yyyy, hh:mm:ss aa').parse(time);
    String formattedTime = DateFormat('HH:mm aa').format(parsedTime);
    return formattedTime;
  }

  final languageController = Get.find<LanguageController>();
  String timeshiftFormatter(String datetime) => languageController.isKhmer
      ? datetime.replaceAll('AM', 'ព្រឹក').replaceAll('PM', 'ល្ងាច')
      : datetime;
  //============================> function Fetch <============================
  List<String> availableSoltList = [];
  Future<List<String>> fetch() async {
    await bookingCon
        .getAvailableTimeSlot(
            date: widget.date, roomId: widget.roomListingModel!.id!)
        .then((value) {
      debugPrint('available time $value');
      setState(() {
        availableSoltList = value;
      });
    });
    return availableSoltList;
  }

  @override
  void initState() {
    debugPrint('date now : ${widget.date}');
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Update Add Time' : 'Show Add time ',
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: Obx(
        () => bookingCon.isLoadingSlot.value
            ? const Center(child: CircularProgressIndicator())
            : availableSoltList.isEmpty
                ? const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Available Times',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: availableSoltList.asMap().entries.map((e) {
                            return GestureDetector(
                              onTap: () {
                                bookingCon.timeIndex.value = e.key;
                                debugPrint(
                                    'Time Index ${bookingCon.timeIndex.value}');
                                String dateTimeString = e.value;
                                debugPrint(
                                    'add time : $dateTimeString'); // //7/1/2024, 8:00:00
                                DateFormat dateFormat =
                                    DateFormat('MM/dd/yyyy, hh:mm:ss aa');
                                DateTime dateTime =
                                    dateFormat.parse(dateTimeString);
                                int milliSeconds =
                                    dateTime.microsecondsSinceEpoch;
                                var result = milliSeconds / 1000;
                                debugPrint('millisecond: ${result.toInt()}');
                                widget.isEdit
                                    ? context.go(
                                        '/booking-room/all-booking-user/edit-booking/${result.toInt()}',
                                        // pathParameters: {
                                        //     'millisecondsSinceEpoch':
                                        //         result.toInt().toString()
                                        //   },
                                        extra: {
                                            'roomModel':
                                                widget.roomListingModel,
                                            'meetModel': widget.meetingModel
                                          })
                                    : context.goNamed('ConfirmBookingScreen',
                                        queryParameters: {
                                            'millisecondsSinceEpoch':
                                                result.toInt().toString()
                                          },
                                        extra: {
                                            'roomListingModel':
                                                widget.roomListingModel!
                                          });
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColor),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      formatTime(e.value),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )),
                            );
                          }).toList()),
                    ),
                  ),
      ),
    );
  }
}
