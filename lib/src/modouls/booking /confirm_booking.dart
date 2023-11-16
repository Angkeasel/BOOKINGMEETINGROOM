import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meetroombooking/src/modouls/home/home_controller.dart';
import 'package:meetroombooking/widgets/custom_buttons.dart';
import 'package:meetroombooking/widgets/custom_text_form_filed.dart';

import '../../../widgets/custom_lable_edit.dart';

class ConfirmBookingScreen extends StatefulWidget {
  final String? time;
  final String? date;
  final int? amountTime;
  const ConfirmBookingScreen(
      {super.key, this.time, this.amountTime, this.date});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final homeCon = Get.put(HomeController());
  int testing = 1;
  @override
  void initState() {
    debugPrint('=========> 123 ${widget.time} && ${widget.amountTime}');

    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Booking"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(left: 15, right: 10, bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomLableEdit(
                          lable: 'Friday, November 17th,2023',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.grey.shade600),
                          onPressed: () {
                            debugPrint('=========> edit day');
                          },
                        ),
                        Text(
                          '${widget.time}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 15, bottom: 5, right: 10, top: 3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropdownButton(
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
                              homeCon.dropdownvalueIndex.value = items.key;
                              //=====>> testing
                              testing = homeCon.updateAddTime(
                                  homeCon.dropdownvalueIndex.value);
                              debugPrint(
                                  '========> return value of AddIndex $testing');
                            },
                            value: items.value,
                            child: Text(items.value),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            homeCon.dropdownvalue.value = newValue!;
                          });
                          debugPrint('========>${homeCon.dropdownvalue.value}');
                        },
                      ),
                      // CustomLableEdit(
                      //   icon: Icons.timer_sharp,
                      //   lable: '2 hours',
                      //   onPressed: () {
                      //     debugPrint('=========> edit time');
                      //   },
                      // ),
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
                CustomTextFormFiled(
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
                CustomButtons(
                  title: 'Confirm Booking',
                  onTap: () {
                    final isValidated = _formKey.currentState?.validate();
                    if (isValidated != null && isValidated == true) {}
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
