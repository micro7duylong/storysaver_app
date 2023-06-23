import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popover/popover.dart';
import 'package:storysaver_app/models/image_modal.dart';
import 'package:storysaver_app/screens/modal/create_note_modal.dart';
import 'package:storysaver_app/screens/modal/manage_note_modal.dart';
import 'package:storysaver_app/widgets/device_size.dart';

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final pageModal = PageModal();

  final coverModal = CoverModal();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[800],
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                // Handle button 1 press
              },
            ),
            IconButton(
              icon: Icon(
                Icons.border_all_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                ManageNote.showManageTest(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                _showAddPageSheet(context);
              },
            ),
            Expanded(
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _showPopoverMenu(context);
                  },
                ),
              ),
            )
          ],
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.turn_left,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle button 4 press
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.turn_right,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle button 5 press
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle button 6 press
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
        color: Colors.grey[300],
        child: Expanded(child: _buildBody()),
      ),
    );
  }

  void _showPopoverMenu(BuildContext context) {
    showPopover(
      context: context,
      bodyBuilder: (context) {
        return ListItems();
      },
      onPop: () => print('Popover was popped!'),
      direction: PopoverDirection.top,
      width: 200,
      height: 400,
      arrowHeight: 15,
      arrowWidth: 30,
    );
  }

  Widget _buildCover(context) {
    double screenWidth = DeviceSize.width(context);
    double screenHeight = DeviceSize.height(context);
    String imageUrl =
        coverModal.fetchedCoverData[1]; // Lấy hình ảnh tại index thứ 2
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: screenHeight,
      width: screenWidth,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPagetest(context) {
    double screenWidth = DeviceSize.width(context);
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: pageModal.fetchedPageData.length,
        itemBuilder: (context, index) {
          final imageUrl = pageModal.fetchedPageData[index];
          return ListTile(
            title: Container(
              width: screenWidth,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(children: [
        _buildCover(context),
        _buildPagetest(context),
      ]),
    );
  }

  void _showAddPageSheet(BuildContext context) {
    int selectedTab = 0; // Default selected tab is 0

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoTheme(
        data: CupertinoThemeData(
          barBackgroundColor: Colors.grey[700],
          textTheme: CupertinoTextThemeData(primaryColor: Colors.white),
        ),
        child: CupertinoActionSheet(
          title: const Text(
            'Add Page',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () {},
              child: Container(
                child: CupertinoSegmentedControl(
                  children: {
                    0: Text(
                      'Before',
                      style: TextStyle(fontSize: 16),
                    ),
                    1: Text(
                      'After',
                      style: TextStyle(fontSize: 16),
                    ),
                    2: Text(
                      'Last',
                      style: TextStyle(fontSize: 16),
                    ),
                  },
                  onValueChanged: (value) {
                    setState(() {
                      selectedTab = value;
                    });
                  },
                  groupValue: selectedTab,
                ),
              ),
            ),
            CupertinoActionSheetAction(
                onPressed: () {}, child: PageListWidget()),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.image),
                    const Text('Image'),
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
                    Icon(Icons.photo_camera),
                    const Text('Take Photo'),
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
                    const Text('Import'),
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
            child: const Text('Cancel'),
          ),
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
                print('GestureDetector was called on Entry A');
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
          ],
        ),
      ),
    );
  }
}