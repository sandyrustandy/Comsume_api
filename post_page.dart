import 'dart:html';

import 'package:consume_api/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:consume_api/models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post});
  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final PostController postController = PostController();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Post"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width *0.01 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(
                child: Text(
                  widget.post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                height: size.height * 0.01,
              ),
              SizedBox(
                width: size.width,
                child: Text(
                  widget.post.body,
                  textAlign: TextAlign.justify,
                  ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: FutureBuilder<List<c.Comment>>(
                  future: postController.fetchComments(widget.post.id),
                builder: context, snapshot), {
                  if 
                },
                ),
              ),
            ],
          ),
         ),
      ),
    );
  }
}
