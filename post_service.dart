import 'dart:convert';

import 'package:consume_api/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:consume_api/utils/endpoint.dart';
import 'package:consume_api/utils/request_helper.dart';

class PostService {
  Future<http.Response> fetch() async {
    String endPoint = Endpoint.post;
    Uri url = Uri.parse(endPoint);
    return await http.get(
      url,
      headers: RequestHelper.basicHeader(),
    );
  }

  Future<http.Response> fetchComments(int id) async {
    String endpoint = "${Endpoint.post}/$id/comments";
    Uri url = Uri.parse(endpoint);

    return await http.get(
      url,
      headers: RequestHelper.basicHeader(),
    );
  }

  Future<http.Response> post(Post post) async {
    String endpoint = Endpoint.post;
    Uri url = Uri.parse(endpoint);
    var jsonbody = post.toMap();

    return await http.post(
      url,
      body: jsonEncode(jsonbody),
      headers: RequestHelper.basicHeader(),
    );
  }

  Future<http.Response> put(Post post) async {
    String endpoint = "${Endpoint.post}/${post.id}";
    Uri url = Uri.parse(endpoint);
    var jsonbody = post.toMap();

    return await http.put(
      url,
      body: jsonEncode(jsonbody),
      headers: RequestHelper.basicHeader(),
    );
  }

  Future<http.Response> patch({
    required int id,
    String? title,
    String? body,
  }) async {
    String endpoint = "${Endpoint.post}/$id";
    Uri url = Uri.parse(endpoint);

    Map<String, dynamic> jsonbody = {};
    if (title != null) {
      jsonbody["title"] = title;
    }

    if (body != null) {
      jsonbody["body"] = body;
    }

    return await http.patch(
      url,
      body: jsonEncode(jsonbody),
      headers: RequestHelper.basicHeader(),
    );
  }

  Future<http.Response> delete(int id) async {
    String endpoint = "${Endpoint.post}/$id";
    Uri url = Uri.parse(endpoint);

    return await http.delete(
      url,
      headers: RequestHelper.basicHeader(),
    );
  }
}
