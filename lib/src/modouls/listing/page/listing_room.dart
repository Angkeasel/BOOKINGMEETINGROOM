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
    bookingCon.page.value = 1;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (roomCon.roomListing.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        itemCount: roomCon.roomListing.length,
                        shrinkWrap: false,
                        physics: const NeverScrollableScrollPhysics(),
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
                              context.go('/rooms/room', extra: {
                                'roomListingModel': roomCon.roomListing[index],
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
