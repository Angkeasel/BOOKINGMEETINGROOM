import 'package:flutter/material.dart';

class CustomRowDetails extends StatelessWidget {
  final String? title;
  final String? value;
  const CustomRowDetails({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title :',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            ' $value',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
