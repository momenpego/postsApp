import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/Widget/loading_widg.dart';
import 'package:posts_app/core/resources/app_strings.dart';
import 'package:posts_app/core/resources/extensions.dart';
import 'package:posts_app/features/Posts/presentation/pages/add_or_update_page.dart';
import 'package:posts_app/features/Posts/presentation/widgets/post_widget.dart';

import '../bloc/posts_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulidAppBar(),
      body: _bulidBody(
      ),
      floatingActionButton: _bulidFloatAction(context: context),
    );
  }
}

AppBar _bulidAppBar() => AppBar(
      title: const Text(AppStrings.POSTS),
    );

Widget _bulidBody() {
  return BlocBuilder<PostsBloc, PostsState>(
    builder: (context, state) {
      if (state is LoadingPostsState) {
        return const LoadingWidget();
      } else if (state is SuccessDataState) {
        return PostWidget(posts: state.posts);
      } else if (state is ErrorDataState) {
        return Center(
          child: Text(
            state.message,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: context.height * 0.018),
          ),
        );
      }
      return const SizedBox();
    },
  );
}

Widget _bulidFloatAction({required BuildContext context}) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AddOrUpdatePostPage(isUpdate: false)));
    },
    child: const Center(
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
  );
}
