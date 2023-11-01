import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:meetroombooking/src/config/app_color.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    events = {
      currentDay.subtract(const Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      currentDay.subtract(const Duration(days: 27)): ['Event A1'],
      currentDay.subtract(const Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      currentDay.subtract(const Duration(days: 16)): ['Event A3', 'Event B3'],
      currentDay.subtract(const Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      currentDay.subtract(const Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      currentDay.subtract(const Duration(days: 2)): ['Event A6', 'Event B6'],
      currentDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      currentDay.add(const Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      currentDay.add(const Duration(days: 3)):
          {'Event A9', 'Event A2', 'Event B9'}.toList(),
      currentDay.add(const Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      currentDay.add(const Duration(days: 11)): ['Event A11', 'Event B11'],
      currentDay.add(const Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      currentDay.add(const Duration(days: 22)): ['Event A13', 'Event B13'],
    };
    selectedEvents = events?[currentDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Select Consulation Time',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
              itemCount: roomCon.timeListing.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        roomCon.timeListing[index],
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            // Expanded(child: buildEventList())
            // SliverGrid(
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 200.0,
            //     mainAxisSpacing: 10.0,
            //     crossAxisSpacing: 10.0,
            //     childAspectRatio: 4.0,
            //   ),
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       return Container(
            //         alignment: Alignment.center,
            //         color: Colors.teal[100 * (index % 9)],
            //         child: Text('grid item $index'),
            //       );
            //     },
            //     childCount: 20,
            //   ),
            // )
            //Text('$currentDay')
          ],
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
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
