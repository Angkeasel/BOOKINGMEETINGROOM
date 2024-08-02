import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/booking%20/models/meeting/meeting_model.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';

import '../../../../widgets/custom_buttons.dart';
import '../../../../widgets/custom_lable_edit.dart';
import '../../../../widgets/custom_text_form_filed.dart';
import '../../../config/font/font_controller.dart';
import '../../../constant/app_color.dart';

import '../widget/custom_color.dart';

class EditBookingPage extends StatefulWidget {
  final int? millisecondsSinceEpoch;
  //final String? title;
  final Meeting? meetModel;
  const EditBookingPage(
      {super.key, this.millisecondsSinceEpoch, this.meetModel});

  @override
  State<EditBookingPage> createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime? startDate = widget.millisecondsSinceEpoch != null
      ? DateTime.fromMillisecondsSinceEpoch(widget.millisecondsSinceEpoch!)
      : null;
  final DateFormat _dateFormat = DateFormat('HH:mm aa', 'km');
  final languageController = Get.find<LanguageController>();
  String timeshiftFormatter(String datetime) => languageController.isKhmer
      ? datetime.replaceAll('AM', 'ព្រឹក').replaceAll('PM', 'ល្ងាច')
      : datetime;
  final homeCon = Get.put(HomeController());
  final bookingCon = Get.put(BookingController());

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

  @override
  void initState() {
    bookingCon.editColorString.value = '';
    bookingCon.isSelectedEdit.value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dateStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 18,
      color: AppColors.secondaryColor,
      fontVariations: [FontWeight.w500.getVariant],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Booking Page",
          style: TextStyle(
              fontSize: 22,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                  key: _formKey,
                  child: FocusScope(
                    child: Column(
                      children: [
                        ///Date time Box
                        Container(
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
                                lable:
                                    DateFormat.yMMMMEEEEd().format(startDate!),
                                style: context.bodyMedium.copyWith(
                                  fontSize: 18,
                                  fontVariations: [
                                    FontWeight.w600.getVariant,
                                  ],
                                  color: Colors.grey.shade600,
                                ),
                                onPressed: () {
                                  debugPrint('=========> edit day');
                                },
                              ),
                              Row(
                                children: [
                                  Text(
                                      timeshiftFormatter(
                                          _dateFormat.format(startDate!)),
                                      style: dateStyle),
                                  const Text(' - '),
                                  Text(
                                    timeshiftFormatter(
                                      _dateFormat.format(
                                        startDate!.add(
                                          Duration(
                                              minutes:
                                                  homeCon.dropdownvalue.value),
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
                        const SizedBox(height: textFieldBottomSpacing),

                        ///Room Box
                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(padding).copyWith(top: 5),
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
                                          items.key;

                                      //=====>> testing
                                      // testing = homeCon.updateAddTime(
                                      //     homeCon.dropdownvalueIndex.value);
                                      // debugPrint(
                                      //     '========> return value of AddIndex $testing');
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
                                  ..text = widget.meetModel!.meetingTopic ?? '',
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.building_2_fill,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              CustomLableEdit(
                                icon: Icons.person,
                                lable: 'Training room head office',
                                onPressed: () {
                                  debugPrint('=========> edit place');
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: textFieldBottomSpacing),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: bookingCon.firstNameController,
                          title: 'First Name',
                          lable: '',
                          hintText: 'Enter Your First Name',
                          onChanged: (value) {
                            bookingCon.firstNameController.text =
                                widget.meetModel!.firstName!;
                          },
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
                          controller: bookingCon.lastNameController,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: bookingCon.topicController,
                          title: 'Meeting Topic',
                          lable: '',
                          hintText: 'Enter Your Meeting Topic',
                          validator: (v) => v == ''
                              ? Intl.message("Invalid Meeting Topic")
                              : null,
                        ),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: bookingCon.phoneNumberController,
                          keyboardType: TextInputType.phone,
                          title: 'Phone Number',
                          lable: '',
                          hintText: 'Enter Your Phone Number',
                          validator: (v) => v == ''
                              ? Intl.message("Invalid Phone Number")
                              : null,
                        ),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: bookingCon.emailController,
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
                            const Text("Colors:"),
                            Row(
                              children:
                                  bookingCon.colors.asMap().entries.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    bookingCon.isSelectedEdit.value = e.value;
                                    debugPrint('value colos: ${e.value}');
                                    setState(() {
                                      bookingCon.editColorString.value =
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomButtons(
              title: 'Update',
              onTap: () async {
                await bookingCon.updateMeeting(
                    id: widget.meetModel!.id,
                    meetingTopic: widget.meetModel!.meetingTopic,
                    email: bookingCon.emailController.text,
                    phoneNumber: bookingCon.phoneNumberController.text,
                    firstName: bookingCon.firstNameController.text,
                    lastName: bookingCon.lastNameController.text,
                    date:
                        DateFormat('yyyy-MM-dd').format(startDate!).toString(),
                    startTime: startDate!.toString(),
                    endTime: startDate!
                        .add(Duration(minutes: homeCon.dropdownvalue.value))
                        .toString(),
                    duration: homeCon.dropdownvalue.value,
                    color: bookingCon.colorString.value);
              },
            )
          ],
        ),
      ),
    );
  }
}
