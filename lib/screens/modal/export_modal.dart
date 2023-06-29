import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storysaver_app/screens/note_screen.dart';
import 'package:storysaver_app/widgets/device_size.dart';

class ExporModal extends StatefulWidget {
  @override
  State<ExporModal> createState() => _ExporModalState();
  static void showExportModal(BuildContext context) {
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
                ExporModal(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ExporModalState extends State<ExporModal> {
  List<String> dropdownValues = [
    'Flattened',
    'Editable',
  ];
  String selectedValue = '';
  List<bool> isTypeSelected = [true, false, false];
  

  @override
  void initState() {
    super.initState();
    selectedValue = dropdownValues.first;
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
                _buildTypeSelection(),
                SizedBox(
                  height: 10,
                ),
                _buildFileNameInput(),
                SizedBox(
                  height: 10,
                ),
                _buildOption(),
                SizedBox(
                  height: 10,
                ),
                _buildDataFormat()
              ],
            )),
      ],
    ));
  }

  

  Widget _buildTopMenuBar(
    context,
  ) {
    return Container(
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
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Export Documents',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotesScreen()));
                },
                child: Text(
                  'Export',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelection() {
    double screenWidth = DeviceSize.width(context);
    double screenHeight = DeviceSize.height(context);
    return Container(
      margin: EdgeInsets.all(2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: screenHeight * 0.1,
              width: screenWidth * 0.27,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text('PDF'),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Icon((Icons.picture_as_pdf_outlined)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isTypeSelected[0] ? Icons.check_circle : Icons.circle,
                color: isTypeSelected[0] ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isTypeSelected = [true, false, false];
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: screenHeight * 0.1,
              width: screenWidth * 0.27,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text('PDF'),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Icon((Icons.image)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isTypeSelected[1] ? Icons.check_circle : Icons.circle,
                color: isTypeSelected[1] ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isTypeSelected = [false, true, false];
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: screenHeight * 0.1,
              width: screenWidth * 0.27,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text('PDF'),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Icon((Icons.note_alt)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isTypeSelected[2] ? Icons.check_circle : Icons.circle,
                color: isTypeSelected[2] ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isTypeSelected = [false, false, true];
                });
              },
            ),
          ],
        )
      ]),
    );
  }

  Widget _buildFileNameInput() {
    double screenWidth = DeviceSize.width(context);
    return Container(
      width: screenWidth,
      //margin: EdgeInsets.all(5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('FILENAME',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
        SizedBox(
          height: 5,
        ),
        Container(
          color: Colors.grey[800],
          child: TextFormField(
            decoration: new InputDecoration.collapsed(
              hintText: 'Name',
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildOption() {
    double screenWidth = DeviceSize.width(context);
    bool light = true;

    return Container(
      width: screenWidth,
      margin: EdgeInsets.all(5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('OPTION',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
        Row(
          children: [
            Text('Include Page Background',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            Expanded(child: Container()),
            Switch(
              activeColor: Colors.green,
              value: light,
              onChanged: (bool value) {
                setState(() {
                  light = value;
                });
              },
            )
          ],
        ),
      ]),
    );
  }

  Widget _buildDataFormat() {
    double screenWidth = DeviceSize.width(context);
    return Container(
      width: screenWidth,
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OPTION',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                'Include Page Background',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: Container()),
              DropdownButton<String>(
                value: selectedValue,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: dropdownValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
