import 'package:flutter/material.dart';
import 'HomePage.dart';

class ImageReportPage extends StatefulWidget {
  const ImageReportPage({super.key});

  @override
  State<ImageReportPage> createState() => _ImageReportPageState();
}

class _ImageReportPageState extends State<ImageReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 300),
            Image.asset(
              "assets/images/logowithouttext.png",
              width: 103.1,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      body: Container(), // فاضي
    );
  }
}
