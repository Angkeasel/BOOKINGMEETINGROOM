import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomListDetails extends StatelessWidget {
  final String? title;
  final String? date;
  final String? timeFrom;
  final String? timeTo;
  final GestureTapCallback? onTap;
  const CustomListDetails(
      {super.key,
      this.date,
      this.timeFrom,
      this.timeTo,
      this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    String formatDateTime(String dateTimeString) {
      final dateTime = DateTime.parse(dateTimeString);
      final formatter = DateFormat(
          'hh:mm aa'); // Adjust format as needed (e.g., HH:mm for 24-hour format)
      return formatter.format(dateTime);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade600)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title ?? ''),
                      Text(date ?? ''),
                      Row(
                        children: [
                          Text('${formatDateTime(timeFrom!)} - '),
                          Text(formatDateTime(timeTo!)),
                        ],
                      )
                    ]),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
                height: 70,
                width: 45,
                //padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                    border: Border.all(color: Colors.grey.shade600)),
                child: IconButton(
                    onPressed: () {
                      debugPrint('print deleted from detail ');
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 27,
                      color: Colors.white,
                    ))),
            const SizedBox(
              width: 5,
            ),
            Container(
                height: 70,
                width: 45,
                //padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                    border: Border.all(color: Colors.grey.shade600)),
                child: IconButton(
                    onPressed: () {
                      debugPrint('print deleted from detail ');
                    },
                    icon: const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.delete,
                        size: 27,
                        color: Colors.white,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
