import 'package:flutter/material.dart';
import 'package:meetroombooking/src/constant/app_textstyle.dart';

import '../../../constant/app_color.dart';

class BookingRoomDetailsPage extends StatelessWidget {
  const BookingRoomDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Room Details Page"),
        titleTextStyle: context.appBarTextStyle.copyWith(
          color: AppColors.textLightColor,
        ),
      ),
    );
  }
}
