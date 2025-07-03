import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../logger.dart';

class ImageSelector extends StatelessWidget {
  final void Function(XFile picked) onPicked;
  final Widget? child;
  final double? width;
  final double? height;

  const ImageSelector({required this.onPicked, this.child, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picker = ImagePicker();
        final picked = await picker.pickImage(source: ImageSource.gallery);
        if (picked == null) {
          logger.d('[ImageSelector] No image selected');
          return;
        }

        onPicked(picked);
      },
      child:
          child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(Icons.add_a_photo),
          ),
    );
  }
}
