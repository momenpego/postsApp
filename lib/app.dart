import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/Posts/presentation/bloc/add_delete_update_bloc.dart';
import 'package:posts_app/features/Posts/presentation/bloc/posts_bloc.dart';
import 'package:posts_app/features/Posts/presentation/pages/posts_page.dart';

import 'core/resources/app_theme.dart';
import 'injection_cont.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdateBloc>())
      ],
      child: MaterialApp(
          theme: appTheme(),
          debugShowCheckedModeBanner: false,
          home: const PostsPage()),
    );
  }
}
