// import 'package:com.qksoft.storysaverfacebook/util/component/app_webview.dart';
// import 'package:flutter/material.dart';


// class BrowserPage extends StatelessWidget {
//   const BrowserPage({
//     Key? key,
//     required this.title,
//     this.url,
//   }) : super(key: key);

//   final String title;
//   final String? url;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         leading: Center(
//           child: GestureDetector(
//               behavior: HitTestBehavior.translucent,
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child:  Icon(Icons.arrow_back)),
//         ),
//       ),
//       body: AppWebView(
//         initialUrl: url,
//       ),
//     );
//   }
// }
