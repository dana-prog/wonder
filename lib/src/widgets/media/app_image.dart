import 'package:flutter/cupertino.dart';
import 'package:wonder/src/data/picture_item.dart';

class AppImage extends StatelessWidget {
  final ImageFields imageFields;

  const AppImage(this.imageFields);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageFields.url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Text(error.toString());
      },
    );
  }
}
