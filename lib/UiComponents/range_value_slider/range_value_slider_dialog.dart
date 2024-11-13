import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'slider_provider.dart';

class SliderDialog extends StatelessWidget {
  const SliderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => SliderProvider(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price per day',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                _valuesRow(context),
                _slider(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _slider(BuildContext context) {
    return Consumer<SliderProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.pinkAccent.withOpacity(0.2),
          ),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              rangeThumbShape: const RoundRangeSliderThumbShape(
                disabledThumbRadius: 7,
                enabledThumbRadius: 7,
              ),
              trackHeight: 3,
              thumbColor: Colors.pink,
            ),
            child: RangeSlider(
              min: provider.min,
              max: provider.max,
              values: RangeValues(provider.startVal, provider.endVal),
              onChanged: (values) {
                provider.updateRange(values);
              },
              onChangeEnd: (value) {
                log('Filtering by ${provider.startVal} to ${provider.endVal}');
              },
              activeColor: Colors.pinkAccent,
            ),
          ),
        );
      },
    );
  }

  Widget _valuesRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        children: [
          const Text(
            'Min ',
            style: TextStyle(fontSize: 16),
          ),
          _value(
            context,
            getController: (provider) => provider.startController,
            onChanged: (provider, newVal) {
              final val = double.parse(newVal);
              provider.updateStartVal(val);
            },
          ),
          Container(
            margin: const EdgeInsets.all(4),
            width: 16,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const Text(
            'Max ',
            style: TextStyle(fontSize: 16),
          ),
          _value(
            context,
            getController: (provider) => provider.endController,
            onChanged: (provider, newVal) {
              final val = double.parse(newVal);
              provider.updateEndVal(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _value(
    BuildContext context, {
    required TextEditingController Function(SliderProvider) getController,
    required void Function(
      SliderProvider,
      String,
    ) onChanged,
  }) {
    return Flexible(
      child: IntrinsicWidth(
        child: Consumer<SliderProvider>(
          builder: (context, provider, child) {
            return TextField(
              controller: getController(provider),
              onChanged: (newVal) {
                if (newVal.isEmpty) return;
                onChanged(provider, newVal);
              },
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
