
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_fintech/router.gr.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);


    Timer(const Duration(milliseconds: 3000), () {
      router.replacePath("/");
    });


    return const Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
            // color: Colors.amber,
            ),
        Padding(padding: EdgeInsets.only(top: 50)),
        Text(
          "Loading",
        )
      ],
    )));
  }
}