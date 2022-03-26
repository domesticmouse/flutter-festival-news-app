import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/firebase_options.dart';
import 'package:news_app/notifiers/auth_notifier.dart';
import 'package:news_app/notifiers/news_notifier.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsNotifier()),
        ChangeNotifierProvider(create: (context) => AuthNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
