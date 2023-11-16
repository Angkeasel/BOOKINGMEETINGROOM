import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:go_router/go_router.dart';

import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/listing/room_controller.dart';

class ListingRoom extends StatefulWidget {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Rooms Meeting",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
            child: Column(
              children: [
                Text(
                  "Please Selecte Your Room Meeting !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.primaryColor),
                ),
                roomCon.roomListing.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              roomCon.roomListing.asMap().entries.map((e) {
                            return GestureDetector(
                              onTap: () {
                                roomCon.currentIndex.value = e.value.id!;
                                debugPrint(
                                    '====> indexID ${roomCon.currentIndex.value}');
                                GoRouter.of(context).go(
                                    '/room/room-meet/${roomCon.currentIndex.value}');
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200),
                                  child: Text("${e.value.name}")),
                            );
                          }).toList(),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
