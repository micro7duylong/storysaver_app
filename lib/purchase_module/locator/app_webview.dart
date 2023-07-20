


// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AppWebView extends StatelessWidget {
//   const AppWebView({
//     Key? key,
//     this.initialUrl,
//   }) : super(key: key);

//   final String? initialUrl;

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: initialUrl,
//       javascriptMode: JavascriptMode.unrestricted,
//       onPageStarted: (url) {
//         log('On Page Started: $url');
//         EasyLoading.show(
//           dismissOnTap: true,
//         );
//       },
//       onPageFinished: (url) {
//         log('On Page Finish: $url');
//         EasyLoading.dismiss();
//       },
//       onWebResourceError: (error) {
//         log(error.description);
//       },
//       onWebViewCreated: (controller) async {
//         var url = await controller.currentUrl();

//         log('On WebView Created: $url');
//       },
//     );
//   }
// }
