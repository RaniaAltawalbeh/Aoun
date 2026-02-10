import 'package:aoun1/EmergencyPage.dart';
import 'package:aoun1/ProcessingPage.dart';
import 'package:flutter/material.dart';
import 'Solved.dart';
import 'Drafts.dart';

class Areareports extends StatefulWidget {
  const Areareports({super.key});

  @override
  State<Areareports> createState() => _AreareportsState();
}

class _AreareportsState extends State<Areareports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            "assets/images/logowithouttext.png",
            width: 103.1,
            height: 110,
            fit: BoxFit.contain,
          ),
        ),
      ),


      //
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
                        MaterialPageRoute(builder: (context) =>  ProcessingPage()),
                      );
                    },
                    // change the style for it colors and border
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: activeColor,
                      side: BorderSide(color: activeColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text("تحت المعالجة",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),),
                  ),

                  SizedBox(width: 8),

                  // INACTIVE BUTTON
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Solved()),
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
                    child: Text("تم حلها" , style:TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ),

                  SizedBox(width: 8),

                  //drafts page button


                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Drafts()),
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
                    child: Text("المسودات" , style:TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ),

                  SizedBox(width: 8),




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
                    child: Text("بلاغات المنطقة" , style:TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 110,
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color:  Color(0xFFE6EEFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: k,
                        isExpanded: true,
                        icon:  SizedBox(),
                        dropdownColor: Colors.white,
                        selectedItemBuilder: (context) {
                          return op.map((_) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
                                Text(
                                  "تصفية",
                                  style: TextStyle(
                                    color: Color(0xFF1A4498),
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.filter_list,
                                  size: 17,
                                  color: Color(0xFF1A4498),
                                ),
                              ],
                            );
                          }).toList();
                        },
                        items: op.map<DropdownMenuItem<String>>((String h) {
                          return DropdownMenuItem<String>(
                            value: h,
                            child: Text(h , style: TextStyle(color: Color(0xFF1A4498)),),
                          );
                        }).toList(),
                        onChanged: (j) {
                          setState(() {
                            k = j!;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                // SEARCH FIELD
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      // the side of the text to the right
                      textAlign: TextAlign.right,
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
                        contentPadding:  EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        //the border of the text field
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:  BorderSide(
                            color: Color(0xFF1A4498),
                            width: 1.2,
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

            // list view builder here return all the complaints
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];

                  return SizedBox(
                    height: 181,
                    width: 550,
                    child: Container(
                      margin:  EdgeInsets.all(12),
                      padding:  EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF103F9B),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // IMAGE
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

                          // TEXT + BUTTON
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

                                SizedBox(height: 30),

                                SizedBox(
                                  width: 122,
                                  height: 30.62,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor:  Color(0xFF5D8FD4),
                                      elevation: 0,
                                      side:  BorderSide(
                                        color: Color(0xFF5D8FD4),
                                      ),
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),

                                    child:  Text(
                                      "عرض التفاصيل",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
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

