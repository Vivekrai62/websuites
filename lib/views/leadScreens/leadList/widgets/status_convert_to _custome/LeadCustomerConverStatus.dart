import 'package:flutter/material.dart';
import 'package:websuites/utils/appColors/app_colors.dart';

class LeadStatusStepper extends StatelessWidget {
  final List<_StepData> steps = [
    _StepData("New", Colors.deepPurpleAccent),
    _StepData("In Progress", Colors.green),
    _StepData("Converted", Colors.grey[350]!),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(steps.length, (index) {
        final isLast = index == steps.length - 0;
        return CustomPaint(
          painter: ArrowPainter(
            color: steps[index].color,
            isLast: isLast,
          ),
          child: Flexible(
            child: Container(
              width: 110, // Fixed width for all containers
              padding: EdgeInsets.symmetric(vertical: 7),
              alignment: Alignment.center, // Center the text
              child: Text(
                steps[index].label,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _StepData {
  final String label;
  final Color color;

  _StepData(this.label, this.color);
}

class ArrowPainter extends CustomPainter {
  final Color color;
  final bool isLast;

  ArrowPainter({required this.color, required this.isLast});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - (isLast ? 0 : 10), 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - (isLast ? 0 : 10), size.height);
    path.lineTo(0, size.height);
    path.lineTo(10, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isLast != isLast;
  }
}