import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/media/app_image.dart';

class ImagePage extends StatelessWidget {
  final String fileUrl;

  const ImagePage({required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: AppImage(fileUrl: fileUrl)),
        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            // TODO: [THEME]
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
