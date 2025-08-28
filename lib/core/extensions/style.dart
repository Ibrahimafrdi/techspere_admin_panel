import 'package:flutter/material.dart';

extension CustomText on String {
  Widget customText({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = Colors.black,
    TextAlign? textAlign,
    bool underline = false, // Add a parameter for underline
  }) {
    TextStyle textStyle = TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        overflow: TextOverflow.ellipsis
        // fontFamily: fontFamily,
        );

    // if (fontFamily == 'LeagueSpartan') {
    //   textStyle = GoogleFonts.leagueSpartan(
    //     fontWeight: fontWeight,
    //     fontSize: fontSize,
    //     color: color,
    //   );
    // } else if (fontFamily == 'Poppins') {
    //   textStyle = GoogleFonts.poppins(
    //     fontWeight: fontWeight,
    //     fontSize: fontSize,
    //     color: color,
    //   );
    // } else if (fontFamily == 'Mulish') {
    //   textStyle = GoogleFonts.mulish(
    //     fontWeight: fontWeight,
    //     fontSize: fontSize,
    //     color: color,
    //   );
    // } else {
    //   textStyle = GoogleFonts.roboto(
    //     fontWeight: fontWeight,
    //     fontSize: fontSize,
    //     color: color,
    //   );
    // }

    // Apply underline if needed
    if (underline) {
      textStyle = textStyle.copyWith(decoration: TextDecoration.underline);
    }

    return Text(
      this,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: textStyle,
    );
  }
}
