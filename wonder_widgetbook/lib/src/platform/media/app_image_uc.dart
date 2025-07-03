import 'package:flutter/material.dart';
import 'package:wonder/src/widgets/media/app_image.dart';

final _fileUrl =
    'wix:image://v1/1246fe_92018f2407d34dc3bc8c29889d65d377~mv2.png/ziv_shalev.jpg#originWidth=600&originHeight=1006';

Widget appImage(BuildContext context) => AppImage(fileUrl: _fileUrl);
