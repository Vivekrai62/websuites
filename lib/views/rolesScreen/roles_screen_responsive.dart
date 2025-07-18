import 'package:flutter/material.dart';
import 'package:websuites/utils/responsive/responsive_layout.dart';

import '../../utils/appColors/app_colors.dart';

class RolesScreenResponsive extends StatefulWidget {
  const RolesScreenResponsive({super.key});

  @override
  State<RolesScreenResponsive> createState() => _RolesScreenResponsiveState();
}

class _RolesScreenResponsiveState extends State<RolesScreenResponsive> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      scaffoldKey: scaffoldKey,
      body: const Scaffold(),
      drawer: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: AllColors.mediumPurple,
      // mobileBody: RolesScreen(),
      // tabBody: RolesScreenTab(),
    );
  }
}
