import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/constants/decorations.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

class OverviewGrid extends StatelessWidget {
  OverviewGrid({super.key});

  final colors = [
    primaryColor,
    Colors.indigo,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 90,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: primaryDecoration.copyWith(color: colors[index]),
          alignment: Alignment.topCenter,
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.monetization_on,
                    color: colors[index],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  'Total sales'.customText(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  'Rs. 700'.customText(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
