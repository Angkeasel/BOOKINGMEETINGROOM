import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';

import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_datasource.dart';

import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';
import 'package:meetroombooking/src/modouls/listing/model/room_listing_model.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../listing/page/time_listing_page.dart';
import '../models/meeting/meeting_model.dart';

class EventCalendarPage extends StatefulWidget {
  final RoomListingModel? roomListingModel;
  const EventCalendarPage({super.key, this.roomListingModel});
  @override
  State<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  @override
  void initState() {
    fetch();
    debugPrint("datetime now  ${DateTime.now()}");
    //calendarController.selectedDate = DateTime.now();
    //calendarController.displayDate = DateTime.now();
    super.initState();
  }

  final CalendarController calendarController = CalendarController();
  final MonthAppointmentDisplayMode _displayMode =
      MonthAppointmentDisplayMode.indicator;
  String? text;
  final roomCon = Get.put(RoomController());
  final homeCon = Get.put(HomeController());
  final bookingCon = Get.put(BookingController());
  Future<List<Meeting>> fetch() async {
    try {
      await bookingCon
          .getBooking(id: widget.roomListingModel?.id)
          .then((value) {
        debugPrint('value fetch $value');
        setState(() {
          bookingCon.meetingList.value = value;
        });
        debugPrint('draft list event ${bookingCon.meetingList.length} ');
      });
    } catch (e) {
      debugPrint('Error');
    }
    return bookingCon.meetingList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.roomListingModel?.title ?? '',
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
        builder: (_) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SfCalendar(
            controller: calendarController,
            initialDisplayDate: DateTime.now(),
            initialSelectedDate: DateTime.now(),
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
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            showTodayButton: false,
            showDatePickerButton: true,
            showNavigationArrow: true,
            view: CalendarView.month,
            appointmentTimeTextFormat: 'HH:mm a',
            // cellBorderColor: Colors.transparent,
            dataSource:
                MeetingDataSource(bookingCon.meetingList), // post events
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
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TimeListingPage(
                  date: text!,
                  appointment: bookingCon.meetingList,
                  roomListingModel: widget.roomListingModel,
                );
              }));
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
      text = DateFormat('yyyy-MM-dd ').format(details.date!).toString();
    } else {
      text =
          DateFormat('yyyy-MM-dd HH:mm:ss ').format(details.date!).toString();
    }
    debugPrint('testing print : $text');
  }
}
