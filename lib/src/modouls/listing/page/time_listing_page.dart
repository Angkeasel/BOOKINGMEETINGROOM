import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/booking%20/confirm_booking.dart';
import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_model.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';

import '../../../config/font/font_controller.dart';

class TimeListingPage extends StatefulWidget {
  final String date;
  final List<Meeting> appointment;
  const TimeListingPage(
      {super.key, required this.date, required this.appointment});

  @override
  State<TimeListingPage> createState() => _TimeListingPageState();
}

class _TimeListingPageState extends State<TimeListingPage> {
  final roomCon = Get.put(RoomController());
  final now = DateTime.now();

  final DateFormat _dateFormat = DateFormat('HH:mm aa', 'km');
  final languageController = Get.find<LanguageController>();

  String timeshiftFormatter(String datetime) => languageController.isKhmer
      ? datetime.replaceAll('AM', 'ព្រឹក').replaceAll('PM', 'ល្ងាច')
      : datetime;

  @override
  void initState() {
    debugPrint('date now : ${widget.date}');
    final dateTime = DateFormat("yyyy-MM-dd").parse(widget.date);
    // roomCon.allTimeSlots = roomCon.getTimeSlots(dateTime);
    roomCon.availableTimeSlots =
        roomCon.getAvailableTimeSlots(dateTime, widget.appointment);
    debugPrint(
        'availableTimeSlots ${roomCon.availableTimeSlots} ${widget.appointment}');
    super.initState();
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
              children: roomCon.availableTimeSlots.asMap().entries.map((e) {
                return GestureDetector(
                  onTap: () {
                    String dateTimeString = e.value.toString();
                    debugPrint('add time : $dateTimeString');
                    DateTime dateTimefromString =
                        DateTime.parse(dateTimeString);
                    int milliSeconds =
                        dateTimefromString.microsecondsSinceEpoch;
                    var result = milliSeconds / 1000;
                    debugPrint('millisecond: ${result.toInt()}');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ConfirmBookingScreen(
                        millisecondsSinceEpoch: result.toInt(),
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
                          timeshiftFormatter(
                            _dateFormat.format(e.value),
                          ),
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
