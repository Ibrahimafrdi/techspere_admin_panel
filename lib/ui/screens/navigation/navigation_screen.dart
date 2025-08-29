import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/responsive_size_extension.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';
import 'package:kabir_admin_panel/ui/screens/navigation/navigation_controller.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation/route_breadcrumb.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation_drawer/navigation_side_bar.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Provider.of<NavigationController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Image.asset(
          'assets/images/techspere.png',
          scale: 8,
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                ' John doe'.customText(
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                  fontSize: 14,
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_drop_down,
                  color: primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: NavigationSideBar(),
          ),
          Expanded(
            flex: 27,
            child: Container(
              height: double.infinity,
              width: context.width,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF7F7FC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RouteBreadcrumb(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
