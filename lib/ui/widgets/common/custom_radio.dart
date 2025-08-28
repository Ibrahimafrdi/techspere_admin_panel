import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';
import 'package:kabir_admin_panel/core/extensions/style.dart';

class CustomRadio extends StatefulWidget {
  final List<String> options;
  String? selectedStatus;
  final String title;
  final onSelectionChanged;

  CustomRadio({
    super.key,
    this.options = const [],
    this.onSelectionChanged,
    this.selectedStatus,
    this.title = '',
  });

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.customText(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        Row(
          children: widget.options
              .map<Widget>(
                (e) => Row(
                  children: [
                    Radio(
                      value: e,
                      groupValue: widget.selectedStatus ?? widget.options.first,
                      activeColor: primaryColor,
                      onChanged: (String? value) {
                        setState(() {
                          widget.selectedStatus = value!;
                        });
                        widget.onSelectionChanged(value);
                      },
                    ),
                    e.customText(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
