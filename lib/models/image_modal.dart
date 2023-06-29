class CoverModal {
  List<String> fetchedCoverData = [
    'assets/images/no_cover.png',
    'assets/images/cover1.png',
    'assets/images/cover2.png',
    'assets/images/cover3.png',
    'assets/images/cover4.png',
    'assets/images/cover5.png',
  ];

  List<String> coverTitles = [
    'No Cover',
    'Cover 1',
    'Cover 2',
    'Cover 3',
    'Cover 4',
    'Cover 5',
    'Cover 6',
  ];
}

//conver to local image
class PageModal {
  List<String> fetchedPageData = [
    'assets/images/blank_page.png',
    'assets/images/dotted_page.png',
    'assets/images/ruler_page.png',
    'assets/images/square_page.png',
    'assets/images/test_page.png',
  ];

  List<String> pageTitles = [
    'Blank',
    'Dotted Paper',
    'Square Paper',
    'Ruled Paper',
    'Test Paper',
    'Test Paper ',
    'Test Paper ',
  ];
}

class SizeModal {
  List<String> listsize = <String>[
    'A7 (iPhone)',
    'S6',
    'A5',
    'A3',
    'A2',
    'A1',
  ];
}

class ImageData {
  String path;
  String title;
  String date;
  bool isFavorite;

  ImageData(this.path, this.title, this.date, {this.isFavorite = false});

  static List<ImageData> getImageDataList() {
    return [
      ImageData('assets/images/cover1.png', 'Ocean curent', '06-June-2023'),
      ImageData('assets/images/cover2.png', 'Todo list', '06-June-2023'),
      ImageData('assets/images/cover3.png', 'Biological', '06-June-2023'),
      ImageData('assets/images/cover4.png', 'Geography', '06-June-2023'),
      ImageData('assets/images/cover5.png', 'Pink Flowers', '06-June-2023'),
      ImageData('assets/images/cover6.png', 'Physics', '06-June-2023'),
      ImageData('assets/images/cover7.png', 'Draw note', '06-June-2023'),
      ImageData('assets/images/cover8.png', 'Randome note', '06-June-2023'),
      ImageData('assets/images/cover9.png', 'Natures Gift', '06-June-2023'),
      ImageData('assets/images/cover10.png', 'Sketching ', '06-June-2023'),
      ImageData('assets/images/cover11.png', 'Coloring', '06-June-2023'),
      ImageData('assets/images/cover12.png', 'Fun note', '06-June-2023')
    ];
  }
}
