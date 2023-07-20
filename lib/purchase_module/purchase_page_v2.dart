import 'dart:async';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:com.qksoft.storysaverfacebook/models/product.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_module/consumable_store.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_module/widget/purchase_button.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_module/widget/purchase_case_item.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_module/component/app_database.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_module/locator/locator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:page_transition/page_transition.dart';

import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

const String _weekId = 'remove_ads_weekly';
const String _monthId = 'remove_ads_monthly';
const String _yearId = 'remove_ads_yearly';
// const String _sub_01 = 'qksoft_sub_01';
// const String _sub_02 = 'qksoft_sub_02';
// const String _sub_03 = 'qksoft_sub_03';
// const String _sub_04 = 'qksoft_sub_04';
// const String _sub_05 = 'qksoft_sub_05';
// const String _sub_06 = 'qksoft_sub_06';
// const String _sub_07 = 'qksoft_sub_07';
const List<String> _kProductIds = <String>[
  _weekId,
  // _monthId,
  // _yearId
  // _sub_01,
  // _sub_02,
  // _sub_03,
  // _sub_04,
  // _sub_05,
  // _sub_06,
  // _sub_07,
];

class PurchasePageV2 extends StatefulWidget {
  const PurchasePageV2({super.key});

  @override
  State<PurchasePageV2> createState() => _PurchasePageV2State();
}

