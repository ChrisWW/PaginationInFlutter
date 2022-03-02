import 'package:pagination_app/data/services/post_service.dart';

import '../models/post.dart';

class PostsRepository {

  final PostsService service;

  PostsRepository(this.service);

 Future<List<Post>> fetchPosts(int page) async {
    final posts = await service.fetchPosts(page);
    return posts.map((e) => Post.fromJson(e)).toList();
  }
}