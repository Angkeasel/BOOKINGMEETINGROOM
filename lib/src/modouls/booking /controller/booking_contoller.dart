import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:meetroombooking/src/util/helper/api_base_helper.dart';
import '../../../../widgets/loading_dialog.dart';
import '../../../util/helper/snackbar/alert_snackbar.dart';
import '../models/meeting/meeting_model.dart';
import '../page/verify_booking.dart';

class BookingController extends GetxController {
  final colorString = ''.obs;
  final editColorString = ''.obs;
  final meetingList = <Meeting>[].obs;
  final bookingByUserList = <Meeting>[].obs;

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
  final isSelected = ''.obs;
  final isSelectedEdit = ''.obs;
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

//===============================> post Booking <=============================
  final isBookingLoading = false.obs;
  Future<void> postBooking(BuildContext context,
      {required String meetingTopic,
      required String id,
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

    try {
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
        // post then fetch
        getBooking(id: id);
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Verifybooking(
            date: date,
            durations: duration,
            fromTime: startTime,
            toTime: endTime,
            location: location,
            userName: firstName,
          );
        }));
        isBookingLoading.value = false;
      }).onError((ErrorModel error, stackTrace) {
        debugPrint(
            'post booking not work ${error.statusCode} ${error.bodyString}');
        Get.snackbar(
          'Duplicated select time ',
          error.bodyString['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        //alertErrorSnackbar(title: 'Error', message: error.bodyString);

        isBookingLoading.value = false;
      });
    } catch (e) {
      debugPrint('Error show $e');
      alertErrorSnackbar(title: 'Error', message: e);
    }
  }

