import 'package:flutter/material.dart';

class SnackBarMessage{
  void showMessage(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}