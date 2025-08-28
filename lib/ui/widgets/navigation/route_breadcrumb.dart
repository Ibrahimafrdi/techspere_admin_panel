import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/ui/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class RouteBreadcrumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    final routeParts =
        currentRoute.split('/').where((part) => part.isNotEmpty).toList();

    print(currentRoute);

    routeParts.insert(0, 'dashboard');

    return (currentRoute != '/dashboard')
        ? Row(
            children: List.generate(routeParts.length, (index) {
              final isLast = index == routeParts.length - 1;
              final route = index == 0
                  ? '/dashboard'
                  : '/' + routeParts.sublist(1, index + 1).join('/');
              bool isHovered = false;

              return Row(
                children: [
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return InkWell(
                        onHover: (value) {
                          setState(() {
                            isHovered = value;
                          });
                        },
                        onTap: isLast ? null : () => appRouter.go(route),
                        child: Text(
                          routeParts[index].capitalize(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: isLast
                                ? Colors.black
                                : isHovered
                                    ? Colors.blue
                                    : Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                  if (!isLast)
                    Text(' / ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                ],
              );
            }),
          )
        : SizedBox();
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
