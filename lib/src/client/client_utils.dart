// import 'dart:async';
//
// import 'package:app_links/app_links.dart';
// import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
//
// import '../logger.dart';
//
// class Redirect {
//   void go() {
//     final authCompleter = Completer<Uri?>();
//     final appLinks = AppLinks();
//     late final StreamSubscription<Uri> sub;
//
//     sub = appLinks.uriLinkStream.listen(
//       (uri) {
//         if (uri.scheme == callbackUrlScheme) {
//           sub.cancel();
//           authCompleter.complete(uri);
//         }
//       },
//       onError: (e) {
//         logger.i(
//           '[WixAuthentication._redirectToLoginUrl] (uriLinkStream) User did not authenticate on login redirect',
//           error: e,
//         );
//         sub.cancel();
//         authCompleter.complete(null);
//       },
//     );
//
//     try {
//       await launchUrl(
//         Uri.parse(loginUrl),
//         customTabsOptions: CustomTabsOptions(
//           urlBarHidingEnabled: true,
//           showTitle: true,
//           // colorSchemes: CustomTabsColorSchemes.defaults(
//           //   toolbarColor: Theme.of(context).colorScheme.surface,
//           // ),
//         ),
//         // safariVCOptions: SafariViewControllerOptions(
//         //   preferredBarTintColor: Theme.of(context).colorScheme.surface,
//         //   preferredControlTintColor: Theme.of(context).colorScheme.onSurface,
//         //   dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
//         // ),
//       );
//     } catch (e) {
//       logger.i(
//         '[WixAuthentication._redirectToLoginUrl] (launchUrl) User did not authenticate on login redirect',
//         error: e,
//       );
//       return null;
//     }
//
//     final uri = await authCompleter.future;
//   }
// }
