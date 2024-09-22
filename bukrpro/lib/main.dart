import 'package:bukrpro/screens/login.dart';
import 'package:bukrpro/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/audioProvider.dart';
import 'providers/chatProvider.dart';
import 'screens/chat_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => Msgprovider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
              useMaterial3: true,
              textTheme: const TextTheme(
                  titleMedium:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  titleSmall:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  titleLarge:
                      TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              appBarTheme: const AppBarTheme(
                  titleTextStyle:
                      TextStyle(fontSize: 30, color: Colors.black))),
          initialRoute: '/login',
          routes: {
            '/login': (context) => LoginPage(),
            '/chatslist': (context) => ChatList(),
            '/popup': (context) => IconPopup(),
          }),
    );
  }
}
