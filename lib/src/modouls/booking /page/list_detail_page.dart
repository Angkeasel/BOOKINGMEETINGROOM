import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import '../../../constant/app_color.dart';

class ListDetailPage extends StatelessWidget {
  const ListDetailPage({super.key});

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
      body: Obx(
        () => Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth:
                    context.width > 500 ? context.width * 0.4 : context.width),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16).copyWith(bottom: 30),
              itemCount: roomCon.roomListing.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    debugPrint('run..........${roomCon.roomListing[index].id}');
                    context
                        .go('/booking-room/${roomCon.roomListing[index].id}');
                    //  extra: {'roomModel': roomCon.roomListing[index]});
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
                        Expanded(
                          child: Text(
                            "${roomCon.roomListing[index].title}",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

final roomCon = Get.put(RoomController());
