import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:meetroombooking/generated/l10n.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';

import '../../booking /page/event_calendar_page.dart';

class ListingRoom extends StatefulWidget {
  static get path => '/room-listing';
  const ListingRoom({super.key});

  @override
  State<ListingRoom> createState() => _ListingRoomState();
}

class _ListingRoomState extends State<ListingRoom> {
  final roomCon = Get.put(RoomController());
  @override
  void initState() {
    roomCon.getListingRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    L.current.test;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Meeting Rooms"),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Add New Room',
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (roomCon.roomListing.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: roomCon.roomListing.asMap().entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: padding),
                        child: Material(
                          type: MaterialType.transparency,
                          borderRadius: BorderRadius.circular(5),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {
                              debugPrint('roomId: ${e.value.id}');
                              // context.go('/rooms/room', extra: e.value);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return EventCalendarPage(
                                  roomListingModel: e.value,
                                );
                              }));
                            },
                            child: Ink(
                              width: double.infinity,
                              // margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(15),
                              color: Colors.grey.shade200,
                              child: Text("${e.value.title}"),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            const Text("data")
          ],
        ),
      ),
    );
  }
}
