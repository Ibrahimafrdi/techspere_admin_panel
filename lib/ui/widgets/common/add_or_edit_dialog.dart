import 'package:flutter/material.dart';
import 'package:kabir_admin_panel/core/constants/colors.dart';

class AddOrEditDialog extends StatelessWidget {
  final title;
  final onSave;
  final onCancel;
  final content;

  const AddOrEditDialog({
    super.key,
    this.title,
    this.content,
    this.onSave = null,
    this.onCancel = null,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      insetPadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      title: Center(child: Text(title)),
      content: SizedBox(
        width: 500,
        child: content,
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(top: 40, left: 40, bottom: 40, right: 40),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Text("Save"),
          onPressed: () {
            onSave();
            Navigator.of(context).pop();
          },
        ),
        SizedBox(
          width: 10,
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Text("Cancel"),
          onPressed: () {
            if (onCancel != null) {
              onCancel();
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
