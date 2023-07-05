import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class NetWorkFailure extends Failure{
  @override
  List<Object?> get props => [];

}
class EmptyCasheFailure extends Failure{
  @override
  List<Object?> get props => [];

}