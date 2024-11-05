import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

class CustomListDetails extends StatelessWidget {
  final String? title;
  final String? date;
  final String? timeFrom;
  final String? timeTo;
  final Function()? onPressedEdit;
  final Function()? onPressedDeleted;
  final GestureTapCallback? onTap;
  const CustomListDetails(
      {super.key,
      this.date,
      this.timeFrom,
      this.timeTo,
      this.title,
      this.onTap,
      this.onPressedEdit,
      this.onPressedDeleted});

  @override
  Widget build(BuildContext context) {
    String formatDateTime(String dateTimeString) {
      final dateTime = DateTime.parse(dateTimeString);
      final formatter = DateFormat(
          'hh:mm aa'); // Adjust format as needed (e.g., HH:mm for 24-hour format)
      return formatter.format(dateTime);
    }

    return Container(
      //padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      width: context.width,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTap,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: context.width > 500
                          ? context.width * 0.4
                          : context.width),
                  child: Container(
                    width: context.width * 0.6,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade600)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title ?? ''),
                          Text(date ?? ''),
                          Text(
                            '${formatDateTime(timeFrom!)} - ${formatDateTime(timeTo!)}',
                            overflow: TextOverflow.ellipsis,
                          )
                        ]),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                  height: 70,
                  width: 45,
                  //padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor,
                      border: Border.all(color: Colors.grey.shade600)),
                  child: IconButton(
                      onPressed: onPressedEdit,
                      icon: const Icon(
                        Icons.edit,
                        size: 27,
                        color: Colors.white,
                      ))),
              const SizedBox(width: 8),
              Container(
                  height: 70,
                  width: 45,
                  // padding: const EdgeInsets.only(),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      border: Border.all(color: Colors.grey.shade600)),
                  child: IconButton(
                      onPressed: onPressedDeleted,
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
      ),
    );
  }
}
