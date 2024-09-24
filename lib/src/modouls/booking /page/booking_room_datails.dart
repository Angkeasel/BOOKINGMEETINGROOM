import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/config/router/router.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';

import '../../../constant/app_color.dart';
import '../../../util/helper/snackbar/alert_snackbar.dart';
import '../widget/custom_list_datails.dart';
import 'view_detail.page.dart';

class BookingRoomDetailsPage extends StatefulWidget {
  //final RoomListingModel? roomModel;
  final String id;
  const BookingRoomDetailsPage({super.key, required this.id});
  @override
  State<BookingRoomDetailsPage> createState() => _BookingRoomDetailsPageState();
}

class _BookingRoomDetailsPageState extends State<BookingRoomDetailsPage> {
  final bookingCon = Get.put(BookingController());
  final roomCon = Get.put(RoomController());
  // final controller = ScrollController();

  late final currentRoomId = widget.id;

  @override
  void initState() {
    bookingCon.newMeetingList.clear();
    bookingCon.getAllBookedListByRoomId(currentRoomId);
    super.initState();
  }

  Future<void> _onRefresh() async {
    await bookingCon.getAllBookedListByRoomId(currentRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        title: const Text(" All Booked Listing "),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
      body: Obx(
        () => bookingCon.isLoadingMeetingUser.value
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.primaryColor,
                ),
              )
            : bookingCon.newMeetingList.isEmpty
                ? const Center(
                    child: Text(
                      'No Event Listings',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey),
                    ),
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: NotificationListener<ScrollUpdateNotification>(
                            onNotification: (notification) {
                              if (notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent) {
                                // Call Next Page here
                                bookingCon.getNextPage(currentRoomId);
                              }
                              return true;
                            },
                            child: RefreshIndicator(
                              onRefresh: _onRefresh,
                              child: ListView.separated(
                                  shrinkWrap: false,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(16)
                                      .copyWith(bottom: 30),
                                  itemCount: bookingCon.newMeetingList.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 12),
                                  itemBuilder: (_, index) {
                                    return CustomListDetails(
                                        title: bookingCon
                                            .newMeetingList[index].meetingTopic,
                                        date: bookingCon
                                            .newMeetingList[index].date,
                                        timeFrom: bookingCon
                                            .newMeetingList[index].startTime,
                                        timeTo: bookingCon
                                            .newMeetingList[index].endTime,
                                        onPressedDeleted: () {
                                          debugPrint(
                                              'print deleted from detail ');
                                          showDialogConfirmation(
                                            context: context,
                                            txt: 'remove this item from cart',
                                            accept: 'Yes',
                                            cancel: 'Cancel',
                                            onTap: () async {
                                              router.pop(context);
                                              await bookingCon.deleteMeeting(
                                                  context: context,
                                                  id: bookingCon
                                                          .newMeetingList[index]
                                                          .id ??
                                                      '',
                                                  roomId: bookingCon
                                                      .newMeetingList[index]
                                                      .byRoom!);
                                            },
                                          );
                                        },
                                        onPressedEdit: () {
                                          //debugPrint('print edit from detail ');
                                          // String dateTimeString =
                                          //     "2024-07-02 09:00:00.000";
                                          String dateTimeString = bookingCon
                                                  .newMeetingList[index]
                                                  .startTime ??
                                              '';
                                          // DateFormat dateFormat =
                                          //     DateFormat('yyyy-MM-dd hh:mm:ss.SSS ');

                                          DateTime dateTime =
                                              DateTime.parse(dateTimeString);
                                          int milliSeconds =
                                              dateTime.microsecondsSinceEpoch;
                                          var result = milliSeconds / 1000;

                                          //=============> test ************************
                                          debugPrint(
                                              'millisecond: $milliSeconds');
                                          debugPrint(
                                              'testing widget id ${widget.id}');
                                          //====================> ******* go route edit booking
                                          context.go(
                                            Uri(
                                                path:
                                                    '/booking-room/${widget.id}/edit-booking',
                                                queryParameters: {
                                                  'millisecondsSinceEpoch':
                                                      result.toInt().toString(),
                                                  'bookId': bookingCon
                                                      .newMeetingList[index].id
                                                }).toString(),
                                          ); // widget.id = room Id
                                        },
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ViewDetailsPage(
                                              email: bookingCon
                                                  .newMeetingList[index].email,
                                              topic: bookingCon
                                                  .newMeetingList[index]
                                                  .meetingTopic,
                                              firstName: bookingCon
                                                  .newMeetingList[index]
                                                  .firstName,
                                              lastName: bookingCon
                                                  .newMeetingList[index]
                                                  .lastName,
                                              phone: bookingCon
                                                  .newMeetingList[index]
                                                  .phoneNumber,
                                              location: bookingCon
                                                  .newMeetingList[index]
                                                  .location,
                                              date: bookingCon
                                                  .newMeetingList[index].date,
                                              startTime: bookingCon
                                                  .newMeetingList[index]
                                                  .startTime,
                                              endTime: bookingCon
                                                  .newMeetingList[index]
                                                  .endTime,
                                              duration: bookingCon
                                                  .newMeetingList[index]
                                                  .duration,
                                            );
                                          }));
                                        });
                                  }),
                            ),
                          ),
                        ),
                        bookingCon.loadingNextPage.value
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 8,
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              )
                            : const SizedBox.shrink(),
                        bookingCon.showNoMoreData.value
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Center(child: Text("No More Data")),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
