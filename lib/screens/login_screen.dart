import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testks2022/constant.dart';
import 'package:testks2022/models/user_model.dart';
import 'package:testks2022/screens/home_screen.dart';
import 'package:testks2022/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  String email = "";
  String password = "";
  late UserModel user;
  bool isLoad = false;

  Future<UserModel> login(String email, String password) async {
    setState(() {
      isLoad = true;
    });
    user = await LoginService(email, password);
    setState(() {
      isLoad = false;
    });
    if (user.email.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      //print(email + ", pass : " + password + " ==> pass!");
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.grey.shade300,
              title: Text("ไม่สามารถเข้าสู้ระบบได้"),
              content: Text("กรุณาตรวจสอบข้อมูล"),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ตกลง',
                      style: TextStyle(color: lightColor),
                    )),
              ],
            );
          });
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //ขนาดหน้าจอ
    return isLoad
        ? Center(
            child: Container(
              color: Colors.lightBlue[900],
              child: SpinKitFadingCircle(
                color: lightColor,
                size: 50,
              ),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(color: lightColor, fontSize: 64),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                        hintText: "Your email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      cursorColor: primaryColor,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                        hintText: "Password",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        onPressed: () {
                          login(email, password);
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
