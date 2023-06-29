import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storysaver_app/models/image_modal.dart';
import 'package:storysaver_app/screens/home_screen.dart';
import 'package:storysaver_app/screens/modal/manage_note_modal.dart';
import 'package:storysaver_app/screens/note_screen.dart';
import 'package:storysaver_app/widgets/device_size.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool showListView = false;
  int _crossAxisCount = 2;
  bool _selectAll = false;
  double _aspectRatio = 0.6;
  ViewType _viewType = ViewType.grid;
  List<ImageData> itemList = ImageData.getImageDataList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        title: Center(child: Text('Notebook')),
        leading: TextButton(
            onPressed: () {
              setState(() {
                _selectAll = !_selectAll;
                itemList.forEach((imageData) {
                  imageData.isFavorite = _selectAll;
                });
              });
            },
            child: Text(
              _selectAll ? 'Deselect all' : 'Select all',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            )),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Done',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              )),
        ],
      ),
      body: Column(
        children: [
          _buildMenubar(),
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildMenubar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.import_export),
                color: Colors.blue,
              ),
              Text(
                "Export",
                style: TextStyle(color: Colors.blue, fontSize: 12),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.copy,
                ),
                color: Colors.blue,
              ),
              Text(
                "Duplicate",
                style: TextStyle(color: Colors.blue, fontSize: 12),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none_outlined),
                color: Colors.blue,
              ),
              Text(
                "Reminder",
                style: TextStyle(color: Colors.blue, fontSize: 12),
              )
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_forever_outlined),
                color: Colors.red,
              ),
              Text(
                "Delete",
                style: TextStyle(color: Colors.red, fontSize: 12),
              )
            ],
          )
        ],
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
            children: itemList.map((ImageData imageData) {
              return getGridItem(imageData, _selectAll);
            }).toList(),
          ),
        ),
      ),
    );
  }

  GridTile getGridItem(ImageData imageData, bool selectAll) {
    return GridTile(
      child: (_viewType == ViewType.list)
          ? GestureDetector(
              onTap: () {
                // Handle item tap event
              },
              child: Container(
                // margin: const EdgeInsets.only(top: 5, bottom: 10),
                margin: const EdgeInsets.all(5),
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
                            ? Icons.circle_rounded
                            : Icons.circle_rounded,
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
                              left: 5,
                              child: IconButton(
                                icon: Icon(
                                  imageData.isFavorite
                                      ? Icons.circle_rounded
                                      : Icons.circle_rounded,
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
