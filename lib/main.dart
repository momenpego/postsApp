import 'package:flutter/material.dart';
import 'package:posts_app/app.dart';
import 'package:posts_app/core/Http_req/dio_req.dart';
import 'injection_cont.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Diorequest.initdio();
  await di.injectAll();
  runApp(const MyApp());
}
