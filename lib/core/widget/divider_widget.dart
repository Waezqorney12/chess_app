import 'package:flutter/material.dart';

Widget divider(BuildContext context) {
  return Container(
    height: 1,
    width: MediaQuery.of(context).size.width / 3,
    color: Colors.white.withOpacity(.4),
  );
}
