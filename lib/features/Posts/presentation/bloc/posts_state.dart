part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class SuccessDataState extends PostsState {
  final List<Post> posts;
  const SuccessDataState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorDataState extends PostsState {
  final String message;
  const ErrorDataState({required this.message});
  @override
  List<Object> get props => [message];
}
