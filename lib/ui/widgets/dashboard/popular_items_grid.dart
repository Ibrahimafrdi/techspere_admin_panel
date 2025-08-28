import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

import '../../../core/constants/decorations.dart';

class PopularItemsGrid extends StatelessWidget {
  const PopularItemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: primaryDecoration.copyWith(color: Colors.white),
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                'Most Popular Items'.customText(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
