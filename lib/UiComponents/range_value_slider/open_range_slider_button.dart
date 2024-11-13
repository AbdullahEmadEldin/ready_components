import 'package:flutter/material.dart';

import 'range_value_slider_dialog.dart';

class PriceFilterButton extends StatelessWidget {
  const PriceFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          showDialog(
              context: context, builder: (context) => const SliderDialog());
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.pinkAccent)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_money_outlined, color: Colors.pinkAccent),
              Text(
                'Price',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.pinkAccent),
              ),
              Icon(Icons.arrow_drop_down_rounded, color: Colors.pinkAccent),
            ],
          ),
        ),
      ),
    );
  }
}
