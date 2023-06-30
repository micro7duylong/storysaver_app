import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storysaver_app/models/image_modal.dart';

class ManageNote extends StatefulWidget {
  @override
  State<ManageNote> createState() => _ManageNoteState();

  static void showManageTest(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.96,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              children: [
                ManageNote(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ManageNoteState extends State<ManageNote> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: [
        _buildTopMenuBar(context),
        Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildBody(),
              ],
            )),
      ],
    ));
  }

  Widget _buildTopMenuBar(context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ),
              Center(
                child: Row(children: [
                  ButtonBar(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.border_all_rounded,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border_outlined,
                            color: Colors.white,
                          ))
                    ],
                  )
                ]),
              ),
              SizedBox(
                  width:
                      48), // Add spacing between the tabs and the end of the row
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuNote() {
    PageModal pageModal = PageModal();

    return Column(
      children: [
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                margin: EdgeInsets.all(8),
                // child: Image.network(
                //   pageModal.fetchedPageData[index],
                //   fit: BoxFit.cover,
                // ),
                child: Image.asset(
                  pageModal.fetchedPageData[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddImage() {
    return Container(
      width: 100,
      height: 140,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.blue,
            size: 48.0,
          ),
          onPressed: () {
            _showManagePageSheet(context);
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        child: Row(
      children: [
        Expanded(child: _buildMenuNote()),
        _buildAddImage(),
      ],
    ));
  }

  void _showManagePageSheet(BuildContext context) {
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
                    Icon(Icons.image),
                    const Text('Add page before'),
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
                    Icon(Icons.image),
                    const Text('Add page after'),
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
