import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  static String id = 'splash_screen';

  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateHome();
  }

  _navigateHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Lottie.asset(
            'assets/splashscreen.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
            // width: 200,
            child: DefaultTextStyle(
          style: const TextStyle(fontSize: 24.0, color: Colors.black),
          child: AnimatedTextKit(animatedTexts: [
            TyperAnimatedText('Welcome To App.',
                speed: Duration(milliseconds: 236))
          ]),
        ))
      ]),
    );
  }
}
