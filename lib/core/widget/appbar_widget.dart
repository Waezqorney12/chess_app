import 'package:flutter/material.dart';

AppBar appBar(BuildContext context,
    {required void Function()? onPressed, Color? backgroundColor, String? title, TextStyle? style, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: backgroundColor ?? Colors.transparent,
    title: title != null
        ? Text(
            title,
            style: style,
          )
        : null,
    centerTitle: title != null ? true : false,
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_rounded,
        color: Colors.grey,
        size: 32,
      ),
    ),
    actions: actions,
  );
}
