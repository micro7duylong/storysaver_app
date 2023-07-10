import 'package:com.qksoft.storysaverfacebook/models/image_modal.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_page/purchase_page.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_page/purchase_page_v2.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_page/purchase_page_v3.dart';
import 'package:com.qksoft.storysaverfacebook/purchase_page/example_purchase.dart';
import 'package:com.qksoft.storysaverfacebook/screens/popup/create_note_modal.dart';
import 'package:com.qksoft.storysaverfacebook/screens/setting_screen.dart';
import 'package:com.qksoft.storysaverfacebook/widgets/test_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showListView = false;
  int _crossAxisCount = 2;

  double _aspectRatio = 0.6;
  bool isSearching = false;
  bool hasResults = true;
  String searchText = '';

  ViewType _viewType = ViewType.grid;
  List<ImageData> itemList = ImageData.getImageDataList();
  List<ImageData> filteredItemList = [];

  void isListViewShown(bool value) {
    setState(() {
      showListView = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: _buildTitle(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.verified_outlined,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            onPressed: () {
              _showSetting(context);
            },
          )
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: showListView
          ? Column(children: [
              _buildMenuBar(),
              _buildListView(),
            ]
              // child: showListView ? _buildListView() : _buildEmptyBody(),
              )
          : Center(child: _buildEmptyBody()),
      floatingActionButton: _FloatingActionButton(context),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Notebook",
      style: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildMenuBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            //   width: 3.0,
          ),
        ),
      ),
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(
              _viewType == ViewType.list
                  ? Icons.border_all_rounded
                  : Icons.list,
              color: Colors.white,
            ),
            onPressed: () {
              if (_viewType == ViewType.list) {
                _crossAxisCount = 2;
                _aspectRatio = 0.6;
                _viewType = ViewType.grid;
              } else {
                _crossAxisCount = 1;
                _aspectRatio = (1 / .4);
                _viewType = ViewType.list;
              }
              setState(() {});
            },
          ),
          Expanded(
            child: isSearching
                ? Container(
                    margin: EdgeInsets.all(5),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                          filteredItemList = itemList.where((imageData) {
                            return imageData.title
                                .toLowerCase()
                                .contains(searchText.toLowerCase());
                          }).toList();
                        });
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                      ),
                    ),
                  )
                : Container(),
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.calendar_month,
              color: Colors.blue,
            ),
            onPressed: () {
              _showCalendarModal(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCalendarModal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Reminder'),
          ),
          body: Column(
            children: [
              CalenderWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _showSetting(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(
          barBackgroundColor: Colors.grey[700],
          textTheme: CupertinoTextThemeData(primaryColor: Colors.white),
        ),
        child: CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.notifications_none_outlined),
                    Text('Reminder'),
                    Spacer(),
                    Text('None'),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PurchasePageExam()));
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.workspace_premium_outlined),
                    const Text('Get Premium'),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.edit),
                    const Text('Rename'),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.copy),
                    const Text('Duplicate'),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.import_export),
                    const Text('Export'),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.delete_forever),
                    const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: GridView.count(
            crossAxisCount: _crossAxisCount,
            childAspectRatio: _aspectRatio,
            children: isSearching
                ? filteredItemList.length > 0
                    ? filteredItemList.map((ImageData imageData) {
                        return getGridItem(imageData);
                      }).toList()
                    : [Text('No results is found')]
                : itemList.map((ImageData imageData) {
                    return getGridItem(imageData);
                  }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/images/homenote_img.png'),
          height: 150,
          width: 150,
        ),
        Text(
          "The Library is empty",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
        )
      ],
    );
  }

  Widget _FloatingActionButton(BuildContext context) {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          setState(() {
            showListView = !showListView;
          });
          CreateNoteModal.showCreateNote(context);
        },
        child: Image(
          image: AssetImage('assets/images/notebook_logo.png'),
          height: 30,
          width: 30,
        ),
      ),
    );
  }

  GridTile getGridItem(ImageData imageData) {
    return GridTile(
      child: (_viewType == ViewType.list)
          ? GestureDetector(
              onTap: () {
                // Handle item tap event
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 100,
                          height: 150,
                          child: Image.asset(
                            imageData.path,
                            fit: BoxFit.cover,
                          ),
                          // child: Image.network(
                          //   fit: BoxFit.cover,
                          //   imageData.path,
                          // ),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          imageData.title,
                          style:
                              const TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                        Text(
                          imageData.date,
                          style:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue,
                        )),
                    IconButton(
                      icon: Icon(
                        imageData.isFavorite
                            ? Icons.favorite_outlined
                            : Icons.favorite,
                        color: imageData.isFavorite ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          imageData.isFavorite = !imageData.isFavorite;
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          : Container(
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 150,
                              // child: Image.network(
                              //   imageData.path,
                              //   fit: BoxFit.cover,
                              // ),
                              child: Image.asset(
                                imageData.path,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                icon: Icon(
                                  imageData.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite,
                                  color: imageData.isFavorite
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    imageData.isFavorite =
                                        !imageData.isFavorite;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          imageData.title,
                          style:
                              const TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    Text(
                      imageData.date,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

enum ViewType { grid, list }
