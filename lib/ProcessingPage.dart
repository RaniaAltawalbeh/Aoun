import 'package:aoun1/EmergencyPage.dart';
import 'package:flutter/material.dart';
import 'Solved.dart';
import 'Drafts.dart';
import 'AreaReports.dart';

// list of type map to store the complaints image and description and status to take us to the page required

final List<Map<String, dynamic>> reports = [
  {
    "description":
    "قطعت الكهرباء بسبب سقوط شجرة وتداخلها مع الشبكة الكهربائية",
    "image": "assets/images/electric.png",
    "status": "solved",
  },
  {
    "description": "حادث سير يتسبب بأزمة مرورية في شارع الأردن بعمان.",
    "image": "assets/images/traffic.png",
    "status": "processing",
  },

  {
    "description": "تم رصد اعتداء بيئي في عجلون حيث تم استخدام مناشير آلية لقطع الأشجار المعمرة. تم تقدير الضرر الأولي...",
    "image": "assets/images/tree.png",
    "status": "draft",
  },

];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProcessingPage(),
    );
  }
}


//processing page
/* ---------------- PAGE 1 ---------------- */
class ProcessingPage extends StatelessWidget {
  const ProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    //constant used all over
    const activeColor = Color(0xFF2269D4);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        //to remove the arrow that is automatically there
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        //align the logo pic to the right
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            "assets/images/logo.png",
            width: 103.1,
            height: 90,
            //make it fit into the box and not out of it
            fit: BoxFit.contain,
          ),
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.all(12),
        child: Column(
          // position
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /* -------- CATEGORY BUTTONS -------- */
            //top buttons scroll view for the buttons like a list
            SizedBox(
              height: 40, // important for horizontal ListView
              child: ListView(
                //instead of vertically horizontal
                scrollDirection: Axis.horizontal,
                children: [

                  // ACTIVE BUTTON – تحت المعالجة
                  ElevatedButton(
                    onPressed: () {},
                    //to desgin the shape of the button
                    style: ElevatedButton.styleFrom(
                      //color for the back of the button
                      backgroundColor: activeColor,
                      //color of the text on the button
                      foregroundColor: Colors.white,
                      side: BorderSide(color: activeColor),
                      //border color and shape
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:  Text(
                      "تحت المعالجة",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 8),

                  // SOLVED
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Solved()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: activeColor,
                      side: BorderSide(color: activeColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:  Text(
                      "تم حلها",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 8),

                  // DRAFTS
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Drafts()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: activeColor,
                      side: BorderSide(color: activeColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:  Text(
                      "المسودات",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 8),

                  // AREA REPORTS
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Areareports()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: activeColor,
                      side: BorderSide(color: activeColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:  Text(
                      "بلاغات المنطقة",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20),
            Row(
              children: [

                // FILTER BUTTON
                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFFE6EEFF),
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(
                          "تصفية",
                          style: TextStyle(
                            color: Color(0xFF1A4498),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.filter_list,
                          size: 15,
                          color: Color(0xFF1A4498),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10),

                // SEARCH FIELD
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      // the side of the text to the right
                      textAlign: TextAlign.right,
                      //make the text to the left
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        labelText: "ابحث عن بلاغ",
                        labelStyle:  TextStyle(
                          color: Color(0xFF1A4498),
                          fontSize: 15,
                        ),
                        suffixIcon:  Icon(
                          Icons.search_sharp,
                          color: Color(0xFF1A4498),
                        ),
                        //inner spacing between the text and the border
                        contentPadding:  EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        //the border of the text field when we didnt type in it yet
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:  BorderSide(
                            color: Color(0xFF1A4498),
                            width: 1.2,
                          ),
                        ),
                        //when we type in the text field  the box stays the stays the same
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:  BorderSide(
                            color: Color(0xFF1A4498),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),




            // processing page container using list view builder
            SizedBox(height: 50),
            SizedBox(
              height: 181,
              width: 550,

              child: Container(

                margin:  EdgeInsets.all(12),
                padding:  EdgeInsets.all(12),
                decoration: BoxDecoration(
                  //border of the container decoration
                  border: Border.all(
                    color: Color(0xFF103F9B),
                    width: 1.5,

                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    //clip for the edges of the image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/traffic.png",
                        width: 109,
                        height: 145,
                        // so that it takes the shape of it and crop the edges
                        fit: BoxFit.cover,
                      ),
                    ),




                    // description of the complaint
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          // TEXT
                          Text(
                            "حادث سير يتسبب بأزمة مرورية في شارع الأردن بعمان.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),

                          SizedBox(
                            height: 45,
                          ),



                          // BUTTON to show the details
                          SizedBox(
                            width: 122,
                            height: 30.62,
                            child: ElevatedButton(
                              onPressed: (){

                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFF5D8FD4),
                                elevation: 0,
                                side: BorderSide(
                                  color: Color(0xFF5D8FD4),
                                  width: 1,
                                ),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child:  Text(
                                "عرض التفاصيل",
                                style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomBottomNavBar(),
      ),
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
