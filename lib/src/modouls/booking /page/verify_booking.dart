import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/util/extension/date_time.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';

import '../../../constant/app_color.dart';

class Verifybooking extends StatelessWidget {
  final String? date;
  final String? fromTime;
  final String? toTime;
  final int? durations;
  final String? location;
  final String? userName;
  const Verifybooking(
      {super.key,
      this.date,
      this.durations,
      this.fromTime,
      this.location,
      this.toTime,
      this.userName});

  @override
  Widget build(BuildContext context) {
    DateTime convertedDate = DateTime.parse(date!);
    final bookingCon = Get.put(BookingController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Verify Booked ",
          ),
          titleTextStyle: context.appBarTextStyle.copyWith(
            color: AppColors.textLightColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor, shape: BoxShape.circle),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade500)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMMEEEEd().format(convertedDate)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          '${fromTime?.toTimeFormat()} - ${toTime?.toTimeFormat()}'),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.query_builder_sharp),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(bookingCon.hourFormatFromMinutes(durations!)),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.business_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('$location'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Thanks $userName !",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[900]),
                      ),
                      Text(
                        "Your appointment is booked on ${DateFormat.yMMMMEEEEd().format(convertedDate)} .",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[900]),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButtons(
                title: 'Done',
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
