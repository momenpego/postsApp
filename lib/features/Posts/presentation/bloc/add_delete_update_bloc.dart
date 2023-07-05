// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/resources/app_strings.dart';
import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';
import 'package:posts_app/features/Posts/domain/usecases/add_post.dart';
import 'package:posts_app/features/Posts/domain/usecases/delete_post.dart';
import 'package:posts_app/features/Posts/domain/usecases/update_post.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  UpdatePostUseCase updatePost;
  AddPostUseCase addPost;
  DeletePostUseCase deletePost;
  AddDeleteUpdateBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(AddDeleteUpdateLoadingState());
        final addORFail = await addPost.call(post: event.post);
        addORFail.fold(
            (failure) => {
                  emit(AddDeleteUpdateErrorState(
                      message: _MessageOfError(failure: failure)))
                },
            (_) => {
                  emit(AddDeleteUpdateSuccessState(
                      message: AppStrings.ADD_SUCCESS_MESSAGE))
                });
      } else if (event is UpdatePostEvent) {
        emit(AddDeleteUpdateLoadingState());
        final updateOrFail = await updatePost.call(post: event.post);
        updateOrFail.fold(
            (failure) => {
                  emit(AddDeleteUpdateErrorState(
                      message: _MessageOfError(failure: failure)))
                },
            (_) => {
                  emit(AddDeleteUpdateSuccessState(
                      message: AppStrings.UPDATE_SUCCESS_MESSAGE))
                });
      } else if (event is DeletePostEvent) {
        emit(AddDeleteUpdateLoadingState());
        final deleteOrFail = await deletePost.call(postId: event.postId);
        deleteOrFail.fold(
            (failure) => {
                  emit(AddDeleteUpdateErrorState(
                      message: _MessageOfError(failure: failure)))
                },
            (_) => {
                  emit(AddDeleteUpdateSuccessState(
                      message: AppStrings.DELETE_SUCCESS_MESSAGE))
                });
      }
    });
  }

  String _MessageOfError({required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.SERVER_FAILURE_MESSAGE;
      case NetWorkFailure:
        return AppStrings.OFFLINE_FAILURE_MESSAGE;
      default:
        return AppStrings.UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
