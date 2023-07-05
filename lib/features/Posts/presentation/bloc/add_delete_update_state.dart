// ignore_for_file: must_be_immutable

part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class AddDeleteUpdateLoadingState extends AddDeleteUpdateState {}

class AddDeleteUpdateSuccessState extends AddDeleteUpdateState {
  String message;
  AddDeleteUpdateSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class AddDeleteUpdateErrorState extends AddDeleteUpdateState {
  String message;
  AddDeleteUpdateErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
