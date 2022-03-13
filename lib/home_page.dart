import 'package:flutter/material.dart';
import 'package:news_app/news_view_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String imageURL =
      "https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

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
            const TextField(
              cursorColor: Palette.deepBlue,
              style: TextStyle(
                color: Palette.deepBlue,
                fontSize: 14,
              ),
              decoration: InputDecoration(
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
              child: ListView(
                children: [
                  NewsCard(newsInfoModel: dummyNewsInfoModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Palette {
  static const Color background = Color(0xffE8EDF2);
  static const Color lightGrey = Color(0xffB8C7D9);
  static const Color navyBlue = Color(0xff0A1016);
  static const Color grey = Color(0xff9EACC0);
  static const Color deepBlue = Color(0xff2E4B5D);
}

class NewsCard extends StatelessWidget {
  final NewsInfoModel newsInfoModel;
  const NewsCard({
    Key? key,
    required this.newsInfoModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsViewPage(newsInfoModel: newsInfoModel),
          ),
        );
      },
      child: Container(
        height: 300,
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            Container(
              height: 260,
              width: MediaQuery.of(context).size.width - (2 * 16),
              color: Palette.lightGrey,
              child: newsInfoModel.imageURL != null
                  ? Hero(tag: newsInfoModel.imageURL!, child: Image.network(newsInfoModel.imageURL!, fit: BoxFit.cover))
                  : Container(),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - (2 * 32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black12,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      newsInfoModel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Palette.deepBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
