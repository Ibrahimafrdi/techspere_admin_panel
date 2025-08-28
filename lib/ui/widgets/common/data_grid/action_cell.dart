import 'package:flutter/material.dart';

class ActionCell extends StatelessWidget {
  final color;
  final icon;
  final onTap;
  final text;
  ActionCell({super.key, this.color, this.icon, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: color),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
