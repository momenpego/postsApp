import 'package:posts_app/features/Posts/domain/entities/post_entitie.dart';

class PostModel extends Post {
  const PostModel(
      {required super.id, required super.title, required super.body});

  factory PostModel.fromjson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> tojson() => {'id': id, 'title': title, 'body': body};
}
