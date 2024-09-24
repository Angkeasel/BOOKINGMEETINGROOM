import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:meetroombooking/generated/l10n.dart';
import 'package:meetroombooking/src/constant/app_color.dart';

import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import 'package:meetroombooking/src/modouls/listing/custom_listing_room.dart';

class ListingRoom extends StatefulWidget {
  static get path => '/room-listing';
  const ListingRoom({super.key});

  @override
  State<ListingRoom> createState() => _ListingRoomState();
}

class _ListingRoomState extends State<ListingRoom> {
  final roomCon = Get.put(RoomController());
  final bookingCon = Get.put(BookingController());
  @override
  void initState() {
    roomCon.getListingRoom();
    bookingCon.newMeetingList.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    L.current.test;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text("Meeting Rooms"),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15.0).copyWith(top: 20),
          child: roomCon.loadings.value
              ? Center(
                  child:
                      CircularProgressIndicator(color: AppColors.primaryColor))
              : roomCon.roomListing.isNotEmpty
                  ? Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: context.height,
                            maxWidth: context.width > 500
                                ? context.width * 0.4
                                : context.width),
                        child: GridView.builder(
                          itemCount: roomCon.roomListing.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 200,
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return CustomListingRoom(
                              title: roomCon.roomListing[index].title,
                              onTap: () {
                                debugPrint(
                                    'roomId: ${roomCon.roomListing[index].id}');
                                context.go(
                                  '/rooms/room/${roomCon.roomListing[index].id}',

                                  // extra: {
                                  //   'roomListingModel':
                                  //       roomCon.roomListing[index],
                                  // }
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
        ),
      ),
    );
  }
}
