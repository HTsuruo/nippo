import 'package:flutter/material.dart';
import 'package:nippo/components/post_card.dart';
import 'package:nippo/models/controllers/post/post_state.dart';
import 'package:nippo/models/entities/post.dart';
import 'package:provider/provider.dart';

class PostListView extends StatelessWidget {
  const PostListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posts = context.select((PostState s) => s.posts);
    if (posts != null && posts.isNotEmpty) {
      return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final data = posts[index];
          final post = Post(
            title: data.title,
            description: data.description,
            createdAt: data.createdAt,
          );
          return PostCard(
            post: post,
            user: data.user,
          );
        },
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
