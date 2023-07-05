import 'package:flutter/material.dart';
import 'package:posts_app/core/resources/extensions.dart';
import 'package:posts_app/features/Posts/presentation/pages/add_or_update_page.dart';

import '../../domain/entities/post_entitie.dart';

class PostWidget extends StatelessWidget {
  final List<Post> posts;
  const PostWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.height * 0.01),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddOrUpdatePostPage(
                          isUpdate: true, post: posts[index]),
                    ));
              },
              leading: Text(
                posts[index].id.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              title: Text(posts[index].title),
              subtitle: Text(posts[index].body),
              contentPadding: EdgeInsets.all(context.height * 0.01),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
            );
          },
          itemCount: posts.length),
    );
  }
}
