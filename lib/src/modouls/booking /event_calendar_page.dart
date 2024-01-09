import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/src/modouls/listing/room_controller.dart';
import 'package:meetroombooking/widgets/custom_time_card.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendarPage extends StatefulWidget {
  final int? id;
  const EventCalendarPage({super.key, this.id});
  @override
  State<EventCalendarPage> createState() => _EventCalendarPageState();
}

class _EventCalendarPageState extends State<EventCalendarPage> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusDay = DateTime.now();
  DateTime currentDay = DateTime.now();
  int? currentIndex;
  bool isweekend = false;
  bool dateSelect = false;
  bool timeSelect = false;
  bool outsideDaysVisible = false;
  int addIndex = 1;

// init Day of Canlendar
  final now = DateTime.now();
  final roomCon = Get.put(RoomController());
  final homeCon = Get.put(HomeController());

//generateAll Time slots by splite 30min
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 17, minute: 0);
  final step = const Duration(minutes: 30);

// Assume booked slots for a particular date
  List<String> bookedSlots = [];

//Find available slots
  List<String> findAvailableSlots(List<String> bookedSlots) {
    List<String> availableSlots = [];
    List<String> allSlots = homeCon
        .generateAllTimeSlots(startTime, endTime, step)
        .map((e) => e.format(context))
        .toList();
// Assuming all slots from 8 AM to 5 PM
    for (String slot in allSlots) {
      if (!bookedSlots.contains(slot)) {
        availableSlots.add(slot);
      }
    }
    return availableSlots;
  }

  @override
  void initState() {
    debugPrint('hello ${widget.id}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableSlots = findAvailableSlots(bookedSlots);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking Your Meeting Room ${widget.id}",
        ),
      ),
      body: SafeArea(
        minimum: defaultMinSafeArea.copyWith(left: padding, right: padding),
        child: Column(
          children: [
            TableCalendar(
              locale: 'en',
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  leftChevronVisible: outsideDaysVisible ? false : true,
                  leftChevronIcon: Icon(
                    outsideDaysVisible ? null : Icons.chevron_left,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: AppColors.primaryColor,
                    size: 30,
                  )),
              firstDay: now,
              lastDay: DateTime(3000),
              focusedDay: focusDay,
              calendarFormat: calendarFormat,
              rowHeight: 50,
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                cellMargin: const EdgeInsets.all(5),
                cellPadding: const EdgeInsets.all(10),
                outsideDaysVisible: outsideDaysVisible,
                weekendDecoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: AppColors.primaryColor),
                    shape: BoxShape.circle),
                defaultDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryColor)),
              ),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
                CalendarFormat.week: 'week'
              },
              onFormatChanged: (formats) {
                setState(() {
                  calendarFormat = formats;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(currentDay, day);
              },

              //==============> selected day <==================
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  currentDay = selectedDay;
                  focusDay = focusedDay;
                  dateSelect = true;
                  debugPrint(
                      '=======>currentdate ${DateFormat.yMMMMEEEEd().format(currentDay)}');
                  final currentSelected =
                      DateFormat.yMMMMEEEEd('en').format(currentDay);
                  debugPrint('=======>focusDay $currentSelected');
                });
              },
              onPageChanged: (focusedDay) {
                focusDay = focusedDay;
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, datetime, events) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                        border: Border.all(color: Colors.deepPurple, width: 2)),
                    child: Center(
                      child: Text(
                        "${datetime.day}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: AppColors.primaryColor)),
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            day.day.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        )),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: DateFormat.MMMMEEEEd()
                      .format(currentDay)
                      .contains(DateFormat.MMMMEEEEd().format(DateTime.now()))
                  ? Column(
                      children: [
                        const Text("Today"),
                        Text(
                          ' ${DateFormat.MMMMEEEEd().format(currentDay)}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  : Text(
                      ' ${DateFormat.MMMMEEEEd().format(currentDay)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: availableSlots.length - 1,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: padding),
                itemBuilder: (context, index) {
                  return CustomTimeCard(
                      onTap: () {
                        bookedSlots.add(homeCon.testing.value);
                        final location =
                            GoRouterState.of(context).uri.toString();
                        print(
                            '$location/confirm-booking?millisecondsSinceEpoch=${currentDay.millisecondsSinceEpoch}');
                        context.push(
                            '$location/confirm-booking?millisecondsSinceEpoch=${DateTime(2023).copyWith(hour: 8, second: 0).millisecondsSinceEpoch}');
                        // context.pushNamed(
                        //     'ConfirmBookingScreen'
                        //     // '/room/0//confirm-booking?time=${homeCon.testing.value}&index=$addIndex',
                        //     // ),
                        //     ,
                        //     pathParameters: {
                        //       'id': '1',
                        //     },
                        //     queryParameters: {
                        //       'time': 'homeCon.testing.value',
                        //       'index': '0'
                        //     });
                      },
                      time: availableSlots[index],
                      isSelected: homeCon.testing.value ==
                          "${availableSlots[index]}-${availableSlots[index + addIndex]}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
