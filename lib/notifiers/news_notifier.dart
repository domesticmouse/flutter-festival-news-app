import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/constants/strings.dart';
import 'package:news_app/models/news_info_model.dart';

class NewsNotifier extends ChangeNotifier {
  List<NewsInfoModel> _newsInfoModelList = [];
  bool _isLoading = false;
  List<NewsInfoModel> get newsInfoModelList => _newsInfoModelList;
  bool get isLoading => _isLoading;

  static final Dio dio = Dio();

  Future<void> getNews({String? searchKeyWord, bool isInit = false}) async {
    _isLoading = true;
    if (!isInit) notifyListeners();

    final Response response = await dio.get(
      searchKeyWord != null ? Strings.apiEverything : Strings.apiTopHeadlines,
      queryParameters: {
        'apiKey': Strings.API_KEY,
        if (searchKeyWord == null) 'country': 'us',
        if (searchKeyWord != null) 'q': searchKeyWord,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = response.data;
      List list = map['articles'];
      List<Map<String, dynamic>> mapList =
          list.map((e) => e as Map<String, dynamic>).toList();

      _newsInfoModelList = mapList.map((m) {
        return NewsInfoModel.fromMap(m);
      }).toList();
    }

    _isLoading = false;
    notifyListeners();
  }
}
