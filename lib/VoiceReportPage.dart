import 'package:aoun1/EmergencyPage.dart';
import 'package:aoun1/ProcessingPage.dart';
//gives us timer
import 'dart:async';

import 'package:flutter/material.dart';

class VoiceReportPage extends StatefulWidget {
  const VoiceReportPage({super.key});

  @override
  State<VoiceReportPage> createState() => _VoiceReportPageState();
}

// this class holds all logic, state, and UI for VoicePage
class _VoiceReportPageState extends State<VoiceReportPage>
//so the animation runs smoothly
    with SingleTickerProviderStateMixin {
  //control the state of the circles grow and shrink using late cause itll be initialized later
  late AnimationController controller;

  //from async a class  we create a timer and then ? so it can be null at the beggining zero
  Timer? timer;

  //for the mic and the animation is running (on)
  bool isRunning = false;
  int seconds = 0;


  //create three circles for the animation
  late Animation<double> circle2;
  late Animation<double> circle3;
  late Animation<double> circle4;

  @override
  //runs once when the page is created
  void initState() {
    super.initState();


    //create the controller for the shape of the circles
    controller = AnimationController(
      vsync: this,
      duration:  Duration(milliseconds: 900), //speed of the animation
    );

    circle2 = Tween<double>(begin: 0, end: 180).animate(
      CurvedAnimation(
        parent: controller,
        curve:  Interval(0.0, 0.45, curve: Curves.easeInOut),
      ),
    );

    circle3 = Tween<double>(begin: 0, end: 270).animate(
      CurvedAnimation(
        parent: controller,
        curve:  Interval(0.15, 0.6, curve: Curves.easeInOut),
      ),
    );

    circle4 = Tween<double>(begin: 0, end: 315).animate(
      CurvedAnimation(
        parent: controller,
        curve:  Interval(0.3, 0.75, curve: Curves.easeInOut),
      ),
    );

    //listen the state of the circle to expand and shrink over and over loop
    controller.addStatusListener((status) {
      if (!isRunning) return;

      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }



  // timer
  void startTimer() {
    seconds = 0; // reset only when starting so that the number stays at the bottom
    timer?.cancel();
    timer = Timer.periodic( Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }


  //when tapped a second time the animation stops
  void stopEverything() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
    controller.stop();
    controller.reset();
  }

  //the shape (format) of the timer
  String formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return "$min:$sec";
  }

  @override

  //to get rid of the things once the session is done so it doesnt get laggy
  void dispose() {
    controller.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              "assets/images/logo.png",
              width: 103,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
//text at the top
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "أهلاً بك\nكيف يمكننا مساعدتك اليوم؟",
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      fontSize: 24,
                      color: Color(0xFF1A4498),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

//all circles built

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isRunning = !isRunning;
                    });

                    if (isRunning) {
                      controller.forward();
                      startTimer();
                    } else {
                      stopEverything();
                    }
                  },
                  child: SizedBox(
                    width: 330,
                    height: 330,
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (_, __) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: circle4.value,
                              height: circle4.value,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFA1BEED),
                              ),
                            ),
                            Container(
                              width: circle3.value,
                              height: circle3.value,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF759BD8),
                              ),
                            ),
                            Container(
                              width: circle2.value,
                              height: circle2.value,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF2C56A9),
                              ),
                            ),
                            //the smallest circle with the mic in it
                            Container(
                              width: 100,
                              height: 100,
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1A4498),
                              ),
                              child:  Center(
                                child: Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),


            //time at the bottom
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10,),
              child: GestureDetector(
                onTap: stopEverything,
                child: Text(
                  formatTime(seconds),
                  style:  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A4498),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomBottomNavBar(),)
    );
  }
}




class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // الكبسات

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.home, color: Colors.grey[400]),
              ),
              Text('الرئيسية', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProcessingPage()),
                );
              },
              icon:Icon(Icons.shield, color: Colors.grey[400]),
            ),
              Text('بلاغاتي', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
            ],
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyPage()),
              );
            },
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[700],
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.6),
                    blurRadius: 18,
                    spreadRadius: 8, // الضو حولين الكبسة
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'طوارئ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {

                },
                icon:Icon(Icons.notifications, color: Colors.grey[400]),
              ),
              Text('التنبيهات', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {

                },
                icon:Icon(Icons.person, color: Colors.grey[400]),
              ),
              Text('الملف الشخصي', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
            ],
          ),
        ],
      ),
    );
  }
}
