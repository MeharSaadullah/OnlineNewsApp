import 'package:http/http.dart' as http;
import 'package:online_news_app/modal/categories_news_modal.dart';
import 'package:online_news_app/modal/news_channel_headlines_modal.dart';
import 'package:online_news_app/repository/news_repository.dart';

class NewsViewModal {
  final _repo =
      NewsRepository(); // NewsRepository is a class which we created in repository

// NewsChannelHeadlinesModal name of modal
  Future<NewsChannelHeadlinesModal> FetchNewsChannelHeadlinesApi(
      String channel) async {
    final response = await _repo.FetchNewsChannelHeadlinesApi(channel);
    return response;
  }

  Future<CategoriesNewsModal> FetchCategoriesNewsApi(String channel) async {
    final response = await _repo.FetchCategoriesNewsApi(channel);
    return response;
  }
}
