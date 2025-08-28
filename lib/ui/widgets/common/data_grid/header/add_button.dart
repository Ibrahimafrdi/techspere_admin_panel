import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

import '../../../../../core/constants/colors.dart';

class AddButton extends StatelessWidget {
  final text;
  final onTap;
  const AddButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.white,
              size: 20,
            ),
            ' $text'.customText(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
