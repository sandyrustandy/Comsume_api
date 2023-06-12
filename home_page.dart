import 'dart:developer';

import 'package:consume_api/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:consume_api/controllers/post_controller.dart';
import 'package:go_router/go_router.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController postController = PostController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Post>>(
          future: postController.fetchAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                inspect(snapshot.data!);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(snapshot.data![index].id.toString()),
                        onDismissed: (direction) {
                          postController
                              .delete(snapshot.data![index].id)
                              .then((result) {
                            if (result) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Post deleted"),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to delete post"),
                                ),
                              );
                              setState(() {});
                            }
                          });
                        },
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              GoRouter.of(context).pushNamed(
                                AppRoutes.post,
                                extra: snapshot.data![index],
                              );
                            },
                            title: Text(
                              snapshot.data![index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              snapshot.data![index].body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: size.height * 0.005,
                      );
                    },
                    itemCount: snapshot.data!.length,
                  ),
                );
              } else {
                return Text("tidak ada data");
              }
            } else {
              return Text("err");
            }
          },
        ),
      ),
    );
  }
}
