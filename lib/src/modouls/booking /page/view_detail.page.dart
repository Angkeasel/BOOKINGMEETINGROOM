import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';

import '../../../constant/app_color.dart';
import '../widget/custom_row_details.dart';

class ViewDetailsPage extends StatelessWidget {
  final String? location;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? topic;
  final DateTime? date;
  final DateTime? startTime;
  final DateTime? endTime;
  final int? duration;

  const ViewDetailsPage(
      {super.key,
      this.email,
      this.firstName,
      this.lastName,
      this.location,
      this.phone,
      this.topic,
      this.date,
      this.duration,
      this.endTime,
      this.startTime});

  @override
  Widget build(BuildContext context) {
    final bookingCon = Get.put(BookingController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'View Page Details',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomRowDetails(
                      title: 'Location',
                      value: location,
                    ),
                    CustomRowDetails(
                      title: 'FirstName',
                      value: firstName ?? '',
                    ),
                    CustomRowDetails(
                      title: 'LastName',
                      value: lastName ?? '',
                    ),
                    CustomRowDetails(
                      title: 'Phone',
                      value: phone ?? '',
                    ),
                    CustomRowDetails(
                      title: 'Meeting Topic',
                      value: topic ?? '',
                    ),
                    CustomRowDetails(
                      title: 'Date',
                      value: DateFormat.yMMMMEEEEd().format(date!).toString(),
                    ),
                    CustomRowDetails(
                      title: 'StatTime',
                      value:
                          DateFormat('HH:mm aa').format(startTime!).toString(),
                    ),
                    CustomRowDetails(
                        title: 'EndTime',
                        value:
                            DateFormat('HH:mm aa').format(endTime!).toString()),
                    CustomRowDetails(
                        title: 'Duration',
                        value: bookingCon.hourFormatFromMinutes(duration!)),
                    CustomRowDetails(
                      title: 'Email',
                      value: email ?? '',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 60,
                            width: 60,
                            //padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                                border:
                                    Border.all(color: Colors.grey.shade600)),
                            child: IconButton(
                                onPressed: () {
                                  debugPrint('print edit from detail ');
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 27,
                                ))),
                        Container(
                            height: 60,
                            width: 60,
                            //padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                                border:
                                    Border.all(color: Colors.grey.shade600)),
                            child: IconButton(
                                onPressed: () {
                                  debugPrint('print deleted from detail ');
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 27,
                                  color: Colors.white,
                                ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
