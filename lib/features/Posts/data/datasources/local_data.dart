import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/errors/exceptions.dart';
import 'package:posts_app/features/Posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  List<PostModel> getAllPosts();

  Future<Unit> cachePosts({required List<PostModel> posts});
}

class LocalDataSourceImp implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts({required List<PostModel> posts}) async {
    final List cachePosts1 = posts
        .map<Map<String, dynamic>>((postmodel) => postmodel.tojson())
        .toList();
    await sharedPreferences.setString('POSTS', json.encode(cachePosts1));
    return Future.value(unit);
  }

  @override
  List<PostModel> getAllPosts() {
    final posts = sharedPreferences.getString('POSTS');
    if (posts != null) {
      final List newPosts = json.decode(posts);
      final List<PostModel> cachedPosts =
          newPosts.map<PostModel>((e) => PostModel.fromjson(e)).toList();
      return cachedPosts;
    } else {
      throw EmptyCasheException();
    }
  }
}
