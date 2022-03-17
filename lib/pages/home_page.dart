import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/palette.dart';
import 'package:news_app/constants/strings.dart';
import 'package:news_app/models/news_info_model.dart';
import 'package:news_app/news_view_page.dart';
import 'package:news_app/pages/components/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String imageURL =
      "https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  static final Dio dio = Dio();

  Future<List<NewsInfoModel>> getNews({String? searchKeyWord}) async {
    List<NewsInfoModel> newsInfoModelList = [];

    final Response response = await dio.get(
      searchKeyWord != null ? Strings.apiEverything : Strings.apiTopHeadlines,
      queryParameters: {
        'apiKey': Strings.API_KEY,
        if (searchKeyWord == null) 'country': 'us',
        if (searchKeyWord != null) 'q': searchKeyWord,
      },
    );

    Map<String, dynamic> map = response.data;
    List list = map['articles'];
    List<Map<String, dynamic>> mapList =
        list.map((e) => e as Map<String, dynamic>).toList();

    newsInfoModelList = mapList.map((m) {
      return NewsInfoModel.fromMap(m);
    }).toList();

    return newsInfoModelList;
  }

  late Future<List<NewsInfoModel>> _future;

  @override
  void initState() {
    super.initState();

    _future = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        elevation: 0,
        title: const Text(
          "News",
          style: TextStyle(
            color: Palette.deepBlue,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (str) {
                setState(() {
                  if (str.isEmpty) {
                    _future = getNews();
                  } else {
                    _future = getNews(searchKeyWord: str);
                  }
                });
              },
              cursorColor: Palette.deepBlue,
              style: const TextStyle(
                color: Palette.deepBlue,
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Palette.lightGrey,
                  fontSize: 14,
                ),
                prefixIcon: Icon(Icons.search, color: Palette.lightGrey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.lightGrey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.lightGrey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.deepBlue, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Top News",
              style: TextStyle(
                color: Palette.deepBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<NewsInfoModel>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount:
                          snapshot.data != null ? snapshot.data!.length : 0,
                      itemBuilder: (context, index) {
                        return NewsCard(newsInfoModel: snapshot.data![index]);
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
