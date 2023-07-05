// ignore_for_file: must_be_immutable

part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdateEvent {
  Post post;
  AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddDeleteUpdateEvent {
  Post post;
  UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdateEvent {
  int postId;
  DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
