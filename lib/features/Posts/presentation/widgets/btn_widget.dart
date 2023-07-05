import 'package:flutter/material.dart';
import 'package:posts_app/core/resources/app_strings.dart';

class BottomWidget extends StatelessWidget {
  final bool isUpdate;
  final void Function() onPressed;
  const BottomWidget(
      {super.key, required this.isUpdate, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(isUpdate ? Icons.edit : Icons.add),
        label: Text(isUpdate ? AppStrings.EDIT_POST : AppStrings.ADD_POST));
  }
}
