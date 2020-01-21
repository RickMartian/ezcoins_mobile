import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget headerTitle(String headerText, [String subtext]) {
  return Container(
    alignment: Alignment.center,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: headerText + (subtext != null ? "\n" : ""),
            style: TextStyle(
              color: Color(0xFF454C7D),
            ),
          ),
          TextSpan(
            text: subtext ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
        style: GoogleFonts.baloo(
          textStyle: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
