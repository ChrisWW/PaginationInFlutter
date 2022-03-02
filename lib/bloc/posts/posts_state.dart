part of 'posts_cubit.dart';

@immutable
abstract class PostsState {
  const PostsState();

}

class PostsInitialState extends PostsState { }

class PostsLoadedState extends PostsState {
  final List<Post> posts;

  PostsLoadedState(this.posts);

}

class PostsLoadingState extends PostsState {
final List<Post> oldPosts;
final bool isFirstFetch;

  PostsLoadingState(this.oldPosts, {this.isFirstFetch = false});

}

class PostsErrorState extends PostsState {
    final error;

    PostsErrorState(this.error);

    @override
    List<Object> get props => [error];
}
