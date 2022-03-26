import 'package:flutter/material.dart';
import 'package:news_app/constants/palette.dart';
import 'package:news_app/notifiers/auth_notifier.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "NE\nWS",
              style: TextStyle(
                color: Palette.deepBlue,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Consumer<AuthNotifier>(builder: (context, notifier, child) {
              if (notifier.isLoading) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthNotifier>().signInWithGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  child: const Text(
                    "Google Sign in",
                    style: TextStyle(
                      color: Palette.deepBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