class _PurchasePageV2State extends State<PurchasePageV2> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  String? _selectedProductId;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isError = _queryProductError != null;

    if (isError) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Something wrong',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      );
    }

    final List<Widget> productList = <Widget>[];

    if (_products.isEmpty) {
      productList.add(const SizedBox(
        height: 20,
      ));
    } else {
      productList.addAll(_products.mapIndexed((index, product) =>
          PurchaseCaseItem(
              value: product.price,
              duration: product.parseDuration(),
              onPressed: () => setSelectedProductId(product.id),
              isSelected: _selectedProductId == product.id)));
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(bottom: 0),
              child: Icon(Icons.close),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16).copyWith(top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join Premium Plan',
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 44,
            ),
            // Supcription(svgPath: SvgPath.unlock, title: S.current.unlock),
            const SizedBox(
              height: 20,
            ),
            //  Supcription(svgPath: SvgPath.sub3, title: S.current.noAds),
            const SizedBox(
              height: 44,
            ),
            Center(
              child: Text(
                _getSelectedProductDetails()?.parseDescription() ?? "",
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: productList,
            ),
            const SizedBox(
              height: 10,
            ),
            PurchaseButton(
              onPressed: handlePurchaseButtonAsync,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Payment will be charged to iTunes Account at confirmation of purchase. To ensure uninterrupted service, all subscriptions are renewed automatically unless auto-renew is turned off at least 24-hours before the end of the current period. The account is charged for renewal within 24-hours before the end of the current period. Users can manage and cancel subscriptions in their account settings on the App Store. Please note that when your purchase a subscription, the sale is final, and we will not provide a refund. Your purchase will be subject to Apple\'s applicable payment policy, which also may not provide for refunds.',
              style: TextStyle(fontSize: 11, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // GestureDetector(
                //   onTap: handleTermButton,
                //   child: Text(
                //     S.current.term,
                //     style: AppTextStyle.regular13.copyWith(
                //         color: AppColor.white,
                //         decoration: TextDecoration.underline),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: handleRestoreButtonAsync,
                //   child: Text(
                //     S.current.restore,
                //     style: AppTextStyle.regular13.copyWith(
                //         color: AppColor.white,
                //         decoration: TextDecoration.underline),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: handlePrivacyPolicyButton,
                //   child: Text(
                //      'Privacy Policy',
                //     style:
                //        TextStyle(fontSize: 14, color: Colors.white),
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(_kProductIds.toSet());

    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error?.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
        _selectedProductId = _products.firstOrNull?.id;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
        _selectedProductId = _products.firstOrNull?.id;
      });
      return;
    }

    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
      _selectedProductId = _products.firstOrNull?.id;
    });
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          EasyLoading.show();
          break;
        case PurchaseStatus.purchased:
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          await locator<AppDatabase>().setPastProduct(Product(
            expireDate: DateTime.now().add(Duration(
              days: 3 +
                  ((purchaseDetails.productID == _weekId)
                      ? 7
                      : purchaseDetails.productID == _monthId
                          ? 30
                          : 365),
            )),
            productID: purchaseDetails.productID,
          ));
          EasyLoading.showSuccess(
            'You are Premium. Can\'t purchase',
          );
          break;
        case PurchaseStatus.error:
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          EasyLoading.showError('Something error');
          break;
        case PurchaseStatus.restored:
          await locator<AppDatabase>().setPastProduct(Product(
            expireDate: DateTime.fromMillisecondsSinceEpoch(
                    int.parse(purchaseDetails.transactionDate.toString()))
                .add(Duration(
              days: 3 +
                  ((purchaseDetails.productID == _weekId)
                      ? 7
                      : purchaseDetails.productID == _monthId
                          ? 30
                          : 365),
            )),
            productID: purchaseDetails.productID,
          ));
          EasyLoading.showSuccess(
            'Restored your plan',
          );
          break;
        case PurchaseStatus.canceled:
          // TODO: Handle this case.
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });
  }

  ProductDetails? _getSelectedProductDetails() {
    return _products
        .firstWhereOrNull((element) => element.id == _selectedProductId);
  }

  setSelectedProductId(String id) {
    setState(() {
      _selectedProductId = id;
    });
  }

  showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  handlePurchaseButtonAsync() async {
    debugPrint("handlePurchaseButtonAsync() called");

    Product? product = locator<AppDatabase>().getPastProduct();
    if (product != null && product.expireDate.isAfter(DateTime.now())) {
      EasyLoading.showInfo(
        'You are Premium. Can\'t purchase',
      );
      return;
    }

    ProductDetails? productDetails = _getSelectedProductDetails();

    if (productDetails == null) {
      return;
    }

    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      purchaseParam = GooglePlayPurchaseParam(
          productDetails: productDetails, changeSubscriptionParam: null);
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );
      var transactions = await SKPaymentQueueWrapper().transactions();
      for (var skPaymentTransactionWrapper in transactions) {
        await SKPaymentQueueWrapper()
            .finishTransaction(skPaymentTransactionWrapper);
      }
    }
    await _inAppPurchase
        .buyNonConsumable(purchaseParam: purchaseParam)
        .catchError((error) {
      EasyLoading.showError(
        'Can\'t purchase',
      );
      return true;
    });
  }

  // handleTermButton() {
  //   debugPrint("handleTermButtonTapped() called");
  //   Navigator.of(context).push(PageTransition(
  //       child: BrowserPage(
  //         url: 'https://sites.google.com/view/hello-vpn-fast-proxy',
  //         title:'Term of Use',
  //       ),
  //       type: PageTransitionType.rightToLeft));
  // }

  handleRestoreButtonAsync() async {
    EasyLoading.show();
    await _inAppPurchase.restorePurchases().catchError((e) {
      if (e is SKError) {
        EasyLoading.showInfo(
          e.userInfo['NSLocalizedDescription'] ?? 'Something wrong',
        );
      }
    });
    EasyLoading.dismiss();
  }

  // handlePrivacyPolicyButton() {
  //   Navigator.of(context).push(PageTransition(
  //     child: BrowserPage(
  //         url: 'https://sites.google.com/view/hellovpn-fastproxy',
  //         title: S.current.privacyPolicy),
  //     type: PageTransitionType.rightToLeft,
  //   ));
  // }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return false;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

extension ProductDetailsExt on ProductDetails {
  String parseDuration() {
    switch (id) {
      case _weekId:
        return 'week';
      case _monthId:
        return 'month';
      case _yearId:
        return 'year';
      default:
        return "Undefine";
    }
  }

  String parseDescription() {
    String duration = parseDuration();
    return "${'3 days free trial, renews at'} $price/$duration";
  }
}
