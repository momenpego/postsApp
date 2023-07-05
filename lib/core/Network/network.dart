import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkChecker {
  Future<bool> get hasconnected;
}

class NetWorkCheckerImp implements NetWorkChecker {
  final InternetConnectionChecker connectionChecker;
  NetWorkCheckerImp({required this.connectionChecker});

  @override
  Future<bool> get hasconnected => connectionChecker.hasConnection;
}
