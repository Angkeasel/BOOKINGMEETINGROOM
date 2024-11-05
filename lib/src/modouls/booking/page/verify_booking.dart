import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import '../controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/booking/models/meeting/meeting_model.dart';
import 'package:meetroombooking/src/util/extension/date_time.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import '../../../constant/app_color.dart';

class Verifybooking extends StatefulWidget {
  final String? id;
  const Verifybooking({
    super.key,
    this.id,
  });

  @override
  State<Verifybooking> createState() => _VerifybookingState();
}

class _VerifybookingState extends State<Verifybooking> {
  final bookingCon = Get.put(BookingController());
  Meeting verifyModel = Meeting();
  Future<Meeting> verifyFetch() async {
    await bookingCon.fetchBookingById(widget.id!).then((value) {
      setState(() {
        verifyModel = value;
        debugPrint('=====> verifyModel ${verifyModel.date}');
      });
    });
    return verifyModel;
  }

  @override
  void initState() {
    debugPrint('===========> verify booking fetch screen ${widget.id!}');
    verifyFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime convertedDate = DateTime.parse(verifyModel.date ?? '');
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
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth:
                    context.width > 500 ? context.width * .5 : context.width),
            child: Padding(
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
                              '${verifyModel.startTime?.toTimeFormat()} - ${verifyModel.endTime?.toTimeFormat()}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.query_builder_sharp),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(bookingCon.hourFormatFromMinutes(
                                  verifyModel.duration ?? 0)),
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
                              Text(verifyModel.location ?? ''),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Thanks ${verifyModel.firstName} !",
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
        ),
      ),
    );
  }
}
