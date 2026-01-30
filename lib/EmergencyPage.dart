import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  final List<String> buttons = ['حريق', 'إسعاف', 'شرطة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(     //بتخلي الاشياء بالواجهة تبدا من اليمين لانه الصفحة عربية
        textDirection: TextDirection.rtl,
        child:Stack(
        fit: StackFit.expand,
        children: [
          // الخلفية
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // الكبسات
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: buttons.map((text) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                            content: SizedBox(
                              width: 320,
                              height: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.warning_amber_rounded,
                                      size: 40, color: Colors.blue[900]),
                                  SizedBox(height: 12),
                                  Text(
                                    'هل أنت متأكد من إرسال بلاغ $text ؟',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actionsPadding: EdgeInsets.only(bottom: 18),
                            actions: [
                              SizedBox(
                                width: 110,
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[900],
                                    foregroundColor: Colors.white,
                                    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text('إلغاء'),
                                ),
                              ),
                              SizedBox(width: 20),
                              SizedBox(
                                width: 110,
                                height: 42,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[900],
                                    foregroundColor: Colors.white,
                                    textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text('تأكيد'),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[700],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.6),
                            blurRadius: 18,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
