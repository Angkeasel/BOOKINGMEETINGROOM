import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/src/modouls/listing/room_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendarPage extends StatefulWidget {
  const EventCalendarPage({super.key});
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

  final now = DateTime.now();
  final roomCon = Get.put(RoomController());
  Map<DateTime, List>? events;

  List? selectedEvents;
  //========> time slot
  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 30);

  final step = const Duration(minutes: 30);
  final homeCont = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final times = getTimes(startTime, endTime, step)
        .map((todo) => todo.format(context))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Booking Your Meeting Room",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              context.pop();
              debugPrint('=>>>>>>>> check pop route booking');
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
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
                // currentDay: currentDay,
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
                  // selectedTextStyle: const TextStyle(fontSize: 16,color: Colors.white),
                  // selectedDecoration:  BoxDecoration(color: Colors.green,border: Border.all(color: Colors.green), shape: BoxShape.circle),
                  defaultDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryColor)),
                  // todayTextStyle: const TextStyle(color: Colors.black,  fontSize: 14, fontWeight: FontWeight.w300),
                  // todayDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color:  Colors.green))
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
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    currentDay = selectedDay;
                    focusDay = focusedDay;
                    dateSelect = true;
                    debugPrint('=======>currentdat $currentDay');
                    debugPrint('=======>focusDay $focusDay');
                  });
                },

                onPageChanged: (focusedDay) {
                  focusDay = focusedDay;
                },

                // onCalendarCreated: (pageController) {
                // },
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, datetime, events) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            border:
                                Border.all(color: Colors.deepPurple, width: 2)),
                        child: Center(
                            child: Text(
                          "${datetime.day}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )));
                  },
                  todayBuilder: (context, day, focusedDay) {
                    return Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryColor)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
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
                          // const SizedBox(
                          //   height: 1,
                          // ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Select Consulation Time=====> ${homeCont.testing.value}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 50,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: times.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Material(
                    child: InkWell(
                      highlightColor: Colors.blue.withOpacity(0.4),
                      splashColor: Colors.green.withOpacity(0.5),
                      onTap: () {
                        debugPrint("=======> selected time ${times[index]}");
                        homeCont.testing.value = times[index];
                        homeCont.update();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            times[index],
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventList() {
    return ListView(
      children: selectedEvents!
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => debugPrint('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
