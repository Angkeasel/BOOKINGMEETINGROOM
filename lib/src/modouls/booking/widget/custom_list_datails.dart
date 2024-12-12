import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import '../controller/booking_contoller.dart';

class CustomListDetails extends StatefulWidget {
  final String? title;
  final String? date;
  final String? timeFrom;
  final String? timeTo;
  final String? firstName;
  final String? lastName;
  final String? location;
  final Function(dynamic)? onSelected;
  final GestureTapCallback? onTap;
  const CustomListDetails(
      {super.key,
      this.date,
      this.timeFrom,
      this.timeTo,
      this.title,
      this.onTap,
      this.onSelected,
      this.firstName,
      this.lastName,
      this.location});

  @override
  State<CustomListDetails> createState() => _CustomListDetailsState();
}

class _CustomListDetailsState extends State<CustomListDetails> {
  final bookCon = Get.put(BookingController());
  @override
  Widget build(BuildContext context) {
    String formatDateTime(String dateTimeString) {
      final dateTime = DateTime.parse(dateTimeString);
      final formatter = DateFormat(
          'hh:mm aa'); // Adjust format as needed (e.g., HH:mm for 24-hour format)
      return formatter.format(dateTime);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.transparent,
      width: context.width,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: widget.onTap,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: context.width > 500
                          ? context.width * 0.3
                          : context.width),
                  child: Container(
                    width: kIsWeb?context.width*0.7: context.width * 0.85,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child:  Container(
                           // color: Colors.amber,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Flexible(child:  Text('Room: ', overflow: TextOverflow.ellipsis,)),
                                      Flexible(
                                        child: Text(
                                          widget.location ?? 'N/A',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          widget.date ?? '',
                                           overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${formatDateTime(widget.timeFrom!)} - ${formatDateTime(widget.timeTo!)}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                     const Flexible(child:  Text('booked by: ',overflow: TextOverflow.ellipsis,)),
                                      Expanded(
                                        child: Text(
                                          "${widget.firstName} ${widget.lastName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: AppColors.secondaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        PopupMenuButton(
                          color: Colors.white,
                          // ignore: sort_child_properties_last
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: const Icon(
                                Icons.more_horiz,
                                color: AppColors.secondaryColor,
                              )),
                          onSelected: widget.onSelected,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    'Edit',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "delete",
                              child: Row(
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColors.primaryColor,
                                        size: 20,
                                      )),
                                  const Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
