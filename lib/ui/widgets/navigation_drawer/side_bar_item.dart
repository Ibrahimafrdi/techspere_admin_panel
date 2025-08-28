import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/padding.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

class SideBarItem extends StatefulWidget {
  final icon;
  final String title;
  final isSelected;
  final Function()? onTap;
  const SideBarItem({
    this.icon,
    required this.title,
    this.isSelected,
    this.onTap,
  });

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverDuration: Duration(milliseconds: 100),
        onHover: (value) {
          setState(() {
            isHovered = value;
          });
        },
        onTap: widget.onTap,
        child: Container(
            margin: EdgeInsets.only(
              bottom: 13,
              top: 3,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            // height: context.responsiveSize(40),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? primaryColor.withOpacity(0.1)
                  : widget.icon != null && isHovered
                      ? Color(0xFFF3F4F6)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.icon != null
                    ? Icon(
                        widget.icon,
                        size: 20,
                        color:
                            widget.isSelected ? primaryColor : Colors.black54,
                        weight: 10,
                      ).symmetricPadding(horizontal: 15)
                    : SizedBox(),
                widget.icon != null
                    ? widget.title.customText(
                        fontWeight: widget.isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color:
                            widget.isSelected ? primaryColor : Colors.black54,
                        fontSize: 16,
                      )
                    : widget.title.customText(
                        fontWeight: FontWeight.w600,
                        color: Colors.black38,
                        fontSize: 12,
                      ),
              ],
            )).symmetricPadding(horizontal: 10));
  }
}
