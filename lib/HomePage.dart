import 'package:aoun1/AreaReports.dart';
import 'package:aoun1/ProcessingPage.dart';
import 'package:flutter/material.dart';
import 'EmergencyPage.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        body: Directionality(     //بتخلي الاشياء بالواجهة تبدا من اليمين لانه الصفحة عربية
          textDirection: TextDirection.rtl,
          child:Stack(
          children: [
            SingleChildScrollView(   //عشان تسوي Scroll
              child: Column(
                children: [
                  // Hero section
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/Hero.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  ///////////////////////////////////////////////////////////

                  Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('بلغ من خلال:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                        SizedBox(height: 16),

                        // كبسات الابلاغ
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildReportButton(Icons.mic, 'صوت'),
                            buildReportButton(Icons.videocam, 'فيديو'),
                            buildReportButton(Icons.camera_alt, 'صورة'),
                            buildReportButton(Icons.description, 'نموذج'),
                          ],
                        ),

                        SizedBox(height: 30),
                        ///////////////////////////////////////////////////////////

                        Text('بلاغاتك الأخيرة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                        SizedBox(height: 16),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,   //بتسوي scroll لليمين
                            reverse: true,    //عشان تقدر ترجع لليسار
                            child: Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                buildReportCard(   // بستدعي function و ببعتله الصورة و الكلام عشان يسوي البطاقة
                                  Image.asset(
                                    'assets/images/light.png', fit: BoxFit.cover,),
                                  'قطعت الكهرباء بسبب سقوط شجرة و تداخلها مع الشبكة الكهربائية',
                                ),
                                buildReportCard(
                                  Image.asset('assets/images/cars.png', fit: BoxFit.cover),
                                  'حادث سير يتسبب بأزمة مرورية في شارع الأردن بعمان',
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        ////////////////////////////////////////////////////////
                        Text('إنجازات النشامى', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[700])),
                        SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(child: buildStatCard(Icons.check_box, '1,240+', 'بلاغ محلول في منطقتك\nخلال هذا الشهر')),
                            SizedBox(width: 12),
                            Expanded(child: buildStatCard(Icons.access_time, '45 دقيقة', 'متوسط سرعة\nالاستجابة لبلديتك اليوم')),
                          ],
                        ),

                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomBottomNavBar(),
        ),
      ),
    );
  }

  Widget buildReportButton(IconData icon, String label) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.blue[700]),
          SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget buildReportCard(Widget image, String text) {
    return Container(
      width: 280,
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: image,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              text,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }


  Widget buildStatCard(IconData icon, String number, String description) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFDFECFF),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.blue[700]),
          SizedBox(height: 12),
          Text(number, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey[1000])),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////

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
