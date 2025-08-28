import 'package:flutter/material.dart';

final primaryDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  boxShadow: [
    BoxShadow(
      color: Colors.black12.withOpacity(0.01),
      offset: Offset(0, 0),
      blurRadius: 15,
      spreadRadius: 4,
    )
  ],
);
