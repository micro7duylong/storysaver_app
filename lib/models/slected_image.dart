import 'package:flutter/material.dart';

class SelectedImages extends ChangeNotifier {
  late String coverImageUrl;
  late String pageImageUrl;

  void setImages(String coverImageUrl, String pageImageUrl) {
    this.coverImageUrl = coverImageUrl;
    this.pageImageUrl = pageImageUrl;
    notifyListeners();
  }
}
