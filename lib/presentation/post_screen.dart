import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/bloc/posts/posts_cubit.dart';

import '../data/models/post.dart';

class PostsView extends StatelessWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      if (state is PostsLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Post> posts = [];

      if (state is PostsLoadingState) {
        posts = state.oldPosts;
      } else if (state is PostsLoadedState) {
        posts = state.posts;
      }

      return ListView.separated(itemBuilder: (context, index) {
        return _post(posts[index], context);
      }, separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[400],
        );
      }, itemCount: posts.length);
    });
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("${post.id}. ${post.title}", style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 10.0),
          Text(post.body)

        ],
      ),
    );
  }
}
