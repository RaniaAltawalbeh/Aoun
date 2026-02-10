import 'package:flutter/material.dart';
import 'HomePage.dart';

class VoiceReportPage extends StatefulWidget {
  const VoiceReportPage({super.key});

  @override
  State<VoiceReportPage> createState() => _VoiceReportPageState();
}

class _VoiceReportPageState extends State<VoiceReportPage> {
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
