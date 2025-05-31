import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/media/app_image.dart';

class ImagePage extends StatelessWidget {
  final String path;

  const ImagePage({required this.path});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: AppFileImage(path: path)),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
