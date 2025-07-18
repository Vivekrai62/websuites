import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static snackbarFailed(String message) {
    // Ensure GetX is still active before showing snackbar
    if (Get.isSnackbarOpen == false && Get.context != null) {
      Get.snackbar(
        'Failed',
        message,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
        borderRadius: 8.0,
      );
    }
  }

  static snackbarSuccess(String message) {
    // Ensure GetX is still active before showing snackbar
    if (Get.isSnackbarOpen == false && Get.context != null) {
      Get.snackbar(
        'Success',
        message,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
        borderRadius: 8.0,
      );
    }
  }

  static snackbarEmailMessage(String message) {
    // Ensure GetX is still active before showing snackbar
    if (Get.isSnackbarOpen == false && Get.context != null) {
      Get.snackbar(
        'Success',
        message,
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(12),
        borderRadius: 8.0,
      );
    }
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
    // Check if the context/widget is still active
    if (!context.mounted) return;

    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.green,
        title: 'Success',
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.BOTTOM,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.check_circle,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    // Check if the context/widget is still active
    if (!context.mounted) return;

    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.all(20),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: const Color(0xFFFA2521),
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        icon: const Icon(Icons.error, size: 28, color: Colors.white),
      )..show(context),
    );
  }

  static void errorAlertDialogue(String? message, BuildContext context) {
    // Check if the context/widget is still active
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Padding(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.error_outline,
              textDirection: TextDirection.ltr,
              color: Colors.red,
              size: 50,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(
              message ?? 'An error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  static void successDialogue(String? message, BuildContext context) {
    // Check if the context/widget is still active
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Padding(
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.check_circle_outlined,
              textDirection: TextDirection.ltr,
              color: Colors.green,
              size: 50,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(
              message ?? 'Success',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  static void confirmationDialogue(
      String? message, String? title, VoidCallback? onPress, BuildContext context) {
    // Check if the context/widget is still active
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title ?? "Confirmation"),
          content: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(
              message ?? 'Are you sure?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
                onPress?.call();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}