//Old Code


// class ResponsiveScaffold extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   // final PreferredSizeWidget? appBar;
//   final Widget? drawer;
//   final Widget body;
//   final Widget? bottomNavigationBar;
//   final Widget? floatingActionButton;
//
//   const ResponsiveScaffold({
//     super.key,
//     required this.scaffoldKey,
//     // this.appBar,
//     this.drawer,
//     required this.body,
//     this.floatingActionButton,
//     this.bottomNavigationBar,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = ResponsiveUtils.isMobile(context);
//     final isTablet = ResponsiveUtils.isTablet(context);
//     return Scaffold(
//       key: scaffoldKey,
//       // appBar: appBar != null ? PreferredSize(
//       //   preferredSize: Size.fromHeight(isMobile ? 50 : (isTablet ? 70 : 80)),
//       //   child: appBar!,
//       // ) : null,
//       backgroundColor: Colors.white,
//       body:
//       LayoutBuilder(
//         builder: (context, constraints) {
//           return body;
//         },
//       ),
//
//       floatingActionButton: floatingActionButton,
//       bottomNavigationBar: bottomNavigationBar,
//     );
//   }
// }



//New code

import 'package:flutter/material.dart';
import 'package:websuites/utils/responsive/responsive_utils.dart';

import '../dark_mode/dark_mode.dart';
// Assuming you have a Responsive utility class defined elsewhere

class ResponsiveScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  const ResponsiveScaffold({
    super.key,
    required this.scaffoldKey,
    this.appBar,
    this.drawer,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar, required FloatingActionButtonLocation floatingActionButtonLocation, required Color backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtilsScreenSize.isMobile(context);
    final isTablet = ResponsiveUtilsScreenSize.isTablet(context);
    final isDesktop = ResponsiveUtilsScreenSize.isDesktop(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar != null
          ? PreferredSize(
        preferredSize: Size.fromHeight(
          isMobile ? 50 : (isTablet ? 70 : 80),
        ),
        child: appBar!,
      )
          : null,
      drawer: isMobile || isTablet ? drawer : null, // Drawer only for mobile/tablet
      backgroundColor: DarkMode.backgroundColor(context),
      body:
      LayoutBuilder(
        builder: (context, constraints) {
          if (isDesktop || isTablet) {
            // Desktop: include drawer permanently on the side
            return Row(
              children: [
                drawer??Container(), // Display drawer as a permanent side menu for desktop
                Expanded(child: body),
              ],
            );
          }
          return body; // For mobile/tablet, just return the body
        },
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: isMobile ? bottomNavigationBar:null,
    );
  }
}





class GridCountManeger {
  static int getItemCountPerRow(BuildContext context) {
    double minTileWidth = 400; //in your case
    double availableWidth = MediaQuery.of(context).size.width;

    int i = minTileWidth > availableWidth ? 1 : availableWidth ~/ minTileWidth;
    return i;
  }
}
