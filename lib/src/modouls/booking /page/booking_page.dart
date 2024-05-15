import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetroombooking/src/modouls/booking%20/controller/booking_contoller.dart';
import 'package:meetroombooking/src/modouls/booking%20/widget/custom_color.dart';
import '../../../../widgets/custom_text_form_filed.dart';

class BookingPage extends StatelessWidget {
  final String date;
  final String location;
  const BookingPage({super.key, required this.date, required this.location});

  @override
  Widget build(BuildContext context) {
    final bookingCon = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Make a Booking",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.amber,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date),
                        const Text('time'),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('30min'),
                        Row(
                          children: [
                            const Icon(Icons.business_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(location),
                          ],
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                const CustomTextFormFiled(
                  title: 'First Name',
                ),
                const CustomTextFormFiled(
                  title: 'Last Name',
                ),
                const CustomTextFormFiled(
                  title: 'Email',
                ),
                const CustomTextFormFiled(
                  title: 'Meeting Topic',
                ),
                const CustomTextFormFiled(
                  title: 'Phone Number',
                ),
                const CustomTextFormFiled(
                  title: 'Location',
                ),
                // Expanded(
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       CustomTextFormFiled(
                //         title: 'From',
                //         height: 50,
                //         width: MediaQuery.of(context).size.width * 0.45,
                //       ),
                //       CustomTextFormFiled(
                //         title: 'To',
                //         height: 50,
                //         width: MediaQuery.of(context).size.width * 0.45,
                //       ),
                //     ],
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Colors:"),
                    Row(
                      children: bookingCon.colors.asMap().entries.map((e) {
                        return GestureDetector(
                          onTap: () {
                            bookingCon.isSelected.value = e.key;
                            debugPrint('value colos: ${e.value}');
                          },
                          child: CustomColor(
                              isSelected: bookingCon.isSelected.value == e.key,
                              colors: e.value),
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
