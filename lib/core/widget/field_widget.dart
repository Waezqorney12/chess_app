import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget widgetField(
  BuildContext context, {
  required String hintText,
  required TextEditingController controller,
  TextInputType? keyboardType,
  BorderRadiusGeometry? borderRadius,
  BoxBorder? border,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? contentPadding,
  Widget? icon,
}) {
  return Container(
    padding: padding,
    width: MediaQuery.of(context).size.width,
    height: 50,
    decoration: BoxDecoration(
      color: const Color(0xFF302E2B),
      borderRadius: borderRadius ?? BorderRadius.circular(6),
      border: border ??
          Border.all(
            color: Colors.white.withOpacity(.3),
          ),
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: hintText == 'Password' ? true : false,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? (icon != null ? null : const EdgeInsets.symmetric(horizontal: 12)),
        icon: icon,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.white.withOpacity(.4),
        ),
      ),
    ),
  );
}
