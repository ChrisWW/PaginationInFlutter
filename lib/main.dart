import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_app/data/repositories/post_repository.dart';
import 'package:pagination_app/presentation/post_screen.dart';

import 'bloc/posts/posts_cubit.dart';
import 'data/services/post_service.dart';

void main() {
  runApp(PaginationApp(repository: PostsRepository(PostsService()),));
}

class PaginationApp extends StatelessWidget {
  const PaginationApp({Key? key, required this.repository}) : super(key: key);

  final PostsRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PostsCubit(repository),
        child: PostsView(),
      ),
    );
  }
}
