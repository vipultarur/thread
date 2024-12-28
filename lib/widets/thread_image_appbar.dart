import 'dart:io';
import 'package:flutter/material.dart';

class PreviewImageWidget extends StatelessWidget {
  final File file;
  final Function(File) onRemoveImage;

  const PreviewImageWidget({
    Key? key,
    required this.file,
    required this.onRemoveImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              file,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              width: double.infinity,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: IconButton(
                onPressed: () => onRemoveImage(file),
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
