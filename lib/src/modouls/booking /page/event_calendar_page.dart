import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';

import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_datasource.dart';
import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_model.dart';

import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/src/modouls/listing/controller/room_controller.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../listing/page/time_listing_page.dart';

class EventCalendarPage extends StatefulWidget {
  final String? id;
  final String? title;
  const EventCalendarPage({super.key, this.id, this.title});
  @override
  State<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  final CalendarController calendarController = CalendarController();
  String? text;

  final roomCon = Get.put(RoomController());
  final homeCon = Get.put(HomeController());
  final bookingCon = Get.put(BookingController());
  var event = Meeting(
      eventName: "testing 3 ",
      backgroundColor: Colors.pink,
      from: DateTime(2024, 05, 18, 11, 30),
      isAllDay: false,
      to: DateTime(2024, 05, 18, 11, 30).add(const Duration(minutes: 30)));

  @override
  void initState() {
    // List<DateTime> allTimeSlots = getTimeSlots(now);
    debugPrint("get event ${bookingCon.events}");
    calendarController.selectedDate = DateTime.now();
    // calendarController.displayDate = DateTime(2024, 05, 22);
    debugPrint('hello ${widget.id} and ${widget.title}');

    //homeCon.getGeneratedTimeSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          " ${widget.title}",
        ),
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  bookingCon.addEvent(event);
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text('save'),
              ))
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: SfCalendar(
          controller: calendarController,
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
          dataSource: MeetingDataSource(bookingCon.events), // post events
          monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
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
              // timeTextStyle: TextStyle(color: Colors.pink, fontSize: 10),
              startHour: 8,
              endHour: 18,
              timeInterval: Duration(minutes: 30),
              timeFormat: 'hh:mm a ',
              timeRulerSize: 80),
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
                    date: text!, appointment: bookingCon.events);

                // BookingPage(
                //   date: text!,
                //   location: widget.title!,
                // );
              }));
              // showCupertinoModalBottomSheet(
              //   context: context,
              //   builder: (context) => BookingPage(
              //     date: text,
              //   ),
              // );
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
      text = DateFormat('yyyy-MM-dd ').format(details.date!).toString();
    } else {
      text =
          DateFormat('yyyy-MM-dd HH:mm:ss ').format(details.date!).toString();
    }
    debugPrint('testing print : $text');
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return BookingPage(
    //     date: text!,
    //     location: widget.title!,
    //   );
    // }));

    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text("Details shown by selection changed callback"),
    //         content: Text("You have selected " '$text'),
    //         actions: <Widget>[
    //           TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: const Text('close'))
    //         ],
    //       );
    //     });
  }
}
