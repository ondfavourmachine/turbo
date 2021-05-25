import 'package:flutter/material.dart';

class CustomSpinner {
  final String msg;
  CustomSpinner({@required this.msg});

  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(msg)
          ],
        ),
      ),
    );
  }
}
