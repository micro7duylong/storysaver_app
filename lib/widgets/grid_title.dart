
//   import 'package:flutter/material.dart';
// import 'package:storysaver_app/models/image_modal.dart';

// GridTile getGridItem(ImageData imageData) {
//     return GridTile(
//       child: (_viewType == ViewType.list)
//           ? GestureDetector(
//               onTap: () {
//                 // Handle item tap event
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(top: 5, bottom: 10),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Container(
//                           width: 100,
//                           height: 150,
//                           child: Image.asset(
//                             imageData.path,
//                             fit: BoxFit.cover,
//                           ),
//                           // child: Image.network(
//                           //   fit: BoxFit.cover,
//                           //   imageData.path,
//                           // ),
//                         )),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           imageData.title,
//                           style:
//                               const TextStyle(fontSize: 15, color: Colors.blue),
//                         ),
//                         Text(
//                           imageData.date,
//                           style:
//                               const TextStyle(fontSize: 15, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: Container(),
//                     ),
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.keyboard_arrow_down,
//                           color: Colors.blue,
//                         )),
//                     IconButton(
//                       icon: Icon(
//                         imageData.isFavorite
//                             ? Icons.favorite_outlined
//                             : Icons.favorite,
//                         color: imageData.isFavorite ? Colors.blue : Colors.grey,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           imageData.isFavorite = !imageData.isFavorite;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Container(
//               child: Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         child: Stack(
//                           children: [
//                             SizedBox(
//                               width: 150,
//                               // child: Image.network(
//                               //   imageData.path,
//                               //   fit: BoxFit.cover,
//                               // ),
//                               child: Image.asset(
//                                 imageData.path,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Positioned(
//                               top: 5,
//                               right: 5,
//                               child: IconButton(
//                                 icon: Icon(
//                                   imageData.isFavorite
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: imageData.isFavorite
//                                       ? Colors.blue
//                                       : Colors.white,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     imageData.isFavorite =
//                                         !imageData.isFavorite;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           imageData.title,
//                           style:
//                               const TextStyle(fontSize: 15, color: Colors.blue),
//                         ),
//                         Expanded(
//                           child: Container(),
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.keyboard_arrow_down,
//                               color: Colors.blue,
//                             ))
//                       ],
//                     ),
//                     Text(
//                       imageData.date,
//                       style: const TextStyle(fontSize: 15, color: Colors.grey),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// enum ViewType { grid, list }