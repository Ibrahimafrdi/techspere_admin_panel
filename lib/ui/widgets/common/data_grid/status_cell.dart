import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

import '../../../../core/constants/string_constants.dart';

class StatusCell extends StatelessWidget {
  final String text;

  StatusCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: getStatusColor(text).withOpacity(0.1),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: text.customText(
        color: getStatusColor(text),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Color getStatusColor(String text) {
    switch (text) {
      case pendingOrderString:
        return pendingOrderColor;
      case processingOrderString:
        return processingOrderColor;
      case outForDeliveryOrderString:
        return outForDeliveryOrderColor;
      case deliveredOrderString:
        return deliveredOrderColor;
      case canceledOrderString:
        return canceledOrderColor;
      case returnedOrderString:
        return returnedOrderColor;
      case rejectedOrderString:
        return rejectedOrderColor;
      case activeString:
        return Color(0xFF20C55E);
      case inActiveString:
        return Colors.red;
      case paidString:
        return Color(0xFF20C55E);
      case unPaidString:
        return Colors.red;
      default:
        return Color(0xFF20C55E);
    }
  }
}
