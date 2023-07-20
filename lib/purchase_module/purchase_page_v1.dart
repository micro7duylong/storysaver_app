// import 'dart:async';
// import 'dart:io';

// import 'package:com.qksoft.storysaverfacebook/browser/browser_page.dart';
// import 'package:com.qksoft.storysaverfacebook/models/product.dart';
// import 'package:com.qksoft.storysaverfacebook/purchase_module/widget/purchase_button.dart';
// import 'package:com.qksoft.storysaverfacebook/purchase_module/widget/purchase_case_item.dart';
// import 'package:com.qksoft.storysaverfacebook/purchase_module/widget/supcription_item.dart';
// import 'package:com.qksoft.storysaverfacebook/util/component/app_database.dart';
// import 'package:com.qksoft.storysaverfacebook/util/component/locator/locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
// import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
// import 'package:page_transition/page_transition.dart';

// const String _weekId = 'remove_ads_weekly';
// const String _monthId = 'remove_ads_monthly';
// const String _yearId = 'remove_ads_yearly';
// const String _sub_01 = 'qksoft_sub_01';
// const String _sub_02 = 'qksoft_sub_02';
// const String _sub_03 = 'qksoft_sub_03';
// const String _sub_04 = 'qksoft_sub_04';
// const String _sub_05 = 'qksoft_sub_05';
// const String _sub_06 = 'qksoft_sub_06';
// const String _sub_07 = 'qksoft_sub_07';
// const List<String> _kProductIds = <String>[
//   _weekId,
//   _monthId,
//   _yearId,
//   _sub_01,
//   _sub_02,
//   _sub_03,
//   _sub_04,
//   _sub_05,
//   _sub_06,
//   _sub_07,
// ];

// class PurchasePageV2 extends StatefulWidget {
//   const PurchasePageV2({super.key});

//   @override
//   State<PurchasePageV2> createState() => _PurchasePageV2State();
// }

// class _PurchasePageV2State extends State<PurchasePageV2> {
//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   bool _available = false;
//   List<ProductDetails> _products = [];
//   final List<PurchaseDetails> _purchases = [];

//   int selectedIndex = 0;
//   setSelectedIndex(int value) {
//     debugPrint('set index');
//     setState(() {
//       selectedIndex = value;
//     });
//   }

//   @override
//   void initState() {
//     final Stream<List<PurchaseDetails>> purchaseUpdated =
//         _inAppPurchase.purchaseStream;

