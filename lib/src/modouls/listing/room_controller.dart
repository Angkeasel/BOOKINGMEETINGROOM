import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';

import '../../util/helper/api_base_helper.dart';

class RoomController extends GetxController {
  final currentIndex = 0.obs;
  ApiBaseHelper api = ApiBaseHelper();

  final roomListing = [
    RoomListingModel(id: 1, name: 'Room1'),
    RoomListingModel(id: 2, name: 'Room3'),
    RoomListingModel(id: 3, name: 'Room3'),
  ].obs;
  // final roomListing = <RoomListingModel>[].obs;
  Future<List<RoomListingModel>> getListingRoom() async {
    return [];
    List<RoomListingModel> listRoom = [];
    await api
        .onNetworkRequesting(
            url: "/room/", methode: METHODE.get, isAuthorize: true)
        .then((value) {
      value.map((e) {
        listRoom.add(RoomListingModel.fromJson(e));
      }).toList();
      roomListing.assignAll(listRoom);
      debugPrint('==========> testing room ${roomListing.length}');
    }).onError((ErrorModel error, stackTrace) {
      debugPrint("=========> get roomListing Error $error");
    });
    return roomListing;
  }
}
