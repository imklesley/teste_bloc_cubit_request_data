import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teste_bloc_cubit_request_data/models/post_model.dart';

class PostsRepository {
  final String baseUrl = 'jsonplaceholder.typicode.com';

  /// End-points
  //Posts
  final String postsEndpoint = '/posts';

  Future<List<Post>> getPosts() async {
    try {
      Uri url = Uri.https(baseUrl, postsEndpoint);
      final http.Response response = await http.get(url);
      final List<dynamic> data = jsonDecode(response.body);
      final List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
      return posts;
    } catch (e) {
      throw Exception('Erro ao carregar postagens');
    }
  }
}
