import 'package:flutter/material.dart';

class ImageDataNotifier with ChangeNotifier {
  List<String> imageUrlsCover = [];
  List<String> imageUrlsPage = [];
  bool isCoverLoading = false;
  bool isPageLoading = false;
  int _selectedCoverIndex = 0;
  int _selectedPageIndex = 0;

  int get selectedCoverIndex => _selectedCoverIndex;

  set selectedCoverIndex(int index) {
    _selectedCoverIndex = index;
    notifyListeners();
  }

  int get selectedPageIndex => _selectedPageIndex;

   set selectedPageIndex(int index) {
    _selectedPageIndex = index;
    notifyListeners();
  }
  void updateImageData(
      List<String> fetchedCoverData, List<String> fetchedPageData) {
    imageUrlsCover = fetchedCoverData;
    imageUrlsPage = fetchedPageData;
    isCoverLoading = false;
    isPageLoading = false;
    notifyListeners();
  }
}
