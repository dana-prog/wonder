import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Widget test(BuildContext context) {
  CacheManager cacheManager = DefaultCacheManager();
  cacheManager.getFileFromCache('aaa');
  return Text(
    'This is a test use case for the app image widget.',
    style: TextStyle(fontSize: 20, color: Colors.black),
  );
}
