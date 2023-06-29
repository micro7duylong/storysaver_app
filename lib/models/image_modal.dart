class CoverModal {
  List<String> fetchedCoverData = [
    'https://lightning.od-cdn.com/static/img/no-cover_en_US.a8920a302274ea37cfaecb7cf318890e.jpg',
    'https://images.unsplash.com/photo-1543857778-c4a1a3e0b2eb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=410&q=80',
    'https://images.unsplash.com/photo-1592421816956-1c90ad73ba0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=386&q=80',
    'https://images.unsplash.com/photo-1527769929977-c341ee9f2033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1589085278607-c12dc87ddb1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
    'https://images.unsplash.com/photo-1560211653-def0966f4537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
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
    'https://images.unsplash.com/photo-1637325258040-d2f09636ecf6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
    'https://images.unsplash.com/photo-1615799998603-7c6270a45196?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=404&q=80',
    'https://images.unsplash.com/photo-1616410731309-4e07df6b5d42?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=419&q=80',
    'https://images.unsplash.com/photo-1628495359998-48e663a82b74?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=408&q=80',
    'https://images.unsplash.com/photo-1586024844218-3fb8999ef6cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
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
      ImageData(
          'https://images.unsplash.com/photo-1546514355-7fdc90ccbd03?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Ocean curent',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1543857778-c4a1a3e0b2eb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=410&q=80',
          'Todo list',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1592421816956-1c90ad73ba0b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=386&q=80',
          'Biological',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1579594124477-1bdbb77ab939?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=406&q=80',
          'Geography',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1527769929977-c341ee9f2033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Pink Flowers',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1589085278607-c12dc87ddb1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
          'Physics',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1564908296507-86814f9a4150?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Draw note',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1560211653-def0966f4537?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Randome note',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1560211653-34ace3ed0dee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Natures Gift',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1558288744-8dc4e40a7075?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Sketching ',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1604593171462-db894e54a1a6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Coloring',
          '06-June-2023'),
      ImageData(
          'https://images.unsplash.com/photo-1588421357937-c6dadca810cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80',
          'Fun note',
          '06-June-2023')
    ];
  }
}
