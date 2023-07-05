// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/Widget/loading_widg.dart';
import 'package:posts_app/core/resources/app_strings.dart';
import 'package:posts_app/core/resources/extensions.dart';
import 'package:posts_app/core/util/show_snakbar.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';
import 'package:posts_app/features/Posts/presentation/widgets/form_widget.dart';

import '../bloc/add_delete_update_bloc.dart';

class AddOrUpdatePostPage extends StatefulWidget {
  final Post? post;
  final bool isUpdate;
  TextEditingController bodyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  AddOrUpdatePostPage({super.key, this.post, required this.isUpdate});

  @override
  State<AddOrUpdatePostPage> createState() => _AddOrUpdatePostPageState();
}

class _AddOrUpdatePostPageState extends State<AddOrUpdatePostPage> {
  @override
  void initState() {
    if (widget.isUpdate) {
      widget.titleController.text = widget.post!.title;
      widget.bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulidAppBar(isUpdate: widget.isUpdate),
      body: _bulidBody(),
    );
  }

  Widget _bulidBody() {
    return BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
        listener: (context, state) {
      if (state is AddDeleteUpdateErrorState) {
        AppSnakBarMessages.snakbarErrorMesage(
            context: context, message: state.message);
      } else if (state is AddDeleteUpdateSuccessState) {
        AppSnakBarMessages.snakbarSuccessMesage(
            context: context, message: state.message);
        Navigator.pop(context);
      }
    }, builder: (context, state) {
      if (state is AddDeleteUpdateLoadingState) {
        return const LoadingWidget();
      }
      return  Padding(
          padding: EdgeInsets.all(context.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormWidget(
                post1: widget.post,
                isUpdate: widget.isUpdate,
                titleController: widget.titleController,
                bodyController: widget.bodyController,
              ),
            ],
          ),
        );
    });
  }
}

AppBar _bulidAppBar({required bool isUpdate}) {
  return AppBar(
    title: Text(isUpdate ? AppStrings.EDIT_POST : AppStrings.ADD_POST),
  );
}
