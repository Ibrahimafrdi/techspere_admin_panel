import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

import '../../../../../core/constants/colors.dart';

class BorderedButton extends StatelessWidget {
  final String text;
  final ontap;
  const BorderedButton({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              getIcon(text),
              size: 20,
              color: primaryColor,
            ),
            SizedBox(
              width: 3,
            ),
            text.customText(
              color: primaryColor,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: primaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  IconData getIcon(String text) {
    switch (text) {
      case 'Export':
        return Icons.file_open_outlined;
      case 'Import':
        return Icons.file_download_outlined;
      case 'Filter':
        return Icons.filter_alt_outlined;
      default:
        return Icons.file_open_outlined;
    }
  }
}
