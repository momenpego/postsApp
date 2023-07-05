import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/Posts/presentation/widgets/text_field_widget.dart';

import '../../domain/entities/post_entitie.dart';
import '../bloc/add_delete_update_bloc.dart';
import 'btn_widget.dart';

class FormWidget extends StatelessWidget {
  final bool isUpdate;
  final Post? post1;
  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  final TextEditingController bodyController;
  final TextEditingController titleController;
  FormWidget(
      {super.key,
      required this.post1,
      required this.isUpdate,
      required this.titleController,
      required this.bodyController});

  @override
  Widget build(BuildContext context) {
    void addOrUpdate() {
      final Post post = Post(
          id: isUpdate ? post1!.id : 0,
          title: titleController.text,
          body: bodyController.text);
      if (isUpdate) {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdateBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }

    return Form(
      key: _myKey,
      child: Column(
        children: [
          TextFieldWidget(
              isMultiLines: false,
              name: 'title',
              isUpdate: isUpdate,
              controller: titleController),
          TextFieldWidget(
            isMultiLines: true,
            name: 'body',
            isUpdate: isUpdate,
            controller: bodyController,
          ),
          BottomWidget(
              isUpdate: isUpdate,
              onPressed: () {
                if (_myKey.currentState!.validate()) {
                  addOrUpdate();
                }
              })
        ],
      ),
    );
  }
}
