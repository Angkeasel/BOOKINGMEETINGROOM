import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';

import '../../../constant/app_color.dart';
import '../../listing/model/room_listing_model.dart';

class ListingFilterRoomPage extends StatefulWidget {
  const ListingFilterRoomPage({super.key});

  @override
  State<ListingFilterRoomPage> createState() => _ListingFilterRoomPageState();
}

final roomCon = Get.put(RoomController());
RoomListingModel? selectedRoom;

class _ListingFilterRoomPageState extends State<ListingFilterRoomPage> {
  @override
  void initState() {
    roomCon.getListingRoom();
    selectedRoom = roomCon.roomListing[0];
    debugPrint('=========> ${roomCon.getListingRoom}');
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              child: DropdownButton<RoomListingModel>(
                value: selectedRoom,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: roomCon.roomListing.map((items) {
                  return DropdownMenuItem(
                    onTap: () {
                      selectedRoom = items;
                    },
                    value: items,
                    child: Text('${items.title}'),
                  );
                }).toList(),
                onChanged: (RoomListingModel? newValue) {
                  setState(() {
                    selectedRoom = newValue!;
                    debugPrint(
                        '========> selectedRoom ${roomCon.selectRoom.value}');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
