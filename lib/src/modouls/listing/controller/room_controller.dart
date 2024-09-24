import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/config/router/router.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';
import '../../../util/helper/api_base_helper.dart';
import '../../../util/helper/local_storage/local_storage.dart';

class RoomController extends GetxController {
  final currentIndex = 0.obs;
  ApiBaseHelper api = ApiBaseHelper();
  final roomListing = <RoomListingModel>[].obs;
  final selectRoom = RoomListingModel().obs;
  final loadings = false.obs;
  // List allTimeSlots = <DateTime>[].obs; // for debugprint view all list timeslot no need to used on screen anymore
  // List availableTimeSlots = <DateTime>[].obs;

//=====================> Get All Room Listing <=========================
  Future<List<RoomListingModel>> getListingRoom() async {
    List<RoomListingModel> listRoom = [];
    try {
      loadings(true);
      await api
          .onNetworkRequesting(
              url: "/room", methode: METHODE.get, isAuthorize: true)
          .then((value) {
        value.map((e) {
          listRoom.add(RoomListingModel.fromJson(e));
        }).toList();
        roomListing.assignAll(listRoom);
        debugPrint('==========> testing room ${roomListing.length}');
        debugPrint('==========> roomId ${roomListing[0]}');
        loadings(false);
      }).onError((ErrorModel error, stackTrace) {
        debugPrint('error: $error');
        loadings(false);
      });
    } catch (e) {
      if (e is FormatException) {
        debugPrint('Invalid number format: ${e.source}');
        if (e.source == 'Unauthorized') {
          LocalStorage.storeData(key: "access_token", value: '');
          router.go('/login');
        }
      } else {
        debugPrint('Unexpected error: $e');
      }

      loadings(false);
    }
    return roomListing;
  }

  //=========================> get room by id  <===========================
  final roomModel = RoomListingModel().obs;
  Future<RoomListingModel> getRoomById(String id) async {
    await api
        .onNetworkRequesting(
            url: '/room/$id', methode: METHODE.get, isAuthorize: true)
        .then((value) {
      debugPrint('======> room listing by id :${value['rooms']}');
      var response = value['rooms'];
      roomModel.value = RoomListingModel.fromJson(response);
    });
    return roomModel.value;
  }

  //Find available slots
  // List<DateTime> getTimeSlots(DateTime date) {
  //   List<DateTime> timeSlots = [];
  //   // Define time range (e.g., from 8 AM to 5 PM)
  //   DateTime startTime = DateTime(date.year, date.month, date.day, 8, 0);
  //   DateTime endTime = DateTime(date.year, date.month, date.day, 17, 30);

  //   // Generate time slots every 30 minutes
  //   DateTime currentTime = startTime;
  //   while (currentTime.isBefore(endTime)) {
  //     timeSlots.add(currentTime);
  //     currentTime = currentTime.add(const Duration(minutes: 30));
  //   }
  //   return timeSlots;
  // }

  // List<DateTime> getAvailableTimeSlots(
  //     DateTime date, List<Meeting> appointments) {
  //   List<DateTime> allTimeSlots = getTimeSlots(date);
  //   List<DateTime> bookedTimeSlots = [];

  //   // Collect all booked time slots from appointments
  //   for (Meeting appointment in appointments) {
  //     if (DateTime.parse(appointment.startTime!).day == date.day) {
  //       DateTime currentTime = DateTime.parse(appointment.startTime!);
  //       while (currentTime.isBefore(DateTime.parse(appointment.endTime!))) {
  //         bookedTimeSlots.add(DateTime(currentTime.year, currentTime.month,
  //             currentTime.day, currentTime.hour, currentTime.minute));
  //         currentTime = currentTime.add(const Duration(minutes: 30));
  //       }
  //     }
  //   }
  //   // Filter out booked time slots to get available time slots
  //   List<DateTime> availableTimeSlots =
  //       allTimeSlots.where((slot) => !bookedTimeSlots.contains(slot)).toList();
  //   return availableTimeSlots;
  // }
  @override
  void onInit() {
    getListingRoom();
    super.onInit();
  }
}
