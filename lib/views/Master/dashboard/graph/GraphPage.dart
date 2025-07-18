import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/createnewleadscreen2/CreateNewLeadScreen2.dart';

class ImprovedWidget extends StatefulWidget {
  const ImprovedWidget({super.key});

  @override
  State<ImprovedWidget> createState() => _ImprovedWidgetState();
}

class _ImprovedWidgetState extends State<ImprovedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CreateNewLeadScreenCard2(
            containerHeight: 10,
            containerPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            textFieldPadding: EdgeInsets.symmetric(vertical: 0),
            hintText: 'ok',
          ),
        ],
      ),
    );
  }
}