//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       setState(() {
//         _purchases.addAll(purchaseDetailsList);
//         _listenToPurchaseUpdated(purchaseDetailsList);
//       });
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (error) {
//       _subscription.cancel();
//     });

//     _initialize();
//     super.initState();
//   }

//   void _initialize() async {
//     _available = await _inAppPurchase.isAvailable();
//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
//     }
//     EasyLoading.show();
//     if (_available) {
//       List<ProductDetails> products = await _getProducts(
//         productIds: Set<String>.from(
//           _kProductIds,
//         ),
//       );
//       setState(() {
//         _products = products;
//         if (EasyLoading.isShow) {
//           EasyLoading.dismiss();
//         }
//       });
//     } else {
//       EasyLoading.dismiss();
//       EasyLoading.showInfo(
//         'Sorry can\'t purchase now',
//       );
//     }
//   }

//   Future<void> _subscribe({required ProductDetails product}) async {
//     final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
//     var transactions = await SKPaymentQueueWrapper().transactions();
//     for (var skPaymentTransactionWrapper in transactions) {
//       await SKPaymentQueueWrapper()
//           .finishTransaction(skPaymentTransactionWrapper);
//     }
//     await _inAppPurchase
//         .buyNonConsumable(
//       purchaseParam: purchaseParam,
//     )
//         .catchError((error) {
//       EasyLoading.showError(
//         'Can\'t purchase',
//       );
//       return true;
//     });
//   }

//   Future<List<ProductDetails>> _getProducts(
//       {required Set<String> productIds}) async {
//     ProductDetailsResponse response =
//         await _inAppPurchase.queryProductDetails(productIds);

//     return response.productDetails;
//   }

//   Future<void> _listenToPurchaseUpdated(
//       List<PurchaseDetails> purchaseDetailsList) async {
//     EasyLoading.dismiss();
//     if (purchaseDetailsList.isEmpty) {
//       EasyLoading.showInfo(
//         'No past purchase',
//       );
//     }
//     purchaseDetailsList.sort((pc1, pc2) =>
//         int.parse(pc1.transactionDate.toString()) >=
//                 int.parse(pc2.transactionDate.toString())
//             ? 1
//             : 0);
//     for (var purchaseDetails in purchaseDetailsList) {
//       switch (purchaseDetails.status) {
//         case PurchaseStatus.pending:
//           EasyLoading.show();
//           break;
//         case PurchaseStatus.purchased:
//           if (EasyLoading.isShow) {
//             EasyLoading.dismiss();
//           }
//           await locator<AppDatabase>().setPastProduct(Product(
//             expireDate: DateTime.now().add(Duration(
//               days: 3 +
//                   ((purchaseDetails.productID == _weekId)
//                       ? 7
//                       : purchaseDetails.productID == _monthId
//                           ? 30
//                           : 365),
//             )),
//             productID: purchaseDetails.productID,
//           ));
//           EasyLoading.showSuccess(
//             'You are Premium',
//           );
//           break;
//         case PurchaseStatus.restored:
//           await locator<AppDatabase>().setPastProduct(Product(
//             expireDate: DateTime.fromMillisecondsSinceEpoch(
//                     int.parse(purchaseDetails.transactionDate.toString()))
//                 .add(Duration(
//               days: 3 +
//                   ((purchaseDetails.productID == _weekId)
//                       ? 7
//                       : purchaseDetails.productID == _monthId
//                           ? 30
//                           : 365),
//             )),
//             productID: purchaseDetails.productID,
//           ));

//           EasyLoading.showSuccess(
//             'Restored your plan',
//           );
//           break;
//         case PurchaseStatus.error:
//           if (EasyLoading.isShow) {
//             EasyLoading.dismiss();
//           }
//           EasyLoading.showError('Something wrong');

//           break;
//         default:
//           break;
//       }
//       if (purchaseDetails.pendingCompletePurchase) {
//         await _inAppPurchase.completePurchase(purchaseDetails);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     if (Platform.isIOS) {
//       final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
//           _inAppPurchase
//               .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
//       iosPlatformAddition.setDelegate(null);
//     }
//     _subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _products.isEmpty
//         ? Container(
//             color: Colors.blue[300],
//             child: Center(
//               child: Text(
//                 'Something wrong',
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//             ))
//         : Scaffold(
//             backgroundColor: Colors.blue[300],
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.grey[300],
//               elevation: 0,
//               actions: [
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
//                       child: Icon(Icons.close),
//                     ))
//               ],
//             ),
//             body: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.all(16).copyWith(top: 0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Join Premium Plan',
//                     style: TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                   const SizedBox(
//                     height: 44,
//                   ),
//                   Supcription(
//                     title: 'Unlock Note Premium',
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Supcription(
//                     title: 'No ads',
//                   ),
//                   const SizedBox(
//                     height: 44,
//                   ),
//                   Center(
//                     child: Text(
//                       '${'3 days free trial, renews at'} ${_products.firstWhere((element) => element.id == _kProductIds[selectedIndex]).price}/${selectedIndex == 0 ? 'week' : selectedIndex == 1 ? 'month' : 'year'}',
//                       style: TextStyle(fontSize: 14, color: Colors.blueGrey),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[0])
//                           .price
//                           .toString(),
//                       duration: 'week',
//                       onPressed: () => setSelectedIndex(0),
//                       isSelected: selectedIndex == 0),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[1])
//                           .price
//                           .toString(),
//                       duration: 'month',
//                       onPressed: () => setSelectedIndex(1),
//                       isSelected: selectedIndex == 1),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[2])
//                           .price
//                           .toString(),
//                       duration: 'year',
//                       onPressed: () => setSelectedIndex(2),
//                       isSelected: selectedIndex == 2),

//                   ///test 7 sub
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[3])
//                           .price
//                           .toString(),
//                       duration: 'year',
//                       onPressed: () => setSelectedIndex(3),
//                       isSelected: selectedIndex == 3),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[4])
//                           .price
//                           .toString(),
//                       duration: 'year',
//                       onPressed: () => setSelectedIndex(4),
//                       isSelected: selectedIndex == 4),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[5])
//                           .price
//                           .toString(),
//                       duration: 'year',
//                       onPressed: () => setSelectedIndex(5),
//                       isSelected: selectedIndex == 5),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[6])
//                           .price
//                           .toString(),
//                       duration: 'year',
//                       onPressed: () => setSelectedIndex(6),
//                       isSelected: selectedIndex == 6),
//                   PurchaseCaseItem(
//                       value: _products
//                           .firstWhere(
//                               (element) => element.id == _kProductIds[7])
//                           .price
//                           .toString(),
//                       duration: 'year',
//                       onPressed: () => setSelectedIndex(7),
//                       isSelected: selectedIndex == 7),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   PurchaseButton(onPressed: () async {
//                     Product? product = locator<AppDatabase>().getPastProduct();
//                     if (product != null &&
//                         product.expireDate.isAfter(DateTime.now())) {
//                       EasyLoading.showInfo(
//                         'You are Premium. Can\'t purchase',
//                       );
//                       return;
//                     }
//                     await _subscribe(
//                         product: _products.firstWhere((element) =>
//                             element.id == _kProductIds[selectedIndex]));
//                   }),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Text(
//                     'Payment will be charged to iTunes Account at confirmation of purchase. To ensure uninterrupted service, all subscriptions are renewed automatically unless auto-renew is turned off at least 24-hours before the end of the current period. The account is charged for renewal within 24-hours before the end of the current period. Users can manage and cancel subscriptions in their account settings on the App Store. Please note that when your purchase a subscription, the sale is final, and we will not provide a refund. Your purchase will be subject to Apple\'s applicable payment policy, which also may not provide for refunds.',
//                     style: TextStyle(fontSize: 11, color: Colors.blueGrey),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       // GestureDetector(
//                       //   onTap: () {
//                       //     Navigator.of(context).push(PageTransition(
//                       //       child: BrowserPage(
//                       //           url:
//                       //               'https://sites.google.com/view/hello-vpn-fast-proxy',
//                       //           title:  'Term of Use'),
//                       //       type: PageTransitionType.leftToRight,
//                       //     ));
//                       //   },
//                       //   child: Text(
//                       //      'Term of Use',style:   TextStyle(fontSize: 14, color: Colors.white, decoration: TextDecoration.underline),,

//                       //   ),
//                       // ),
//                       GestureDetector(
//                           child: Text(
//                             'Restore',
//                             style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                                 decoration: TextDecoration.underline),
//                           ),
//                           onTap: () async {
//                             EasyLoading.show();
//                             await _inAppPurchase
//                                 .restorePurchases()
//                                 .catchError((e) {
//                               if (e is SKError) {
//                                 EasyLoading.showInfo(
//                                   e.userInfo['NSLocalizedDescription'] ??
//                                       'Something error',
//                                 );
//                               }
//                             });

//                             EasyLoading.dismiss();
//                           }),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }

// class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
//   @override
//   bool shouldContinueTransaction(
//       SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
//     return true;
//   }

//   @override
//   bool shouldShowPriceConsent() {
//     return false;
//   }
// }
