import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/post.dart';
import '../../data/repositories/post_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.repository) : super(PostsInitialState());

  int page = 1;
  final PostsRepository repository;

  void loadPosts() {
    if (state is PostsLoadingState) return;

    final currentState = state;

    var oldPosts = <Post>[];
    if (currentState is PostsLoadedState) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoadingState(oldPosts, isFirstFetch: page == 1));

    repository.fetchPosts(page).then((newPosts) {
      page++;

      final posts = (state as PostsLoadingState).oldPosts;
      posts.addAll(newPosts);

      emit(PostsLoadedState(posts));
    });
  }
}
