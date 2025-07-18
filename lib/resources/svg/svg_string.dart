import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath; // Path to the SVG asset
  final double? size; // Size of the icon (width and height)
  final Color? color; // Tint color for the SVG
  final BoxFit fit; // How the SVG should fit within its bounds

  const SvgIcon({
    Key? key,
    required this.assetPath,
    this.size = 24.0,
    this.color,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }
}

class Svg{

  static const String dashboard = 'assets/svg/dashboard.svg';
  static const String lead = 'assets/svg/lead.svg';
  static const String customers = 'assets/svg/customers.svg';
  static const String calender = 'assets/svg/calender.svg';
  static const String orders = 'assets/svg/orders.svg';
  static const String sale = 'assets/svg/sale.svg';
  static const String products = 'assets/svg/products.svg';
  static const String projects = 'assets/svg/projects.svg';
  static const String task = 'assets/svg/task.svg';
  static const String analytics = 'assets/svg/analytics.svg';
  static const String users = 'assets/svg/users.svg';

  static const String hrm = 'assets/svg/hrm.svg';
  static const String helpDesk = 'assets/svg/helpDesk.svg';
  static const String logs = 'assets/svg/logs.svg';
  static const String fileManager = 'assets/svg/fileManager.svg';
  static const String settings = 'assets/svg/settings.svg';
  static const String drawer = 'assets/svg/drawer.svg';
  static const String eye = 'assets/svg/eye.svg';



  static const String edit = 'assets/svg/edit.svg';
  static const String phone = 'assets/svg/phone.svg';
  static const String editOpp = 'assets/svg/editOpp.svg';
  static const String location = 'assets/svg/location.svg';
  static const String email = 'assets/svg/email.svg';
  static const String navDashboard = 'assets/svg/dashboardnav.svg';
  static const String navChat = 'assets/svg/NavChat.svg';
  static const String navNotification2 = 'assets/svg/NavNotification2.svg';
  static const String navAccount3 = 'assets/svg/NavAccount3.svg';
  static const String arrowCircle = 'assets/svg/arrow-circle.svg';
  static const String assigned = 'assets/svg/assigned.svg';
  static const String visit = 'assets/svg/visit.svg';
  static const String documents = 'assets/svg/documents.svg';
  static const String commentsEdit = 'assets/svg/proforma.svg';
  // static const String projection = 'assets/svg/projection.svg';
  static const String add = 'assets/svg/add.svg';
  static const String penEdit = 'assets/svg/penEdit.svg';
  static const String copy = 'assets/svg/copy.svg';
  static const String building = 'assets/svg/building.svg';
  static const String whatsApp = 'assets/svg/whatsapp.svg';
  static const String  leadCall = 'assets/svg/phone-call.svg';








}