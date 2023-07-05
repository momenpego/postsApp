// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:posts_app/core/resources/extensions.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';

class TextFieldWidget extends StatelessWidget {
  final String name;
  final bool isUpdate;
  final bool isMultiLines;
  final Post? post;
  TextEditingController controller;
  TextFieldWidget(
      {super.key,
      this.post,
      required this.controller,
      required this.isUpdate,
      required this.name,
      required this.isMultiLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.height * 0.01),
      child: TextFormField(
        controller: controller,
        validator: (value) =>
            value!.isEmpty ? "$name can't be Empty.." : null,
        minLines: isMultiLines ? 6 : 1,
        maxLines: isMultiLines ? 6 : 1,
        decoration: InputDecoration(hintText: '$name..'),
      ),
    );
  }
}
