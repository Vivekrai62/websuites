import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UniqueMeetingScreen extends StatelessWidget {
  const UniqueMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
            child: Image.network(
                'https://img.freepik.com/premium-vector/no-data-concept-illustration_86047-488.jpg?semt=ais_hybrid"')));
  }
}
