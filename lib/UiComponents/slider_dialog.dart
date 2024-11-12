import 'dart:developer';

import 'package:flutter/material.dart';

class SliderDialog extends StatefulWidget {
  const SliderDialog({super.key});

  @override
  State<SliderDialog> createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  final double _min = 0, _max = 35000;
  double _startVal = 0, _endVal = 35000;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price per day',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              _valuesRow(),
              _slider(),
            ],
          ),
        ),
      ),
    );
  }

  Container _slider() {
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

          // ),
          thumbColor: Colors.pink,
        ),
        child: RangeSlider(
          min: _min,
          max: _max,
          values: RangeValues(_startVal, _endVal),
          onChanged: (values) {
            setState(() {
              _startVal = values.start.ceilToDouble();
              _endVal = values.end.ceilToDouble();
            });
          },
          onChangeEnd: (value) {
            log('Filtering by $_startVal to $_endVal');
          },
          activeColor: Colors.pinkAccent,
        ),
      ),
    );
  }

  Widget _valuesRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        children: [
          const Text(
            'Min ',
            style: TextStyle(fontSize: 16),
          ),
          _value(
            _startVal.toString(),
            (newVal) {
              final val = double.parse(newVal);
              // do the filter backend request then handle the value of UI
              if (val > _max) {
                setState(() {
                  _startVal = _max;
                });
              } else {
                setState(() {
                  log('start val changed to $newVal');
                  _startVal = val;
                });
              }
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
            _endVal.toString(),
            (newVal) {
              final val = double.parse(newVal);
              if (val > _max) {
                setState(() {
                  _endVal = _max;
                });
              } else if (_endVal < _startVal) {
                log('DONEEEEEEEEEEEEEEE');
                return;
              } else {
                setState(() {
                  _endVal = val;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _value(String value, Function(String)? onChanged) {
    return Flexible(
      child: IntrinsicWidth(
        child: TextField(
          controller: TextEditingController(text: value),
          onSubmitted: onChanged,
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
        ),
      ),
    );
  }
}
