import 'package:cies_web_socket/theme/theme_app.dart';
import 'package:cies_web_socket/widgets/custom_loading.dart';
import 'package:cies_web_socket/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

showCustomAlertLoading(BuildContext context, {String? text}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text(
        text ?? "Cargando...",
        style: const TextStyle(
          color: Color(0xff00064f),
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
      content: const SizedBox(
        height: 70,
        child: CustomLoading(),
      ),
    ),
  );
}

showCustomAlert(BuildContext context, String title, String subtitle,
    {onPress, backgroundColor, textColor}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          color: textColor ?? ThemeApp.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        subtitle,
        textAlign: TextAlign.start,
        style: GoogleFonts.poppins(
          color: textColor ?? ThemeApp.primary,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: textColor ?? ThemeApp.primary,
          onPressed: onPress ?? () => Navigator.pop(context),
          child: Text(
            "Aceptar",
            textAlign: TextAlign.start,
            style: GoogleFonts.poppins(
              color: textColor ?? ThemeApp.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}

showCustomQuestionAlert(BuildContext context, String title,
    {onPress, backgroundColor, textColor, onLeftPress}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: backgroundColor,
      title: CustomText(title),
      actionsPadding: const EdgeInsets.only(bottom: 30),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: textColor ?? ThemeApp.primary,
          onPressed: onLeftPress ?? () => Navigator.pop(context),
          child: const CustomText('No'),
        ),
        MaterialButton(
          elevation: 5,
          textColor: textColor ?? ThemeApp.primary,
          onPressed: onPress ?? () => Navigator.pop(context),
          child: const CustomText("Si"),
        ),
      ],
    ),
  );
}
