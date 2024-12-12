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
        title: const Center(
          child:  Text(
            "Booking List by Room",
            style: TextStyle(
                fontSize: 22,
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w700),
          ),
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
                       boxShadow:[
                        BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const  Offset(0, 2), // changes position of shadow
      ),
                      ] ,
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${roomCon.roomListing[index].title}",
                            style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.secondaryColor,
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
