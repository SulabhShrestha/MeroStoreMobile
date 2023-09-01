import 'dart:io';

import 'package:flutter/material.dart';
import 'package:merostore_mobile/utils/constants/app_colors.dart';
import 'package:merostore_mobile/views/auth_page/auth_page.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mero Store',
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ConstantAppColors.greenColor,
          elevation: 4,
          splashColor: Colors.white,
          shape: CircleBorder(side: BorderSide()),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16),
          fillColor: ConstantAppColors.secondaryColor.withOpacity(0.3),
          filled: true,
          // contentPadding: const EdgeInsets.symmetric(
          //   horizontal: 12,
          //   vertical: 4,
          // ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          errorStyle: const TextStyle(height: 0.0),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            gapPadding: 0.0,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            gapPadding: 0.0,
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
        checkboxTheme: const CheckboxThemeData(
          shape: CircleBorder(),
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor:
              MaterialStateProperty.all(ConstantAppColors.greenColor),
          columnSpacing: 28,
          horizontalMargin: 12,
          headingTextStyle: const TextStyle(
            fontSize: 18,
            color: ConstantAppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          dataTextStyle: const TextStyle(
            fontSize: 18,
            color: ConstantAppColors.primaryColor,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
      home: const AuthPage(),
    );
  }
}
