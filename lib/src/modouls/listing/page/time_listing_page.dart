import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import '../../../config/font/font_controller.dart';
import '../../booking/controller/booking_contoller.dart';

class TimeListingPage extends StatefulWidget {
  final String date;
  final String id;
  final bool isEdit;
  final String? bookingId;
  const TimeListingPage({
    super.key,
    required this.date,
    required this.id,
    this.bookingId,
    this.isEdit = false,
  });

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
        .getAvailableTimeSlot(date: widget.date, roomId: widget.id)
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
    widget.isEdit
        ? debugPrint(' id edit true : ${widget.id}')
        : debugPrint(' id edit false : ${widget.id}');
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.isEdit ? 'Update Add Time' : 'Show Add time ',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              context.go('/rooms/room/${widget.id}');
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        titleTextStyle: context.appBarTextStyle.copyWith(
            color: AppColors.primaryColor, fontWeight: FontWeight.w700),
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
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                         physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: availableSoltList.length,
                          gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: context.width<400 ?70: 60,
                                    crossAxisCount:context.width>700? 5:context.width<400?1:2,
                                    childAspectRatio: 2/3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10, ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                bookingCon.timeIndex.value = index;
                                debugPrint(
                                    'Time Index ${bookingCon.timeIndex.value}');
                                String dateTimeString = availableSoltList[index];
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
                                        '/booking-room/${widget.id}/edit-booking?millisecondsSinceEpoch=${result.toInt()}&bookId=${widget.bookingId}',
                                      )
                                    // edit screen throw id of booking
                                    : context.go(Uri(
                                        path: '/rooms/confirm-booking',
                                        queryParameters: {
                                            'millisecondsSinceEpoch':
                                                result.toInt().toString(),
                                            'id': widget.id
                                          }).toString());
                              },
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: context.width > 500
                                        ? context.width * 0.4
                                        : context.width),
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.8,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: const Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10),
                                        color: AppColors.secondaryColor),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        formatTime(availableSoltList[index]),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )),
                              ),
                            );
                          }),
                    )),
      ),
    );
  }
}
