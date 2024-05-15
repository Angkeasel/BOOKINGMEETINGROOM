import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/config/font/font_controller.dart';
import 'package:meetroombooking/src/constant/app_color.dart';
import 'package:meetroombooking/src/constant/app_size.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../../../widgets/custom_lable_edit.dart';

class ConfirmBookingScreen extends StatefulWidget {
  final int? millisecondsSinceEpoch;

  const ConfirmBookingScreen({
    super.key,
    this.millisecondsSinceEpoch,
  });

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final homeCon = Get.put(HomeController());
  int testing = 1;

  late DateTime? startDate = widget.millisecondsSinceEpoch != null
      ? DateTime.fromMillisecondsSinceEpoch(widget.millisecondsSinceEpoch!)
      : null;

  final DateFormat _dateFormat = DateFormat('HH:mm aa', 'km');

  @override
  void initState() {
    homeCon.setDefaultDropdown();
    super.initState();
  }

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

  final languageController = Get.find<LanguageController>();

  String timeshiftFormatter(String datetime) => languageController.isKhmer
      ? datetime.replaceAll('AM', 'ព្រឹក').replaceAll('PM', 'ល្ងាច')
      : datetime;

  final _formKey = GlobalKey<FormState>();

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
          "Confirm Booking",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: SafeArea(
        minimum: defaultMinSafeArea.copyWith(left: padding, right: padding),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: textFieldBottomSpacing),
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
                                                minutes: homeCon
                                                    .dropdownvalue.value),
                                          ),
                                        ),
                                      ),
                                      style: dateStyle),
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
                                  ..text = 'Training room head office',
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    CupertinoIcons.building_2_fill,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              // CustomLableEdit(
                              //   icon: Icons.person,
                              //   lable: 'Training room head office',
                              //   onPressed: () {
                              //     debugPrint('=========> edit place');
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(height: textFieldBottomSpacing),
                        CustomTextFormFiled(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        const CustomTextFormFiled(
                          title: 'Metting Topic',
                          lable: '',
                          hintText: 'Enter Your Metting Topic',
                        ),
                        const CustomTextFormFiled(
                          title: 'Phone Number',
                          lable: '',
                          hintText: 'Enter Your Phone Number',
                        ),
                        const CustomTextFormFiled(
                          title: 'Email',
                          lable: '',
                          hintText: 'Enter Your Email',
                        ),
                        const CustomTextFormFiled(
                          title: 'Location',
                          lable: '',
                          hintText: 'Enter Your Location',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomButtons(
              title: 'Confirm Booking',
              onTap: () {
                final isValidated = _formKey.currentState?.validate();
                if (isValidated != null && isValidated == true) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
