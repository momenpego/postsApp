// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/errors/failures.dart';
import 'package:posts_app/core/resources/app_strings.dart';
import 'package:posts_app/features/Posts/domain/usecases/get_posts.dart';

import '../../domain/entities/post_entitie.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  GetAllPostsUseCase getAll;
  PostsBloc({required this.getAll}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final postsOrFail = await getAll.call();
        postsOrFail.fold(
            (failure) => {
                  emit(ErrorDataState(
                      message: _MessageFailure(failure: failure)))
                },
            (posts) => {emit(SuccessDataState(posts: posts))});
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final postsOrFail = await getAll.call();
        postsOrFail.fold(
            (failure) => {
                  emit(ErrorDataState(
                      message: _MessageFailure(failure: failure)))
                },
            (posts) => {emit(SuccessDataState(posts: posts))});
      }
    });
  }

  String _MessageFailure({required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.SERVER_FAILURE_MESSAGE;
      case EmptyCasheFailure:
        return AppStrings.EMPTY_CACHE_FAILURE_MESSAGE;
      case NetWorkFailure:
        return AppStrings.OFFLINE_FAILURE_MESSAGE;
      default:
        return AppStrings.UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
