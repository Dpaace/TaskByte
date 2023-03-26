import 'package:flutter/material.dart';

class TestDashBoard extends StatefulWidget {
  const TestDashBoard({super.key});

  @override
  State<TestDashBoard> createState() => _TestDashBoardState();
}

class _TestDashBoardState extends State<TestDashBoard> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Test Screen"),
    );
  }
}
