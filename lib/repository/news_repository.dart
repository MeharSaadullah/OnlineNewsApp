import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_news_app/modal/categories_news_modal.dart';
import 'package:online_news_app/modal/news_channel_headlines_modal.dart'; //add package and use this package to get data as packets

// this class will fetch data of the api
class NewsRepository {
  // use future bcz we don't know how much time it take
  // NewsChannelHeadlinesModal is the name of modal which we created
  Future<NewsChannelHeadlinesModal> FetchNewsChannelHeadlinesApi(
      String channelname) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelname}&apiKey=96e2bf42afcd49fe8697c9840c740452';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModal.fromJson(body);
    }
    throw Exception('ERROR');
  }

  Future<CategoriesNewsModal> FetchCategoriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=96e2bf42afcd49fe8697c9840c740452';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModal.fromJson(body);
    }
    throw Exception('ERROR');
  }
}
