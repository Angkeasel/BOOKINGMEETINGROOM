import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/booking%20/confirm_booking.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_model.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';

import '../../../config/font/font_controller.dart';

class TimeListingPage extends StatefulWidget {
  final String date;
  final RoomListingModel? roomListingModel;

  const TimeListingPage({super.key, required this.date, this.roomListingModel});

  @override
  State<TimeListingPage> createState() => _TimeListingPageState();
}

class _TimeListingPageState extends State<TimeListingPage> {
  @override
  void initState() {
    debugPrint('date now : ${widget.date}');
    fetch();
    //fetchDate();

    // final dateTime = DateFormat("yyyy-MM-dd").parse(widget.date);
    //roomCon.allTimeSlots = roomCon.getTimeSlots(dateTime);
    // roomCon.availableTimeSlots =
    //     roomCon.getAvailableTimeSlots(dateTime, widget.appointment);
    // debugPrint(
    //     'availableTimeSlots ${roomCon.availableTimeSlots} ${widget.appointment}');
    super.initState();
  }

  final roomCon = Get.put(RoomController());
  final bookingCon = Get.put(BookingController());
  final now = DateTime.now();

  String formatTime(String time) {
    // Parse the input time string to a DateTime object
    DateTime parsedTime = DateFormat('MM/dd/yyyy, hh:mm:ss aa').parse(time);
    // Format the DateTime object to the desired format
    String formattedTime = DateFormat('HH:mm aa').format(parsedTime);
    return formattedTime;
  }

  //final DateFormat _dateFormat = DateFormat('HH:mm aa', 'km');
  final languageController = Get.find<LanguageController>();

  String timeshiftFormatter(String datetime) => languageController.isKhmer
      ? datetime.replaceAll('AM', 'ព្រឹក').replaceAll('PM', 'ល្ងាច')
      : datetime;
  List<String> availableSoltList = [];
  Future<List<String>> fetch() async {
    bookingCon
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

  List<Meeting> bookingByDateList = [];
  Future<List<Meeting>> fetchDate() async {
    bookingCon.getBookingByDate(date: widget.date).then((value) {
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
        title: Text(
          'Show Add time ',
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: availableSoltList.asMap().entries.map((e) {
                return GestureDetector(
                  onTap: () {
                    bookingCon.timeIndex.value = e.key;
                    debugPrint('Time Index ${bookingCon.timeIndex.value}');
                    String dateTimeString = e.value;
                    debugPrint(
                        'add time : $dateTimeString'); // //7/1/2024, 8:00:00
                    DateFormat dateFormat =
                        DateFormat('MM/dd/yyyy, hh:mm:ss aa');
                    DateTime dateTime = dateFormat.parse(dateTimeString);
                    int milliSeconds = dateTime.microsecondsSinceEpoch;
                    var result = milliSeconds / 1000;
                    debugPrint('millisecond: ${result.toInt()}');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ConfirmBookingScreen(
                        millisecondsSinceEpoch: result.toInt(),
                        roomListingModel: widget.roomListingModel!,
                      );
                    }));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          formatTime(e.value),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                );
              }).toList()),
        ),
      ),
    );
  }
}
