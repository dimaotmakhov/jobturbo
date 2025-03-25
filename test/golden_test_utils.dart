import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

const String fontFamilyWithFallbacks = 'NotoSansCJK';

Widget getDecoratedScreen(Widget image, Device device, Widget text) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      width: device.size.width,
      height: device.size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade300,
            Colors.purple.shade100,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            // Top text with multiple font styles and decorations
            text,
            const SizedBox(height: 5),
            // iPhone screen frame
            Container(
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0), width: 10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: image,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
