import 'package:aoun1/HomePage.dart';
import 'package:aoun1/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChangePassword.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Color c1 = Color(0xFF1A4498);
  bool circularindicator = false, language = false;
  bool showPassword = false;
  final key = GlobalKey<FormState>();
  TextEditingController nm = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async {
    String inputId = nm.text.trim();
    String inputPassword = password.text.trim();

    setState(() {
      circularindicator = true;
    });

    try {
      var doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(inputId)
          .get();

      if (!doc.exists) {
        snackbar(context, "National ID is not found");
      } else {
        var data = doc.data()!;
        if (data["password"] == inputPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          snackbar(context, "Wrong Password");
        }
      }
    } catch (e) {
      snackbar(context, "Error : $e");
    } finally {
      setState(() {
        circularindicator = false;
      });
    }
    nm.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 15),
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              color: c1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Form(
                        key: key,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            t1(
                              nm,
                              v1,
                              "الرقم الوطني",
                              Icons.person_2_outlined,
                              false,
                              false,
                            ),
                            SizedBox(height: 30),
                            t1(
                              password,
                              v2,
                              "كلمة المرور",
                              Icons.password,
                              true,
                              true,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangePassword(),
                                      ),
                                    );
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "نسيت كلمة المرور؟",
                                    style: TextStyle(color: c1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: c1,
                                ),
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    login();
                                  }
                                },
                                child: circularindicator
                                    ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    : Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ليس لديك حساب؟",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignUp()),
                                      );
                                      nm.clear();
                                      password.clear();
                                    },
                                    child: Text(
                                      " إنشاء حساب",
                                      style: TextStyle(
                                        color: c1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.8),
                foregroundColor: c1,
                side: BorderSide(color: c1),
              ),
              onPressed: () {
                setState(() {
                  language = !language;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.language, size: 20, color: c1),
                  SizedBox(width: 5),
                  Text(language ? "Arb" : "Eng", style: TextStyle(color: c1)),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  String? v1(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (value.trim().length != 10) return "Invalid National Number";
    return null;
  }

  String? v2(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Password must be at least 8 characters";

    final uppercase = RegExp(r'[A-Z]');
    final lowercase = RegExp(r'[a-z]');
    final number = RegExp(r'[0-9]');

    if (!uppercase.hasMatch(value)) return "Password must contain an uppercase letter";
    if (!lowercase.hasMatch(value)) return "Password must contain a lowercase letter";
    if (!number.hasMatch(value)) return "Password must contain a number";

    return null;
  }

  TextFormField t1(
      TextEditingController q,
      String? Function(String?) v,
      String z,
      IconData a,
      bool x,
      bool show,
      ) {
    return TextFormField(
      validator: v,
      controller: q,
      cursorColor: c1,
      obscureText: show ? !showPassword : x,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),

        labelText: z,
        prefixIcon: Icon(a, color: Color(0x80000000)),
        suffixIcon: show
            ? IconButton(
          icon: Icon(
            showPassword ? Icons.visibility : Icons.visibility_off,
            color: Color(0x80000000),
          ),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        )
            : null,
        filled: true,
        fillColor: Colors.white10,
        labelStyle: TextStyle(color: Color(0xFF000000)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0x80000000)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: c1),
        ),
      ),
    );
  }

  void snackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: 5),
        content: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: c1,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.email, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
