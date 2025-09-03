import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:kabir_admin_panel/ui/screens/navigation/navigation_controller.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation_drawer/side_bar_item.dart';
import 'package:provider/provider.dart';

class NavigationSideBar extends StatelessWidget {
  const NavigationSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationController>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15),
      alignment: Alignment.topCenter,
      child: ListView.builder(
        itemCount: provider.titles.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return SideBarItem(
            icon: provider.icons[index],
            title: provider.titles[index],
            isSelected: appRouter.routeInformationProvider.value.uri
                .toString()
                .contains(provider.routes[index]),
            onTap: () {
              if (index == 1 ||
                  index == 5 ||
                  index == 7 ||
                  index == 9 ||
                  index == 11 ||
                  index == 14) {
              } else {
                provider.toggleScreen(index);
              }
            },
          );
        },
      ),
    );
  }
}
