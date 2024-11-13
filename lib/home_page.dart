import 'package:flutter/material.dart';
import 'package:ready_components/UiComponents/range_value_slider/open_range_slider_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PriceFilterButton(),
      ),
    );
  }
}
