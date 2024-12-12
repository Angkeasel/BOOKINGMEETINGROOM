import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/custom_buttons.dart';
import '../../../constant/app_color.dart';
import '../controller/booking_contoller.dart';

import '../widget/custom_detail_card.dart';

class ViewDetailsPage extends StatefulWidget {
  final String bookId;
  final GestureTapCallback? onTapEdit;
  final GestureTapCallback? onTapDelete;
  const ViewDetailsPage({
    super.key,
    required this.bookId, this.onTapEdit, this.onTapDelete,
  });

  @override
  State<ViewDetailsPage> createState() => _ViewDetailsPageState();
}

class _ViewDetailsPageState extends State<ViewDetailsPage> {
  final bookingCon = Get.put(BookingController());

  //============================>Function <==========================================
  String hourFormatFromMinutes(int minutes) {
    final duration = Duration(minutes: minutes);
    if (minutes < 60) {
      return '${minutes}min';
    }
    if (minutes % 60 == 0) {
      return '${duration.inHours}h';
    } else {
      return '${duration.inHours}h${minutes % 60}m';
    }
  }

//===============================>Function <==================================
  String formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('d MMMM yyyy');
    return formatter.format(dateTime);
  }

//=======================> variable <==========================================
  @override
  void initState() {
   bookingCon.fetchBookingById(widget.bookId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Room Detail',
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: Obx(
        () => bookingCon.loading.value
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.primaryColor,
                ),
              )
            // ignore: unnecessary_null_comparison
            :bookingCon.bookingModels.value == null?const Text('Empty Page') : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      bookingCon.bookingModels.value.meetingTopic ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  context.width > 500
                      ? Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            // color: Colors.red,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Room: ",
                                ),
                                Text(
                                  bookingCon.bookingModels.value.location ?? '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Date: "),
                                Text(
                                    formatDateTime(
                                        bookingCon.bookingModels.value.date!),
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: AppColors.secondaryColor,
                                    thickness: 2,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '${formatDateTime(bookingCon.bookingModels.value.startTime ?? '')}- ${formatDateTime(bookingCon.bookingModels.value.endTime ?? '')}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          // padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          //color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Flexible(
                                    child: Text(
                                      "Room: ",
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      bookingCon.bookingModels.value.location ??
                                          '',
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Flexible(
                                      child: Text(
                                    "Date: ",
                                    overflow: TextOverflow.clip,
                                  )),
                                  Flexible(
                                    child: Text(
                                        formatDateTime(bookingCon
                                            .bookingModels.value.date!),
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                    child: VerticalDivider(
                                      color: AppColors.secondaryColor,
                                      thickness: 2,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${formatDateTime(bookingCon.bookingModels.value.startTime ?? '')}- ${formatDateTime(bookingCon.bookingModels.value.endTime ?? '')}',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  const Padding(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: Divider(
                      color: Color.fromARGB(142, 84, 0, 0),
                      thickness: 1,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: context.height,
                      width: context.width < 500
                          ? context.width
                          : context.width > 900
                              ? context.width * 0.4
                              : context.width * 0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              //color: Colors.amber,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomDetailCard(
                                    icon: Icons.person,
                                    text: "FullName",
                                    lable:
                                        '${bookingCon.bookingModels.value.firstName} ${bookingCon.bookingModels.value.lastName}',
                                  ),
                                  CustomDetailCard(
                                    icon: Icons.perm_contact_cal_rounded,
                                    text: "Contact",
                                    lable:
                                        "${bookingCon.bookingModels.value.phoneNumber}",
                                  ),
                                  CustomDetailCard(
                                    icon: Icons.email,
                                    text: "Email",
                                    lable:
                                        '${bookingCon.bookingModels.value.email}',
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Duration'),
                                Flexible(
                                  child: Text(
                                    hourFormatFromMinutes(bookingCon
                                            .bookingModels.value.duration ??
                                        0),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                    width: context.width * 0.13,
                                    child: Divider(
                                      thickness: 2,
                                      color: AppColors.primaryColor,
                                      height: 20,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtons(
                          title: "Edit",
                          width: context.width * 0.15,
                          onTap: widget.onTapEdit,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomButtons(
                          title: "Delete",
                          width: context.width * 0.2,
                          color: const Color.fromRGBO(244, 67, 54, 1),
                          onTap: widget.onTapDelete,
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
