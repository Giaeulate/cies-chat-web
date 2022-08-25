import 'package:cies_web_socket/theme/theme_app.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function()? onPress;
  final String text;
  final double w;
  final double h;
  final double fontSize;
  final Color? bgColor;
  final Color? fgColor;
  final Color? textColor;
  final Alignment alignment;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  const CustomButtonWidget({
    Key? key,
    this.onPress,
    this.text = 'Ingresar',
    this.w = 300,
    this.h = 70,
    this.fontSize = 16,
    this.bgColor,
    this.fgColor,
    this.textColor,
    this.alignment = Alignment.center,
    this.borderSide,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      alignment: alignment,
      child: ElevatedButton(
        style: ButtonStyle(
          // foregroundColor: MaterialStateProperty.all<Color>(fgColor ?? ThemeApp.primary),
          foregroundColor:
              MaterialStateProperty.all<Color>(textColor ?? ThemeApp.primary),
          backgroundColor:
              MaterialStateProperty.all<Color>(bgColor ?? Colors.white),
          minimumSize: MaterialStateProperty.all<Size>(Size(w, h)),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              // color: textColor ?? ThemeApp.primary,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius:
                  borderRadius ?? const BorderRadius.all(Radius.circular(25)),
              side: borderSide ?? const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        onPressed: onPress ?? () {},
        child: Text(text),
      ),
    );
  }
}
