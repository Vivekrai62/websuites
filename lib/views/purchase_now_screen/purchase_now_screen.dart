import 'package:flutter/material.dart';

import '../../utils/appColors/app_colors.dart';

class PurchaseNowScreen extends StatefulWidget {
  const PurchaseNowScreen({super.key});

  @override
  State<PurchaseNowScreen> createState() => _PurchaseNowScreenState();
}

class _PurchaseNowScreenState extends State<PurchaseNowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.textField,
        title: const Text('Purchase Now'),
      ),
      body: Column(
        children: [
          Container(


          ),
        ],
      ),
    );

  }
}
