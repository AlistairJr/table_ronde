import 'package:flutter/material.dart';
import 'post_card.dart';

class HomeFeed extends StatelessWidget {
  final List<Map<String, dynamic>> posts;

  const HomeFeed({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}
