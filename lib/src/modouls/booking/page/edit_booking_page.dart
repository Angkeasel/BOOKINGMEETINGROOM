import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/config/router/router.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import '../controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/booking/models/meeting/meeting_model.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import '../../../../widgets/custom_buttons.dart';
import '../../../../widgets/custom_lable_edit.dart';
import '../../../../widgets/custom_text_form_filed.dart';
import '../../../config/font/font_controller.dart';
import '../../../constant/app_color.dart';
import '../../listing/controller/room_controller.dart';
import '../widget/custom_color.dart';

class EditBookingPage extends StatefulWidget {
  final int? millisecondsSinceEpoch;
  final String bookId;
  const EditBookingPage(
      {super.key, this.millisecondsSinceEpoch, required this.bookId});

  @override
  State<EditBookingPage> createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  //===========================================================>
  final _formKey = GlobalKey<FormState>();
  late DateTime? startDate = widget.millisecondsSinceEpoch != null
      ? DateTime.fromMillisecondsSinceEpoch(widget.millisecondsSinceEpoch ?? 0)
      : null;
  final DateFormat dateFormat = DateFormat('HH:mm aa', 'km');
  final languageController = Get.find<LanguageController>();
  String timeshiftFormatter(String datetime) => languageController.isKhmer
      ? datetime.replaceAll('AM', 'ព្រឹក').replaceAll('PM', 'ល្ងាច')
      : datetime;
  final homeCon = Get.put(HomeController());
  final bookingCon = Get.put(BookingController());
  final roomCon = Get.put(RoomController());

  //===========================================================>
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

  //============================> textField <===========================
  final TextEditingController fNameControler = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController meetTopicController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  Meeting bookingModel = Meeting();
  Future<void> fetch() async {
    try {
      await bookingCon.fetchBookingById(widget.bookId).then((value) {
        debugPrint('value=====>$value');
        setState(() {
          bookingModel = value;
          homeCon.dropdownvalue.value = bookingModel.duration!;
          bookingCon.isSelectedEdit.value = bookingModel.backgroundColor!;
        });
        debugPrint('bookingModel=====>${bookingModel.backgroundColor}');
      });
    } catch (e) {
      debugPrint('heeeeeh=====>$e');
    }
  }

