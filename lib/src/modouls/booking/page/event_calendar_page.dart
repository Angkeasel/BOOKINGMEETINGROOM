import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import '../controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/booking/models/meeting/meeting_datasource.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/meeting/meeting_model.dart';

class EventCalendarPage extends StatefulWidget {
  final bool? isEdit;
  final String? id; //  isEdit = true ?booking id :roomId
  const EventCalendarPage({super.key, this.isEdit, this.id});
  @override
  State<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  @override
  void initState() {
    debugPrint('=======> id room :${widget.id}');
    bookingCon.meetingList.clear();
    fetchBookingByIdEdit();
    debugPrint("datetime now  ${DateTime.now()}");
    super.initState();
  }

  final CalendarController calendarController = CalendarController();
  final MonthAppointmentDisplayMode _displayMode =
      MonthAppointmentDisplayMode.indicator;
  String? text;
  DateTime? dateTime;
  final roomCon = Get.put(RoomController());
  final homeCon = Get.put(HomeController());
  final bookingCon = Get.put(BookingController());
  //==================> Fetch booking Listing <=================
  Future<List<Meeting>> fetch(String roomId) async {
    try {
      await bookingCon.getBooking(id: roomId).then((value) {
        debugPrint('value fetch get booking event :$value');
        setState(() {
          bookingCon.meetingList.value = value;
          bookingCon.update();
        });
        debugPrint('draft list event ${bookingCon.meetingList.length} ');
      });
    } catch (e) {
      debugPrint('Error');
    }
    return bookingCon.meetingList;
  }

  Meeting bookingModelEdit = Meeting();
  RoomListingModel roomModel = RoomListingModel();
  Future<Meeting> fetchBookingByIdEdit() async {
    await bookingCon.fetchBookingById(widget.id!).then((value) {
      setState(() {
        bookingModelEdit = value;
        debugPrint('====> room id edit screen :${bookingModelEdit.byRoom}');
        widget.isEdit! ? showTime() : DateTime.now();
        widget.isEdit!
            ? roomCon.getRoomById(bookingModelEdit.byRoom!).then((value) {
                setState(() {
                  roomModel = value;
                  debugPrint('roomModel Edit $roomModel');
                });
              })
            : roomCon.getRoomById(widget.id!).then((value) {
                setState(() {
                  roomModel = value;
                  debugPrint('roomModel  $roomModel');
                });
              });
      });
      fetch(widget.isEdit! ? bookingModelEdit.byRoom! : widget.id!);
    });
    return bookingModelEdit;
  }

  DateTime showTime() {
    String dateString = bookingModelEdit.date ?? '';
    DateFormat format = DateFormat("yyyy-MM-dd");
    dateTime = format.parse(dateString);
    return dateTime!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.isEdit! ? 'Edit ${roomModel.title}' : roomModel.title ?? '',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            debugPrint('clear list meeting');
            bookingCon.meetingList.clear();
            Navigator.pop(context);
          },
        ),
      ),
      body: GetBuilder(
        init: BookingController(),
        builder: (_) => Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth:
                    context.width > 500 ? context.width * 0.4 : context.width),
            child: bookingCon.isFetchEvent.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SfCalendar(
                      controller: calendarController,
                      initialDisplayDate: DateTime.now(),
                      initialSelectedDate:
                          widget.isEdit! ? dateTime : DateTime.now(),
                      onSelectionChanged: selectionChanged,
                      minDate: DateTime.now(),
                      maxDate: DateTime(2040, 12, 31, 0, 0),
                      headerHeight: 50,
                      viewHeaderStyle: const ViewHeaderStyle(
                          dayTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                      headerStyle: CalendarHeaderStyle(
                          backgroundColor: AppColors.primaryColor,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      showTodayButton: false,
                      showDatePickerButton: true,
                      showNavigationArrow: true,
                      view: CalendarView.month,
                      appointmentTimeTextFormat: 'HH:mm a',
                      // cellBorderColor: Colors.transparent,
                      dataSource: MeetingDataSource(
                          bookingCon.meetingList), // post events
                      monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode: _displayMode,
                        showAgenda: true,
                        // agendaViewHeight: 200,
                      ),
                      selectionDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.pink, width: 2)),
                      blackoutDates: const [
                        // DateTime.now().subtract(const Duration(hours: 48)),
                        // DateTime.now().subtract(const Duration(hours: 24))
                      ],
                      allowedViews: const [
                        CalendarView.day,
                        CalendarView.month,
                        CalendarView.timelineWeek,
                        CalendarView.week,
                        CalendarView.workWeek
                      ],
                      timeSlotViewSettings: const TimeSlotViewSettings(
                          timeIntervalHeight: 200,
                          //timeTextStyle: TextStyle(color: Colors.pink, fontSize: 10),
                          startHour: 8,
                          endHour: 18,
                          timeInterval: Duration(minutes: 30),
                          timeFormat: 'hh:mm a ',
                          timeRulerSize: 80),
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              //================>************ fix here [millisecond] *************** <=====================
              debugPrint('==>************ fix here [millisecond] ${widget.id}');
              widget.isEdit!
                  ? context.go(
                      '/booking-room/${bookingModelEdit.byRoom}/edit-time-slot?date=$text&bookingId=${widget.id}',
                    )
                  : context.go(Uri(
                          path: '/rooms/time-slot',
                          queryParameters: {'date': text, 'id': widget.id})
                      .toString());
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  // check selectionChanged
  void selectionChanged(CalendarSelectionDetails details) {
    if (calendarController.view == CalendarView.month ||
        calendarController.view == CalendarView.timelineMonth) {
      debugPrint('format date details ${details.date}');
      text = DateFormat('yyyy-MM-dd').format(details.date!).toString();
    } else {
      text =
          DateFormat('yyyy-MM-dd HH:mm:ss ').format(details.date!).toString();
    }
    debugPrint('testing print : $text');
  }
}
