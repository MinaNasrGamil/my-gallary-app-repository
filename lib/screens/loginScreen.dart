import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mygallary_app/providers/userProvider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passWordField = TextEditingController();

  LoginScreen({super.key});
  //-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/backGround_1.PNG"),
              fit: BoxFit.cover,
            )),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.2224,
                  ),
                  Text(
                    "My \nGellary",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenHeight * 0.0658,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.04319),
                      width: screenWidth * .8060,
                      height: screenHeight * .4190,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.9065 * 0.08144,
                        vertical: screenHeight * 0.3725 * 0.1391,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'LOG IN',
                              style: TextStyle(
                                fontSize: screenHeight * 0.04319 - 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: "SegoeUI",
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04979,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  color:
                                      const Color.fromRGBO(247, 247, 247, 100),
                                  child: TextField(
                                    controller: _emailField,
                                    decoration: InputDecoration(
                                      labelText: 'User Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04979,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(20)),
                                  color:
                                      const Color.fromRGBO(247, 247, 247, 100),
                                  child: TextField(
                                    controller: _passWordField,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  var _emai = _emailField.text;
                                  var _passWord = _passWordField.text;
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .loginUser(_emai, _passWord, context);
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Color.fromRGBO(123, 179, 255, 100),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenHeight * 0.02591 - 4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
