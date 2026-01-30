import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  Color c1 = Color(0xFF1A4498);
  bool circularindicator = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  final key = GlobalKey<FormState>();

  TextEditingController confirmpassword = TextEditingController();
  TextEditingController nm = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> changePassword() async {
    String nationalId = nm.text.trim();
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(nationalId)
        .get();

    if (doc.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(nationalId)
          .update({
        "password": password.text.trim(),
      });
      nm.clear();
      password.clear();
      confirmpassword.clear();
      Navigator.pop(context);
      snackbar(context, "Password updated successfully");

    } else {
      snackbar(context, "Invalid National ID");
      nm.clear();
      password.clear();
      confirmpassword.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body:Directionality(
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
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Image.asset(
                        "assets/images/logowithouttext.png",
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: c1, width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: c1.withOpacity(1),
                                      blurRadius: 8,
                                      spreadRadius: -2,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "تغيير كلمة المرور",
                                        style: TextStyle(
                                          color: c1,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
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
                                            "كلمة المرور الجديدة",
                                            Icons.password,
                                            true,
                                            true,
                                          ),
                                          SizedBox(height: 30),
                                          t1(
                                            confirmpassword,
                                            v3,
                                            "تأكيد كلمة المرور",
                                            Icons.password,
                                            true,
                                            true,
                                            isConfirm: true,
                                          ),
                                          SizedBox(height: 20),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: c1,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                              ),
                                              onPressed: () async {
                                                if (key.currentState!.validate()) {
                                                  setState(() {
                                                    circularindicator = true;
                                                  });

                                                  await changePassword();

                                                  setState(() {
                                                    circularindicator = false;
                                                  });
                                                }
                                              },
                                              child: circularindicator
                                                  ? CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                                  : Text(
                                                "تغيير",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                        ],
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
        ],
      ),
      ),
    );
  }

  String? v1(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (value.toString().trim().length != 10) return "Invalid National Number";
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

  String? v3(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (value != password.text && value != null) return "Wrong Confirmation";
    return null;
  }

  TextFormField t1(
      TextEditingController q,
      String? Function(String?) v,
      String z,
      IconData a,
      bool x,
      bool isPassword, {
        bool isConfirm = false,
      }) {
    return TextFormField(
      validator: v,
      controller: q,
      obscureText: isPassword
          ? (isConfirm ? !showConfirmPassword : !showPassword)
          : x,
      cursorColor: c1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        labelText: z,
        prefixIcon: Icon(a, color: Color(0x80000000)),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isConfirm
                ? (showConfirmPassword
                ? Icons.visibility
                : Icons.visibility_off)
                : (showPassword
                ? Icons.visibility
                : Icons.visibility_off),
            color: Color(0x80000000),
          ),
          onPressed: () {
            setState(() {
              if (isConfirm) {
                showConfirmPassword = !showConfirmPassword;
              } else {
                showPassword = !showPassword;
              }
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