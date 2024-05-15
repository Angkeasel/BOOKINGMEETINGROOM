import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_model.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';

import '../../../util/helper/api_base_helper.dart';

class RoomController extends GetxController {
  final currentIndex = 0.obs;
  ApiBaseHelper api = ApiBaseHelper();
  final roomListing = <RoomListingModel>[].obs;
  List allTimeSlots = <DateTime>[]
      .obs; // for debugprint view all list timeslot no need to used on screen anymore
  List availableTimeSlots = <DateTime>[].obs;
  // final roomListing = [
  //   RoomListingModel(id: 1, name: 'Room1'),
  //   RoomListingModel(id: 2, name: 'Room3'),
  //   RoomListingModel(id: 3, name: 'Room3'),
  // ].obs;
  // final roomListing = <RoomListingModel>[].obs;

  Future<List<RoomListingModel>> getListingRoom() async {
    List<RoomListingModel> listRoom = [];
    try {
      await api
          .onNetworkRequesting(
              url: "/room/", methode: METHODE.get, isAuthorize: true)
          .then((value) {
        value.map((e) {
          listRoom.add(RoomListingModel.fromJson(e));
        }).toList();
        roomListing.assignAll(listRoom);
        debugPrint('==========> testing room ${roomListing.length}');
        debugPrint('==========> roomId ${roomListing[0]}');
      }).onError((ErrorModel error, stackTrace) {
        debugPrint("=========> get roomListing Error $error");
      });
    } catch (e) {
      debugPrint('testing get room $e');
    }
    return roomListing;
  }

  //Find available slots
  List<DateTime> getTimeSlots(DateTime date) {
    List<DateTime> timeSlots = [];
    // Define time range (e.g., from 8 AM to 5 PM)
    DateTime startTime = DateTime(date.year, date.month, date.day, 8, 0);
    DateTime endTime = DateTime(date.year, date.month, date.day, 17, 30);

    // Generate time slots every 30 minutes
    DateTime currentTime = startTime;
    while (currentTime.isBefore(endTime)) {
      timeSlots.add(currentTime);
      currentTime = currentTime.add(const Duration(minutes: 30));
    }
    return timeSlots;
  }

  List<DateTime> getAvailableTimeSlots(
      DateTime date, List<Meeting> appointments) {
    List<DateTime> allTimeSlots = getTimeSlots(date);
    List<DateTime> bookedTimeSlots = [];

    // Collect all booked time slots from appointments
    for (Meeting appointment in appointments) {
      if (appointment.from.day == date.day) {
        DateTime currentTime = appointment.from;
        while (currentTime.isBefore(appointment.to)) {
          bookedTimeSlots.add(DateTime(currentTime.year, currentTime.month,
              currentTime.day, currentTime.hour, currentTime.minute));
          currentTime = currentTime.add(const Duration(minutes: 30));
        }
      }
    }
    // Filter out booked time slots to get available time slots
    List<DateTime> availableTimeSlots =
        allTimeSlots.where((slot) => !bookedTimeSlots.contains(slot)).toList();
    return availableTimeSlots;
  }
}
