import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/modouls/listing/room_controller.dart';

class ListingRoom extends StatelessWidget {
  const ListingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final roomCon = Get.put(RoomController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.canPop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: roomCon.roomListing.asMap().entries.map((e) {
            return GestureDetector(
              onTap: () {
                roomCon.currentIndex.value = e.key;
                debugPrint('====> index ${roomCon.currentIndex.value}');
                GoRouter.of(context).go('/room/booking');
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const EventCalendarPage();
                // }));
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.amber),
                  child: Text(e.value)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
