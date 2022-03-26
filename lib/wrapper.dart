import 'package:flutter/material.dart';
import 'package:news_app/notifiers/auth_notifier.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();

    context.read<AuthNotifier>().isUserLoggedInInit();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, notifier, child) {
        if (notifier.isUserLoggedIn) {
          return const HomePage();
        } else {
          return const SignInPage();
        }
      },
    );
  }
}
