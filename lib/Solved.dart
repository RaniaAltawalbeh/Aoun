import 'package:aoun1/EmergencyPage.dart';
import 'package:aoun1/ProcessingPage.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Drafts.dart';
import 'AreaReports.dart';

class Solved extends StatelessWidget {
  const Solved({super.key});

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF2269D4);

    //  FILTER SOLVED REPORTS ONLY BASED ON THE STATUS
    final solvedReports =
    reports.where((r) => r["status"] == "solved").toList();

    return Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            "assets/images/logo.png",
            width: 103,
          ),
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProcessingPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: activeColor,
                        side: BorderSide(color: activeColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6), )
                    ),
                    child:  Text(
                      "تحت المعالجة",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 8),

                  // ACTIVE
                  ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activeColor,
                      foregroundColor: Colors.white,
                      side: BorderSide(color: activeColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child:  Text(
                      "تم حلها",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 8),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>  Drafts()),
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
                    child: Text(
                      "المسودات",
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 8),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Areareports()),
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
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],


              ),
            ),

            const SizedBox(height: 20),


            Row(
              children: [

                SizedBox(
                  width: 90,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE6EEFF),
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

                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        labelText: "ابحث عن بلاغ",
                        labelStyle:  TextStyle(
                          color: Color(0xFF1A4498),
                          fontSize: 15,
                        ),
                        suffixIcon: const Icon(
                          Icons.search_sharp,
                          color: Color(0xFF1A4498),
                        ),
                        contentPadding:  EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:  BorderSide(
                            color: Color(0xFF1A4498),
                          ),
                        ),
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

            SizedBox(height: 50),

            /* -------- REPORT LIST -------- */
            Expanded(
              child: ListView.builder(
                itemCount: solvedReports.length,
                itemBuilder: (context, index) {
                  final report = solvedReports[index];

                  return SizedBox(
                    height: 181,
                    child: Container(
                      margin:  EdgeInsets.all(12),
                      padding:  EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:  Color(0xFF103F9B),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              report["image"],
                              width: 109,
                              height: 145,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Text(
                                  report["description"],
                                  textAlign: TextAlign.right,
                                  style:  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                SizedBox(height: 45),
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
                  );
                },
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
