import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/chatcontroller.dart';
import 'screens/chat_list.dart';
import 'screens/chat_page.dart';
import 'screens/login.dart';
import 'widgets/popup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Conditionally inject ChatController based on platform
    if (!kIsWeb) {
      Get.put(ChatController()); // Only put ChatController if not on web
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          titleLarge: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
      home: LoginPage(),
    );
  }
}
