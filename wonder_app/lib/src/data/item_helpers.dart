const mediaPublicUrlPrefix = 'https://static.wixstatic.com/media';

bool isWixImageUrl(String url) {
  return url.startsWith('wix:image://v1/');
}

String getStorageUrl(String wixImageUrl) {
  final match = RegExp(r'wix:image://v1/([^/]+)').firstMatch(wixImageUrl);
  if (match == null) {
    throw FormatException(
      'Invalid Wix image URL: $wixImageUrl with stack: ${StackTrace.current}',
    );
  }

  return '$mediaPublicUrlPrefix/${match.group(1)!}';
}
