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
  final String? date;
  final String? startTime;
  final String? endTime;
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
    String formatDateTime(String dateTimeString) {
      final dateTime = DateTime.parse(dateTimeString);
      final formatter = DateFormat(
          'hh:mm aa'); // Adjust format as needed (e.g., HH:mm for 24-hour format)
      return formatter.format(dateTime);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          topic ?? '',
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30, top: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    value: date,
                  ),
                  CustomRowDetails(
                    title: 'StatTime',
                    value: formatDateTime(startTime!),
                  ),
                  CustomRowDetails(
                    title: 'EndTime',
                    value: formatDateTime(endTime!),
                  ),
                  CustomRowDetails(
                      title: 'Duration',
                      value: bookingCon.hourFormatFromMinutes(duration!)),
                  CustomRowDetails(
                    title: 'Email',
                    value: email ?? '',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                          border: Border.all(color: Colors.grey.shade600)),
                      child: IconButton(
                        onPressed: () {
                          debugPrint('print edit from detail ');
                        },
                        icon: const Icon(
                          Icons.edit_outlined,
                          size: 27,
                        ),
                      ),
                    ),
                    const Text('Edit'),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          border: Border.all(color: Colors.grey.shade600)),
                      child: IconButton(
                        onPressed: () {
                          debugPrint('print deleted from detail ');
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 27,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text('Delete'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
