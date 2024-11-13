import 'package:flutter/material.dart';

class SliderProvider with ChangeNotifier {
  final double min = 0;
  final double max = 35000;
  double _startVal = 0;
  double _endVal = 35000;

  final TextEditingController startController;
  final TextEditingController endController;

  SliderProvider()
      : startController = TextEditingController(text: "0"),
        endController = TextEditingController(text: "35000");

  double get startVal => _startVal;
  double get endVal => _endVal;

  void updateStartVal(double newVal) {
    _startVal = newVal.clamp(min, max);
    startController.text = _startVal.toInt().toString();
    notifyListeners();
  }

  void updateEndVal(double newVal) {
    _endVal = newVal.clamp(min, max);
    if (_endVal < _startVal) {
      return;
    }
    endController.text = _endVal.toInt().toString();
    notifyListeners();
  }

  void updateRange(RangeValues values) {
    _startVal = values.start.ceilToDouble();
    _endVal = values.end.ceilToDouble();
    startController.text = _startVal.toInt().toString();
    endController.text = _endVal.toInt().toString();
    notifyListeners();
  }
}
