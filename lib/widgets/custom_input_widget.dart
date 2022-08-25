import 'package:cies_web_socket/widgets/custom_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'custom_text_style.dart';

class CustomInputWidget extends StatelessWidget {
  final String hint;
  final String label;
  final double? w;
  final double? h;
  final bool isPass;
  final bool enabled;
  // final Function(String data)? validate;
  final bool validate;
  final TextAlign textAlign;
  final double fontsize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius? borderRadius;
  final BorderSide? borderSideOn;
  final BorderSide? borderSideOff;
  final Function(String val)? onChange;
  final Function(String val)? onSaved;
  final Function(String val)? onSubmit;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final Color? hintColor;
  final Color? fillColor;

  const CustomInputWidget({
    Key? key,
    this.hint = '',
    this.label = '',
    this.w = 350,
    this.h,
    this.isPass = false,
    this.enabled = true,
    // this.validate,
    this.validate = false,
    this.textAlign = TextAlign.center,
    this.fontsize = 18,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.borderSideOn,
    this.borderSideOff,
    this.onChange,
    this.onSaved,
    this.onSubmit,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.hintColor,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      child: TextFormField(
        textInputAction: textInputAction,
        maxLines: maxLines,
        controller: controller,
        onChanged: onChange,
        // validator: validate == null ? null : (val) => validate!(val!),
        validator: validate
            ? (val) => val!.isEmpty ? "Debe completar este campo" : null
            : null,
        onSaved: onSaved == null ? null : (val) => onSaved!(val!),
        onFieldSubmitted: onSubmit == null ? null : (val) => onSubmit!(val),
        textAlign: textAlign,
        obscureText: isPass,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        style: TextStyle(
          fontSize: fontsize,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        enabled: enabled,
        decoration: InputDecoration(
          // constraints: BoxConstraints(maxWidth: w!),
          label: label.isEmpty ? null : CustomText(label),
          hintStyle: TextStyle(
            color: hintColor ?? Colors.black26.withOpacity(0.5),
            fontSize: 20,
          ),
          hintText: hint,
          alignLabelWithHint: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: fillColor ?? Colors.white,
          filled: true,
          labelStyle: customTextStyle(),
          helperStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(10)),
            borderSide: borderSideOff ?? BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(10)),
            borderSide: borderSideOff ?? BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(10)),
            borderSide: borderSideOn ?? BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(10)),
            borderSide: borderSideOff ?? BorderSide.none,
          ),
        ),
      ),
    );
  }
}
