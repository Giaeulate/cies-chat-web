import 'package:cies_web_socket/widgets/custom_loading.dart';
import 'package:cies_web_socket/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CustomLoading(),
            SizedBox(height: 20),
            CustomText("Cargando..."),
          ],
        ),
      ),
    );
  }
}