//====================> getBookingByIdroom <==================================
  final eventList = <Meeting>[].obs;
  final eventModel = Meeting().obs;
  final isFetchEvent = false.obs;
  Future<List<Meeting>> getBooking({required String id}) async {
    debugPrint('============> get booking all Id : $id');
    isFetchEvent.value = true;
    await api
        .onNetworkRequesting(
            url: '/book/$id/bookings', methode: METHODE.get, isAuthorize: true)
        .then((value) {
      //debugPrint('get all booking ${value['room']['booking']}');
      value['room'].map((e) {
        eventModel.value = Meeting.fromJson(e);
        //debugPrint('====> event model ${eventModel.value}');
        eventList.add(eventModel.value);
        debugPrint('=====> get event list $eventList');
      }).toList();
      isFetchEvent.value = false;
    }).onError((ErrorModel error, stackTrace) {
      isFetchEvent.value = false;
      debugPrint(
          'post booking not work ${error.statusCode} ${error.bodyString} ');
    });
    return eventList;
  }

  //=========================> getAvailableTime <=============================
  final slotList = <String>[].obs;
  final isLoadingSlot = false.obs;
  Future<List<String>> getAvailableTimeSlot(
      {required String date, required String roomId}) async {
    final dateformat = DateFormat('yyyy-MM-dd');
    final dateString = dateformat.parse(date).toString().split(' ').first;
    try {
      isLoadingSlot(true);
      await api
          .onNetworkRequesting(
        url: '/book/$roomId/available-timeslots?date=$dateString',
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

//===============================> Edit Booking <================================
  final isLoadingUpdate = false.obs;
  Future<void> updateMeeting({
    String? meetingTopic,
    String? phoneNumber,
    String? email,
    String? firstName,
    String? lastName,
    String? location,
    String? date,
    String? startTime,
    String? endTime,
    int? duration,
    String? color,
    String? id,
    String? roomId,
  }) async {
    isLoadingUpdate(true);
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
    try {
      await api
          .onNetworkRequesting(
              url: '/book/updateBooking/$id',
              methode: METHODE.update,
              isAuthorize: true,
              body: body)
          .then((value) async {
        debugPrint('=====> print update value $value');
        roomId = value['byRoom'];
        debugPrint('=====> print roomId value $roomId');
        await Get.put(BookingController()).getBookedListByRoomId(
          roomId: roomId!,
        );
        isLoadingUpdate(false);
      }).onError((ErrorModel error, stackTrace) {
        Get.snackbar(
          'Duplicated select time ',
          error.bodyString['message'],
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        isLoadingUpdate(false);
      });
    } catch (e) {
      isLoadingUpdate(false);
      debugPrint('errr catch body kkkkk ${e.toString()}');
    }
  }

  final delLoading = false.obs;
//============================> Deleted Booking <===================================
  Future<void> deleteMeeting(
      {required BuildContext context,
      required String id,
      required String roomId}) async {
    showLoading(context);
    try {
      await api
          .onNetworkRequesting(
              url: '/book/$id', methode: METHODE.delete, isAuthorize: true)
          .then((value) async {
        debugPrint('Delelet Meeting Success : $value');
        newMeetingList.clear();
        List<Meeting> bookingList = await Get.put(BookingController())
            .getBookedListByRoomId(roomId: roomId);

        // .getBookedListByRoomId(roomId: roomId);
        debugPrint('call back booking list $bookingList ');
        removeLoading();

        //await Get.put(BookingController()).getBookingByUser();
      }).onError((ErrorModel err, _) {
        debugPrint('Delelet Meeting Error ${err.bodyString}');
        removeLoading();
      });
    } catch (e) {
      debugPrint('error catch body ${e.toString()}');
      removeLoading();
    }
  }

  //================================> check Overlapping <============================
  final isOverlapping = false.obs;
  final isOverlaped = false.obs;
  Future<bool> checkOverlapping(
      {required String date,
      String? startTime,
      String? endTime,
      required String roomId}) async {
    final dateformat = DateFormat('yyyy-MM-dd');
    final dateString = dateformat.parse(date).toString().split(' ').first;
    //2024-06-17 09:00:00.000
    //debugPrint('startTime $startTime');
    try {
      await api
          .onNetworkRequesting(
        url:
            '/book/$roomId/get-check?date=$dateString&startTime=$startTime&endTime=$endTime',
        methode: METHODE.get,
        isAuthorize: true,
      )
          .then((value) {
        isOverlaped.value = value['overlap'] as bool;
      });
    } catch (e) {
      debugPrint('errr catch body ${e.toString()}');
    }
    return isOverlaped.value;
  }

  //============================> get booking by user <=================================
  final isLoadingMeetingUser = false.obs;
  final loadingNextPage = false.obs;
  final newMeetingList = <Meeting>[].obs;
  final totalPage = 1.obs;
  final isLoading = false.obs;

  /// Get booking List by Current User
  Future<List<Meeting>> getBookedListByRoomId({
    required String roomId,
    int page = 1,
  }) async {
    // roomId is required
    debugPrint('=======> roomId is required $roomId');
    if (roomId == '') return [];
    // if (loading) {
    //   isLoadingMeetingUser(true);
    // }
    isLoadingMeetingUser(true);
    if (page == 1) {
      isLoadingMeetingUser(true);
      loadingNextPage(false);
    }
    if (page != 1) {
      isLoadingMeetingUser(false);
      loadingNextPage(true);
    }
    try {
      await api
          .onNetworkRequesting(
        url: '/book/bookings?page=$page&limit=10&roomId=$roomId&status=pending',
        methode: METHODE.get,
        isAuthorize: true,
      )
          .then(
        (response) {
          debugPrint('response ${response['bookings']}');
          if (page == 1) {
            newMeetingList.clear();
          }
          totalPage.value = response['totalPages'];
          response['bookings'].map((value) {
            newMeetingList.add(Meeting.fromJson(value));
          }).toList();
          debugPrint('=====> totalItems : ${newMeetingList.length}');
          isLoadingMeetingUser(false);
          loadingNextPage(false);
        },
      ).onError((ErrorModel _, __) {
        isLoadingMeetingUser(false);
        loadingNextPage(false);
      });
    } catch (error) {
      debugPrint('errr catch body tttttt ${error.toString()}');
      isLoadingMeetingUser(false);
      loadingNextPage(false);
    }
    return newMeetingList;
  }

  /// Get First Page or Refresh Page
  Future<void> getAllBookedListByRoomId(String roomId) async {
    currentPage = 1;
    showNoMoreData.value = false;
    loadingNextPage.value = false;
    await getBookedListByRoomId(roomId: roomId, page: currentPage);
  }

  int currentPage = 1;
  final showNoMoreData = false.obs;
  Future<void> getNextPage(String roomId) async {
    debugPrint('fetch page : $currentPage ${totalPage.value}');
    // if previous page is fetching we don't get next page
    if (loadingNextPage.value) return;
    // get more bookings if current page smaller than total page
    if (currentPage < totalPage.value) {
      currentPage++;
      getBookedListByRoomId(roomId: roomId, page: currentPage);
    }
    // No more data
    else if (currentPage == totalPage.value) {
      showNoMoreData.value = true;
      await Future.delayed(const Duration(seconds: 2));
      showNoMoreData.value = false;
    }
  }
}
