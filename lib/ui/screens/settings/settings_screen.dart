import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/ui/widgets/navigation_drawer/side_bar_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Sidebar
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5, // Number of setting categories
              itemBuilder: (context, index) {
                return SideBarItem(
                  title: 'abc',
                  icon: Icons.settings,
                  isSelected: true,
                );
              },
            ),
          ),
        ),
        // Vertical divider
        const VerticalDivider(width: 1),
        // Settings content area
        Expanded(
          flex: 8,
          child: Center(
            child: Text('Select a category to view settings'),
          ),
        ),
      ],
    );
  }
}
