import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:io';

import 'package:consume_api/models/post.dart';
import 'package:consume_api/services/post_service.dart';

class PostController {
  Future<List<Post>> fetchAll() async {
    return await PostService().fetch().then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonBody = jsonDecode(res.body);
        return List.generate(
          jsonBody.length,
          (index) => Post.fromMap(
            jsonBody[index],
          ),
        );
      } else {
        throw Exception();
      }
    });
  }

  Future<List<Comment>> fetchComments(int id) async {
    return await PostService().fetchComments(id).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(res.body);
        return List.generate(
          jsonData.length,
          (index) => Comment.fromMap(jsonData[index]),
        );
      } else {
        throw Exception();
      }
    });
  }

  Future<bool> delete(int id) async {
    return await PostService().delete(id).then((res) {
      var jsonBody = jsonDecode(res.body);
      inspect(jsonBody);
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }
}
