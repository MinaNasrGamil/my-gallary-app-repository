import 'package:flutter/material.dart';
import 'package:mygallary_app/providers/gallaryProvider.dart';
import 'package:mygallary_app/providers/userProvider.dart';
import 'package:mygallary_app/screens/gallaryScreen.dart';
import 'package:mygallary_app/screens/loginScreen.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyImagesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            secondary: Colors.deepOrange,
            primary: Colors.purple,
          ),
          fontFamily: 'SegoeUI',
        ),
        home: LoginScreen(),
        routes: {
          GallaryScreen.routeName: (context) => GallaryScreen(),
        },
      ),
    );
  }
}
