import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constant/app_color.dart';
import '../booking /time_model/time_model.dart';
import '../home/home_controller.dart';
import '../listing/controller/room_controller.dart';

class CalendarTable extends StatefulWidget {
  const CalendarTable({super.key});

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
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
  List<TimeModel> generatedTimeSlots = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          TableCalendar(
            pageAnimationEnabled: true,
            locale: 'en',
            headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                titleCentered: false,
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: DateFormat.MMMMEEEEd()
                      .format(currentDay)
                      .contains(DateFormat.MMMMEEEEd().format(DateTime.now()))
                  ? Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Today"),
                                Text(
                                  ' ${DateFormat.MMMMEEEEd().format(currentDay)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        ' ${DateFormat.MMMMEEEEd().format(currentDay)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
            ),
          ),
          // Expanded(
          //   child: ListView.separated(
          //     shrinkWrap: true,
          //     itemCount: availableSlots.length - 1,
          //     separatorBuilder: (context, index) =>
          //         const SizedBox(height: padding),
          //     itemBuilder: (context, index) {
          //       return CustomTimeCard(
          //           onTap: () {
          //             bookedSlots.add(homeCon.testing.value);
          //             final location =
          //                 GoRouterState.of(context).uri.toString();
          //             print(
          //                 'print $location/confirm-booking?millisecondsSinceEpoch=${currentDay.millisecondsSinceEpoch}');
          //             context.push(
          //                 '$location/confirm-booking?millisecondsSinceEpoch=${DateTime(2023).copyWith(hour: 8, second: 0).millisecondsSinceEpoch}');
          //             // context.pushNamed(
          //             //     'ConfirmBookingScreen'
          //             //     // '/room/0//confirm-booking?time=${homeCon.testing.value}&index=$addIndex',
          //             //     // ),
          //             //     ,
          //             //     pathParameters: {
          //             //       'id': '1',
          //             //     },
          //             //     queryParameters: {
          //             //       'time': 'homeCon.testing.value',
          //             //       'index': '0'
          //             //     });
          //           },
          //           time: availableSlots[index],
          //           isSelected: homeCon.testing.value ==
          //               "${availableSlots[index]}-${availableSlots[index + addIndex]}");
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
