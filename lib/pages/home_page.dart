import 'package:flutter/material.dart';
import 'package:news_app/constants/palette.dart';
import 'package:news_app/notifiers/auth_notifier.dart';
import 'package:news_app/notifiers/news_notifier.dart';
import 'package:news_app/pages/components/news_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<NewsNotifier>().getNews(isInit: true);
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
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthNotifier>().signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Palette.deepBlue,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (str) {
                if (str.isEmpty) {
                  context.read<NewsNotifier>().getNews();
                } else {
                  context.read<NewsNotifier>().getNews(searchKeyWord: str);
                }
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
              child: Consumer<NewsNotifier>(
                builder: (context, notifier, child) {
                  if (notifier.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: notifier.newsInfoModelList.length,
                      itemBuilder: (context, index) {
                        return NewsCard(
                            newsInfoModel: notifier.newsInfoModelList[index]);
                      },
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
