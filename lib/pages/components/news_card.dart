import 'package:flutter/material.dart';
import 'package:news_app/news_view_page.dart';

import '../../constants/palette.dart';
import '../../models/news_info_model.dart';

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