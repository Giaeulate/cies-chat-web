import 'package:cies_web_socket/widgets/custom_text.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    return const Center(
      child: CustomText(
        "404 Pagina no encontrada",
        fontSize: 30,
        textAlign: TextAlign.center,
      ),
    );
  });
}
