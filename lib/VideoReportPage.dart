import 'package:flutter/material.dart';
import 'HomePage.dart';

class VideoReportPage extends StatefulWidget {
  const VideoReportPage({super.key});

  @override
  State<VideoReportPage> createState() => _VideoReportPageState();
}

class _VideoReportPageState extends State<VideoReportPage> {
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
