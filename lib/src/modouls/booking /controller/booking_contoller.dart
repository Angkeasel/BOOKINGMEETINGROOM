import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/util/helper/api_base_helper.dart';
import '../models/meeting/meeting_model.dart';

class BookingController extends GetxController {
  final colorString = ''.obs;
  final meetingList = <Meeting>[].obs;

  // textfield comfirm booking
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final api = ApiBaseHelper();
  final List<Meeting> _event = [
    Meeting(
        meetingTopic: 'testing 1',
        backgroundColor: "#540000",
        startTime: '2024-06-28T08:00:00.000Z',
        isAllDay: false,
        endTime: '2024-06-28T09:00:00.000Z',
        email: 'testing1@gmail.com',
        phoneNumber: '1234567',
        firstName: 'test',
        lastName: '1',
        location: 'head',
        duration: 1),
    Meeting(
        meetingTopic: 'testing 2',
        backgroundColor: "#540000",
        //  startTime: DateTime(2024, 05, 25, 8, 0),
        startTime: '2024-05-29T09:00:00.000Z',
        isAllDay: false,
        endTime: '2024-05-29T10:00:00.000Z',
        email: 'testing1@gmail.com',
        phoneNumber: '1234567',
        firstName: 'test',
        lastName: '1',
        location: 'head',
        duration: 30)
  ];
  List<Meeting> get events => _event;
  void addEvent(Meeting event) {
    _event.add(event);
    update();
  }

  final timeIndex = 0.obs;
  List<String> colors = [
    "#540000",
    "#F5821F",
    "#4E9B8F",
  ];
  final isSelected = 0.obs;
  String hourFormatFromMinutes(int minutes) {
    final duration = Duration(minutes: minutes);
    if (minutes < 60) {
      return '${minutes}min';
    }
    if (minutes % 60 == 0) {
      return '${duration.inHours}h';
    } else {
      return '${duration.inHours}h${minutes % 60}mins';
    }
  }

//==================> post Booking <======================
  final isBookingLoading = false.obs;
  Future<void> postBooking(
      {required String meetingTopic,
      String? id,
      required String phoneNumber,
      required String email,
      required String firstName,
      required String lastName,
      required String location,
      required String date,
      required String startTime,
      required String endTime,
      required int duration,
      required String color}) async {
    isBookingLoading.value = true;
    final body = {
      "meetingTopic": meetingTopic,
      "phoneNumber": phoneNumber,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "location": location,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
      "duration": duration,
      "backgroundColor": color
    };
    await api
        .onNetworkRequesting(
            url: '/book/$id/booking',
            methode: METHODE.post,
            isAuthorize: true,
            body: body)
        .then((value) async {
      debugPrint(' create booking value is $value');
      isBookingLoading.value = false;
    }).onError((ErrorModel error, stackTrace) {
      isBookingLoading.value = false;
      debugPrint(
          'post booking not work ${error.statusCode} ${error.bodyString}');
    });
  }

//====================> getBookingByIdroom <==================================
  final eventList = <Meeting>[].obs;
  final eventModel = Meeting().obs;
  final isFetchEvent = false.obs;
  Future<List<Meeting>> getBooking({String? id}) async {
    isFetchEvent.value = true;
    await api
        .onNetworkRequesting(
            url: '/book/$id/bookings', methode: METHODE.get, isAuthorize: true)
        .then((value) {
      //debugPrint('get all booking ${value['room']['booking']}');
      value['room']['booking'].map((e) {
        eventModel.value = Meeting.fromJson(e);
        //debugPrint('====> event model ${eventModel.value}');
        eventList.add(eventModel.value);
        debugPrint('=====> get event list $eventList');
      }).toList();
      isFetchEvent.value = false;
    }).onError((ErrorModel error, stackTrace) {
      isFetchEvent.value = false;
      debugPrint(
          'post booking not work ${error.statusCode} ${error.bodyString}');
    });
    return eventList;
  }

  //=========================> getAvailableTime <=============================
  final slotList = <String>[].obs;
  final isLoadingSlot = false.obs;
  Future<List<String>> getAvailableTimeSlot({required String date}) async {
    final dateformat = DateFormat('yyyy-MM-dd');
    final dateString = dateformat.parse(date).toString().split(' ').first;
    try {
      isLoadingSlot(true);
      await api
          .onNetworkRequesting(
        url: '/book/available-timeslots?date=$dateString',
        methode: METHODE.get,
        isAuthorize: true,
      )
          .then((value) {
        debugPrint('get value slot ${value['availableTimeSlots']}');
        slotList.value = List<String>.from(value['availableTimeSlots']);
        debugPrint('slotList $slotList');
        isLoadingSlot(false);
      }).onError((ErrorModel error, stackTrace) {
        isLoadingSlot(false);
        debugPrint(
            'post availableTime not work ${error.statusCode} ${error.bodyString}');
      });
    } catch (e) {
      debugPrint('errr catch body ${e.toString()}');
    }
    return slotList;
  }

//==============================> getBooking by date <===================================
  final bookingModel = Meeting().obs;
  final bookingList = <Meeting>[].obs;
  final isLoadingDate = false.obs;
  Future<List<Meeting>> getBookingByDate({required String date}) async {
    final dateformat = DateFormat('yyyy-MM-dd');
    final dateString = dateformat.parse(date).toString().split(' ').first;
    try {
      isLoadingDate(true);
      debugPrint('date in function $dateString');
      await api
          .onNetworkRequesting(
              url: '/book/booked?date=$dateString',
              methode: METHODE.get,
              isAuthorize: true)
          .then((value) {
        debugPrint('get value respone ${value['booked']} ');
        value['booked'].map((e) {
          bookingModel.value = Meeting.fromJson(e);
          bookingList.add(bookingModel.value);
        }).toList();
        isLoadingDate(false);
      }).onError((ErrorModel error, stackTrace) {
        isLoadingDate(false);
        debugPrint(
            'get Booking by date not work ${error.statusCode} ${error.bodyString}');
      });
    } catch (e) {
      debugPrint('errr catch body ${e.toString()}');
    }
    return bookingList;
  }

  @override
  void onInit() {
    getBooking();
    update();
    super.onInit();
  }
}
