import 'package:flutter/material.dart';

Widget donationText(String giver, String receiver) {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
      children: <TextSpan>[
        TextSpan(
          text: giver,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: " doou para "),
        TextSpan(
          text: receiver,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
