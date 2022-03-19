import 'package:flutter/material.dart';
import 'package:news_app/constants/palette.dart';
import 'package:news_app/models/news_info_model.dart';

final NewsInfoModel dummyNewsInfoModel = NewsInfoModel(
  title: "Some news title",
  dateTime: DateTime.now(),
  imageURL:
      "https://images.pexels.com/photos/2662116/pexels-photo-2662116.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
  content: dummyContent,
  author: "Eren",
);

class NewsViewPage extends StatelessWidget {
  final NewsInfoModel newsInfoModel;
  const NewsViewPage({Key? key, required this.newsInfoModel}) : super(key: key);

  static String getDateTimeInString(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Palette.deepBlue,
            size: 20,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsInfoModel.title,
                style: const TextStyle(
                  color: Palette.deepBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 300,
                color: Palette.lightGrey,
                child: newsInfoModel.imageURL != null
                    ? Hero(tag: newsInfoModel.imageURL!, child: Image.network(newsInfoModel.imageURL!, fit: BoxFit.cover))
                    : Container(),
              ),
              const SizedBox(height: 16),
              Text(
                // 12/03/2022
                getDateTimeInString(newsInfoModel.dateTime),
                style: const TextStyle(
                  color: Palette.lightGrey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                newsInfoModel.author ?? "No author",
                style: const TextStyle(
                  color: Palette.lightGrey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                newsInfoModel.content ?? "No content present",
                style: const TextStyle(
                  color: Palette.deepBlue,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const String dummyContent = """
orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text 
ever since the 1500s, when an unknown printer took a galley of type and 
scrambled it to make a type specimen book. 
It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

Why do we use it?
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


Where does it come from?
Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.
""";
