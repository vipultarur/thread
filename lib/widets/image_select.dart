import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thread/utils/helper.dart';

class ImageSelect extends StatelessWidget {
  final double radius;
  final String? url;
  final File? file;

  const ImageSelect({
    this.radius = 20,
    this.file,
    this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return CircleAvatar(
        backgroundImage: FileImage(file!),
        radius: radius,
      );

    } else if (url != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(getbukket1url(url!)),
        radius: radius,
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage("lib/assets/images/avatar.png"),
        backgroundColor: Colors.grey[200],
      );
    }
  }
}