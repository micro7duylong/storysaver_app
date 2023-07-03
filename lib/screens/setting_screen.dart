import 'package:com.qksoft.storysaverfacebook/models/image_modal.dart';
import 'package:com.qksoft.storysaverfacebook/screens/modal/export_modal.dart';
import 'package:com.qksoft.storysaverfacebook/widgets/device_size.dart';
import 'package:com.qksoft.storysaverfacebook/widgets/test_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isShown = true;
  bool enable = false;
  bool showListView = false;
  int _crossAxisCount = 2;
  bool _selectAll = false;
  double _aspectRatio = 0.6;
  ViewType _viewType = ViewType.grid;
  List<ImageData> itemList = ImageData.getImageDataList();
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

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
                onPressed: () {
                  ExporModal.showExportModal(context);
                },
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
                onPressed: () {
                  _showCalendarModal(context);
                },
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
                onPressed: () {
                  _delete(context);
                },
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
              _buildEnableOption(),
              CalenderWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnableOption() {
    double screenWidth = DeviceSize.width(context);
    //bool enable = true;

    return Container(
      width: screenWidth,
      margin: EdgeInsets.all(5),
      child: Row(
        children: [
          Icon(
            Icons.notifications,
            color: Colors.blue,
          ),
          Text('Enable',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )),
          Expanded(child: Container()),
          Switch(
            activeColor: Colors.blue,
            value: enable,
            onChanged: (bool value) {
              setState(() {
                enable = value;
              });
            },
          )
        ],
      ),
    );
  }

  void _delete(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Are You Sure?'),
            content: const Text(
                'Are you sure you want to delete the note? this acction cannot be undone'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    _isShown = false;
                    Navigator.of(context).pop();
                  });
                },
                isDefaultAction: true,
                isDestructiveAction: true,
                child: const Text('Yes'),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: false,
                isDestructiveAction: false,
                child: const Text('No'),
              )
            ],
          );
        });
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
                            : Icons.check_circle,
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
