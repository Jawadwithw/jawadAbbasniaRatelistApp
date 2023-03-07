import 'package:flutter/material.dart';
import 'package:ratelist/providers/ratelist_provider.dart';
import 'package:ratelist/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: RateListProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Satoshi',
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen()),
    );
  }
}
