import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
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
        //backgroundColor: AppColors.secondaryColor,
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
        actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: kIsWeb? 100:0),
              child: CustomButtons(title: "Book Now",width:double.infinity,textColor: AppColors.primaryColor,color: AppColors.secondaryColor,onTap:(){
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
              }),
            ),
          const  SizedBox(width: 10,)
        ],
        titleTextStyle:context.appBarTextStyle.copyWith(
          color: AppColors.primaryColor,fontWeight: FontWeight.w700
        ), 
      ),
      
      body: GetBuilder(
        init: BookingController(),
        builder: (_) => Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth:
                    context.width > 500 ? context.width  : context.width),
            child: bookingCon.isFetchEvent.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.only(top: 5,right: kIsWeb? 100:0,left: kIsWeb?100:0),
                  child: SafeArea(
                    child: SfCalendar(
                      cellBorderColor: AppColors.primaryColor,
                      cellEndPadding: 15,
                      controller: calendarController,
                      initialDisplayDate: DateTime.now(),
                      initialSelectedDate:
                          widget.isEdit! ? dateTime : DateTime.now(),
                      onSelectionChanged: selectionChanged,
                      minDate: DateTime.now(),
                      maxDate: DateTime(2444, 12, 31, 0, 0),
                      headerHeight: 70,
                      viewHeaderStyle:   ViewHeaderStyle(
                        backgroundColor: AppColors.secondaryColor,
                          dayTextStyle:   TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      )),
                      headerStyle: const CalendarHeaderStyle(
                         backgroundColor: Colors.transparent,
                          textStyle:  TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.darkColor, )),
                      showTodayButton: false,
                      showDatePickerButton: true,
                      showNavigationArrow: true,
                      view: CalendarView.month,
                      appointmentTimeTextFormat: 'HH:mm a',
                      appointmentTextStyle:const  TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                      dataSource: MeetingDataSource(
                          bookingCon.meetingList), // post events
                      monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode: _displayMode,
                        showAgenda: true,
                        monthCellStyle:const MonthCellStyle( textStyle: TextStyle(color: AppColors.secondaryColor, fontSize: 16, fontWeight: FontWeight.w600))
                      ),
                      selectionDecoration: BoxDecoration(
                          border: Border.all(color: AppColors.secondaryColor, width: 2)),
                      allowedViews: const [
                        CalendarView.day,
                        CalendarView.month,
                        CalendarView.timelineWeek,
                        CalendarView.week,
                        CalendarView.workWeek
                      ],
                      todayHighlightColor: AppColors.primaryColor,
                      todayTextStyle: const TextStyle(color: AppColors.backgroundColor,fontSize: 16, fontWeight: FontWeight.w600),
                      timeSlotViewSettings: const TimeSlotViewSettings(
                        timeTextStyle:TextStyle(color: AppColors.secondaryColor, fontSize: 14, fontWeight: FontWeight.w600),
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


  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      calendarController.selectedDate = viewChangedDetails.visibleDates[0];
    });
  }
}

