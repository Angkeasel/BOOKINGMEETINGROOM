import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';

import '../../../constant/app_color.dart';

class ListDetailPage extends StatefulWidget {
  const ListDetailPage({super.key});

  @override
  State<ListDetailPage> createState() => _ListDetailPageState();
}

final roomCon = Get.put(RoomController());

class _ListDetailPageState extends State<ListDetailPage> {
  @override
  void initState() {
    roomCon.getListingRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking List by Room",
          style: TextStyle(
              fontSize: 22,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: roomCon.roomListing.asMap().entries.map((e) {
              return GestureDetector(
                onTap: () {
                  debugPrint('run..........${e.value.id}');
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return BookingRoomDetailsPage(
                  //     roomModel: e.value,
                  //   );
                  // }));
                  //==================> go routes
                  context.push('/booking-room/all-booking-user',
                      extra: {'roomModel': e.value});
                },
                child: Container(
                  width: context.width,
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${e.value.title}",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
