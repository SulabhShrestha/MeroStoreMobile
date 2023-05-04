import 'package:flutter/material.dart';
import 'package:merostore_mobile/views/root_page/root_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mero Store',
      home: RootPage(),
    );
  }
}