  @override
  void initState() {
    fetch();
    debugPrint('=======> booking id: ${widget.bookId}');
    debugPrint('====> colors value : ${bookingModel.backgroundColor}');

    //bookingCon.editColorString.value = '';
    //bookingCon.isSelectedEdit.value = '';
    // debugPrint('========> test millisecondsSinceEpoch : $startDate');
    //===========================================================>
    //fNameControler.text = bookingModel.firstName ?? '';
    // lNameController.text = bookingCon.bookingModels.value.lastName ?? '';
    // meetTopicController.text =
    //     bookingCon.bookingModels.value.meetingTopic ?? '';
    // phoneController.text = bookingCon.bookingModels.value.phoneNumber ?? '';
    // emailController.text = bookingCon.bookingModels.value.email ?? '';
    // debugPrint(' time : ${homeCon.dropdownvalue.value}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //===========================================================>
    final dateStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 18,
      color: AppColors.secondaryColor,
      fontVariations: [FontWeight.w500.getVariant],
    );
    //============================================================>
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Booking Page",
          style: TextStyle(
              fontSize: 22,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              context.go('/booking-room/${bookingModel.byRoom}');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Obx(
        () => Center(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: FocusScope(
                      child: Column(
                        children: [
                          ///Date time Box
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: context.width > 500
                                    ? context.width * 0.4
                                    : context.width),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(padding),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomLableEdit(
                                    lable: DateFormat.yMMMMEEEEd()
                                        .format(startDate!),
                                    style: context.bodyMedium.copyWith(
                                      fontSize: 18,
                                      fontVariations: [
                                        FontWeight.w600.getVariant,
                                      ],
                                      color: Colors.grey.shade600,
                                    ),
                                    onPressed: () {
                                      debugPrint('=========> edit day');
                                      context.go(
                                        '/booking-room/${bookingModel.byRoom}/edit-event-date/${widget.bookId}',
                                      );
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          timeshiftFormatter(
                                              dateFormat.format(startDate!)),
                                          style: dateStyle),
                                      const Text(' - '),
                                      Text(
                                        timeshiftFormatter(
                                          dateFormat.format(
                                            startDate!.add(
                                              Duration(
                                                  minutes: homeCon
                                                      .dropdownvalue.value),
                                            ),
                                          ),
                                        ),
                                        style: dateStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: textFieldBottomSpacing),

                          ///Room Box
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: context.width > 500
                                    ? context.width * 0.4
                                    : context.width),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(padding)
                                  .copyWith(top: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DropdownButton<int>(
                                    // Initial Value
                                    //value: widget.meetModel!.duration,
                                    value: homeCon.dropdownvalue.value,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    // Array list of items
                                    items: homeCon.dropdownAddTimeList
                                        .asMap()
                                        .entries
                                        .map((items) {
                                      return DropdownMenuItem(
                                        onTap: () {
                                          homeCon.dropdownvalueIndex.value =
                                              items.value;
                                        },
                                        value: items.value,
                                        child: Text(
                                          hourFormatFromMinutes(items.value),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        homeCon.dropdownvalue.value = newValue!;
                                      });
                                      debugPrint(
                                          '========>${homeCon.dropdownvalue.value}');
                                    },
                                  ),
                                  TextFormField(
                                    controller: TextEditingController()
                                      ..text = bookingCon
                                              .bookingModels.value.location ??
                                          '',
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        CupertinoIcons.building_2_fill,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  CustomLableEdit(
                                    icon: Icons.person,
                                    lable:
                                        "${bookingModel.firstName} ${bookingModel.lastName}",
                                    onPressed: () {
                                      debugPrint('=========> edit place');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: textFieldBottomSpacing),
                          CustomTextFormFiled(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: fNameControler
                              ..text = bookingModel.firstName ?? '',
                            title: 'First Name',
                            lable: '',
                            hintText: 'Enter Your First Name',
                            validator: (v) => v == ''
                                ? Intl.message(
                                    'Please Enter Your First Name.',
                                    name: 'FirstNameValidateMessage',
                                    desc: '',
                                    args: [],
                                  )
                                : null,
                          ),
                          CustomTextFormFiled(
                            controller: lNameController
                              ..text = bookingModel.lastName ?? '',
                            title: 'Last Name',
                            lable: '',
                            hintText: 'Enter Your Last Name',
                            validator: (v) => v == ''
                                ? Intl.message(
                                    'Please Enter Your Last Name.',
                                    name: 'LastNameValidateMessage',
                                    desc: '',
                                    args: [],
                                  )
                                : null,
                          ),
                          CustomTextFormFiled(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: meetTopicController
                              ..text = bookingModel.meetingTopic ?? '',
                            title: 'Meeting Topic',
                            lable: '',
                            hintText: 'Enter Your Meeting Topic',
                            onChanged: (v) {
                              meetTopicController.text = v;
                            },
                            validator: (v) => v == ''
                                ? Intl.message("Invalid Meeting Topic")
                                : null,
                          ),
                          CustomTextFormFiled(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: phoneController
                              ..text = bookingModel.phoneNumber ?? '',
                            keyboardType: TextInputType.phone,
                            title: 'Phone Number',
                            //lable: '',
                            hintText: 'Enter Your Phone Number',
                            validator: (v) => v == ''
                                ? Intl.message("Invalid Phone Number")
                                : null,
                          ),
                          CustomTextFormFiled(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailController
                              ..text = bookingModel.email ?? '',
                            keyboardType: TextInputType.emailAddress,
                            title: 'Email',
                            lable: '',
                            hintText: 'Enter Your Email',
                            // validator: (v) => v?.isEmail == false
                            //     ? Intl.message("Invalid Email Address")
                            //     : null,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CustomLableEdit(
                              //   //icon: Icons.person,
                              //   lable: 'Colors:',
                              //   onPressed: () {
                              //     debugPrint('show bottomsheet');
                              //     onShowBottomSheet(
                              //       isDimissible: true,
                              //       enableDrag: false,
                              //       context: context,
                              //       height: context.height * 1 / 3,
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             const Text(' Select Colors: '),
                              //             const SizedBox(
                              //               height: 10,
                              //             ),
                              //             Row(
                              //               children: bookingCon.colors
                              //                   .asMap()
                              //                   .entries
                              //                   .map((e) {
                              //                 return GestureDetector(
                              //                   onTap: () {
                              //                     bookingCon
                              //                             .isSelectedEdit.value =
                              //                         widget.meetModel!
                              //                             .backgroundColor!;
                              //                     debugPrint(
                              //                         '=========> ${bookingCon.isSelectedEdit.value}');
                              //                     // bookingCon.isSelectedEdit
                              //                     //     .value = e.value;
                              //                     // debugPrint(
                              //                     //     'value colos: ${e.value}');
                              //                     setState(() {
                              //                       bookingCon.isSelectedEdit
                              //                           .value = e.value;
                              //                     });
                              //                   },
                              //                   child: CustomColor(
                              //                       isSelected: bookingCon
                              //                               .isSelectedEdit
                              //                               .value ==
                              //                           e.value,
                              //                       colors: e.value),
                              //                 );
                              //               }).toList(),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: context.width > 500
                                        ? context.width * 0.4
                                        : context.width),
                                child: Row(
                                  children: bookingCon.colors
                                      .asMap()
                                      .entries
                                      .map((e) {
                                    return GestureDetector(
                                      onTap: () {
                                        bookingCon.isSelectedEdit.value =
                                            bookingCon.bookingModels.value
                                                .backgroundColor!;
                                        debugPrint(
                                            '=========> ${bookingCon.isSelectedEdit.value}');
                                        setState(() {
                                          bookingCon.isSelectedEdit.value =
                                              e.value;
                                        });
                                      },
                                      child: CustomColor(
                                          isSelected:
                                              bookingCon.isSelectedEdit.value ==
                                                  e.value,
                                          colors: e.value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                minimum: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: CustomButtons(
                  isDisabled:
                      bookingCon.bookingModels.value.backgroundColor == ''
                          ? true
                          : false,
                  title: 'Update',
                  onTap: () async {
                    await bookingCon.updateMeeting(
                        id: widget.bookId,
                        meetingTopic: meetTopicController.text,
                        email: emailController.text,
                        phoneNumber: phoneController.text,
                        firstName: fNameControler.text,
                        lastName: lNameController.text,
                        date: DateFormat('yyyy-MM-dd')
                            .format(startDate!)
                            .toString(),
                        startTime: startDate!.toString(),
                        endTime: startDate!
                            .add(Duration(minutes: homeCon.dropdownvalue.value))
                            .toString(),
                        duration: homeCon.dropdownvalue.value,
                        color: bookingCon.isSelectedEdit.value);
                    router.pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
