import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:gunanacos_app/src/pages/login/login_page.dart';
import 'package:gunanacos_app/src/pages/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GetMaterialApp(
      title: 'GuanacosApp',
      debugShowCheckedModeBanner:false,
      initialRoute: '/',
      getPages: [
          GetPage(name: '/', page: () => LoginPage()),
          GetPage(name: '/register', page: () => RegisterPage())
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          brightness: Brightness.light, 
          primary: Colors.amber, 
          onPrimary: Colors.grey,
          secondary: Colors.amberAccent, 
          onSecondary: Colors.grey, 
          error: Colors.grey, 
          onError: Colors.grey, 
          background: Colors.grey, 
          onBackground: Colors.grey, 
          surface: Colors.grey, 
          onSurface: Colors.grey)
      ),
      navigatorKey: Get.key,
    );
  }
}
