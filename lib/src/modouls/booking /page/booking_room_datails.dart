import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/config/router/router.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';
import '../../../constant/app_color.dart';
import '../../../util/helper/snackbar/alert_snackbar.dart';
import '../widget/custom_list_datails.dart';
import 'view_detail.page.dart';

class BookingRoomDetailsPage extends StatefulWidget {
  final RoomListingModel? roomModel;
  const BookingRoomDetailsPage({super.key, this.roomModel});
  @override
  State<BookingRoomDetailsPage> createState() => _BookingRoomDetailsPageState();
}

class _BookingRoomDetailsPageState extends State<BookingRoomDetailsPage> {
  final bookingCon = Get.put(BookingController());
  final roomCon = Get.put(RoomController());
  final controller = ScrollController();

  @override
  void initState() {
    bookingCon.newMeetingList.clear();
    bookingCon.page.value = 1;
    roomCon.getListingRoom();
    bookingCon.getBookingByUser(roomId: widget.roomModel!.id!);
    controller.addListener(loadMoreData);
    // debugPrint('test value : ${bookingCon.newMeetingList.length}');
    // debugPrint('get value of room  : ${roomCon.roomListing}');

    super.initState();
  }

  void loadMoreData() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        bookingCon.infinitPage();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    bookingCon.newMeetingList.clear();
    bookingCon.page.value = 1;
    await bookingCon.getBookingByUser(roomId: widget.roomModel!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" All Booked Listing "),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: _onRefresh,
          child: bookingCon.isLoadingMeetingUser.value
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
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              controller: controller,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(
                                  left: 10, right: 5, top: 15),
                              itemCount: bookingCon.newMeetingList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                debugPrint(
                                    'page : ${bookingCon.page} , totalpage : ${bookingCon.totalPage.value}');
                                return CustomListDetails(
                                    title: bookingCon
                                        .newMeetingList[index].meetingTopic,
                                    date: bookingCon.newMeetingList[index].date,
                                    timeFrom: bookingCon
                                        .newMeetingList[index].startTime,
                                    timeTo: bookingCon
                                        .newMeetingList[index].endTime,
                                    onPressedDeleted: () {
                                      debugPrint('print deleted from detail ');
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
                                      // bookingCon.deleteMeeting(
                                      //     id: bookingCon
                                      //         .newMeetingList[index].id!,
                                      //     context: context);
                                    },
                                    onPressedEdit: () {
                                      debugPrint('print edit from detail ');
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
                                      debugPrint('millisecond: $milliSeconds');
                                      debugPrint(
                                          'testing ${bookingCon.newMeetingList[index].id}');
                                      //=========================> // ************************
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return EditBookingPage(
                                      //     millisecondsSinceEpoch:
                                      //         result.toInt(),
                                      //     meetModel:
                                      //         bookingCon.newMeetingList[index],
                                      //     roomModel: widget.roomModel,
                                      //   );
                                      // }));
                                      //====================> ******* go route edit booking
                                      context.push(
                                        '/booking-room/all-booking-user/edit-booking/${result.toInt()}',
                                        extra: {
                                          'meetModel':
                                              bookingCon.newMeetingList[index],
                                          'roomModel': widget.roomModel
                                        },
                                      );

                                      // bookingCon.updateMeeting(
                                      //     id: bookingCon.newMeetingList[index].id, roomId: bookingCon.newMeetingList[index].byRoom);
                                    },
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ViewDetailsPage(
                                          email: bookingCon
                                              .newMeetingList[index].email,
                                          topic: bookingCon
                                              .newMeetingList[index]
                                              .meetingTopic,
                                          firstName: bookingCon
                                              .newMeetingList[index].firstName,
                                          lastName: bookingCon
                                              .newMeetingList[index].lastName,
                                          phone: bookingCon
                                              .newMeetingList[index]
                                              .phoneNumber,
                                          location: bookingCon
                                              .newMeetingList[index].location,
                                          date: bookingCon
                                              .newMeetingList[index].date,
                                          startTime: bookingCon
                                              .newMeetingList[index].startTime,
                                          endTime: bookingCon
                                              .newMeetingList[index].endTime,
                                          duration: bookingCon
                                              .newMeetingList[index].duration,
                                        );
                                      }));
                                    });
                              }),
                        ),
                        bookingCon.hasNextPage.value
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 8,
                                  backgroundColor: AppColors.primaryColor,
                                ),
                              )
                            : const Center(child: Text("")),
                        bookingCon.page.value == bookingCon.totalPage.value
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 30),
                                child: Center(child: Text("No More Data")),
                              )
                            : Container()
                      ],
                    ),
        ),
      ),
    );
  }
}
