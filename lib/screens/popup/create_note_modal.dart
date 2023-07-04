import 'package:com.qksoft.storysaverfacebook/models/image_modal.dart';
import 'package:com.qksoft.storysaverfacebook/screens/popup/manage_note_modal.dart';
import 'package:com.qksoft.storysaverfacebook/screens/note_screen.dart';
import 'package:com.qksoft.storysaverfacebook/widgets/device_size.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class CreateNoteModal extends StatefulWidget {
  @override
  State<CreateNoteModal> createState() => _CreateNoteModalState();
  static void showCreateNote(BuildContext context) {
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
                CreateNoteModal(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CreateNoteModalState extends State<CreateNoteModal> {
  late String dropdownValue;

  SizeModal sizeModal = SizeModal();

  List<bool> isColorSelected = [true, false, false, false, false];

  @override
  void initState() {
    super.initState();
    dropdownValue = sizeModal.listsize.first;
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
                _buildNameTextField(),
                _buildSizeDropDownList(),
                _buildCoverLabel(),
                CoverListWidget(),
                _buildPageLabel(),
                PageListWidget(),
                _buildThemeColorPick()
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
                  'New Notebook',
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
                  'Create',
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

  void showCreateNote(context) {
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

  Widget _buildNameTextField() {
    return Container(
      decoration: BoxDecoration(),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Untitled Notebook',
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
        ),
        onSaved: (newValue) {
          // code when the user saves the form
        },
        // autofocus: true,
      ),
    );
  }

  Widget _buildSizeDropDownList() {
    double screenWidth = DeviceSize.width(context);
    // //double screenHeight = DeviceSize.height(context);
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('SIZE',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              )),
          Container(
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                value: dropdownValue,
                underline: Container(),
                icon: Container(
                    margin: EdgeInsets.only(left: 8),
                    child: const Icon(Icons.arrow_drop_down)),
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: sizeModal.listsize
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverLabel() {
    return Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('COVER',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ));
  }

  Widget _buildPageLabel() {
    return Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('PAGE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ));
  }

  Widget _buildThemeColorPick() {
    return Container(
        margin: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isColorSelected = [
                    true,
                    false,
                    false,
                    false,
                    false
                  ]; // Cập nhật trạng thái chọn
                });
              },
              child: Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isColorSelected[0] ? Colors.blue : Colors.transparent,
                      width: isColorSelected[0] ? 2.0 : 0.0,
                    ),
                    color: Colors.amber[50],
                    shape: BoxShape.circle),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isColorSelected = [
                    false,
                    true,
                    false,
                    false,
                    false
                  ]; // Cập nhật trạng thái chọn
                });
              },
              child: Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isColorSelected[1] ? Colors.blue : Colors.transparent,
                      width: isColorSelected[1] ? 2.0 : 0.0,
                    ),
                    color: Colors.amber[50],
                    shape: BoxShape.circle),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isColorSelected = [
                    false,
                    false,
                    true,
                    false,
                    false
                  ]; // Cập nhật trạng thái chọn
                });
              },
              child: Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isColorSelected[2] ? Colors.blue : Colors.transparent,
                      width: isColorSelected[2] ? 2.0 : 0.0,
                    ),
                    color: Colors.green[50],
                    shape: BoxShape.circle),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isColorSelected = [
                    false,
                    false,
                    false,
                    true,
                    false
                  ]; // Cập nhật trạng thái chọn
                });
              },
              child: Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isColorSelected[3] ? Colors.blue : Colors.transparent,
                      width: isColorSelected[3] ? 2.0 : 0.0,
                    ),
                    color: Colors.grey[50],
                    shape: BoxShape.circle),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isColorSelected = [
                    false,
                    false,
                    false,
                    false,
                    true
                  ]; // Cập nhật trạng thái chọn
                });
              },
              child: Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          isColorSelected[4] ? Colors.blue : Colors.transparent,
                      width: isColorSelected[4] ? 2.0 : 0.0,
                    ),
                    color: Colors.black,
                    shape: BoxShape.circle),
              ),
            ),
          ],
        ));
  }
}

class CoverListWidget extends StatefulWidget {
  @override
  _CoverListWidgetState createState() => _CoverListWidgetState();
}

class _CoverListWidgetState extends State<CoverListWidget> {
  CoverModal coverModal = CoverModal();

  SizeModal sizeModal = SizeModal();

  List<String> imageUrlsCover = [];

  bool isCoverLoading = true;

  int selectedCoverIndex = -1;
  @override
  void initState() {
    super.initState();
    fetchData(); // Call a method to fetch image data
  }

  void fetchData() {
    // Simulating fetching image data from a network or API
    // Replace this code with actual data fetching logic
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        imageUrlsCover = coverModal.fetchedCoverData;
        isCoverLoading = false;
        // Turn off loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isCoverLoading
        ? Container(
            margin: EdgeInsets.only(top: 16),
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                      //  color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.all(5),
                            child: Icon(Icons.image, size: 70)),
                        SizedBox(height: 10),
                        Text(
                          coverModal.coverTitles[index],
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            //color: Colors.amber,
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrlsCover.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrlsCover[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCoverIndex = index; // Cập nhật trạng thái chọn
                    });
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedCoverIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                        width: selectedCoverIndex == index ? 2.0 : 0.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 120,
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                          // child: Image.network(
                          //   imageUrl,
                          //   fit: BoxFit.cover,
                          //),
                        ),
                        // SizedBox(height: 10),
                        Text(
                          coverModal.coverTitles[index],
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}

class PageListWidget extends StatefulWidget {
  @override
  _PageListWidgetState createState() => _PageListWidgetState();
}

class _PageListWidgetState extends State<PageListWidget> {
  PageModal pageModal = PageModal();
  bool isPageLoading = true;
  int selectedPageIndex = -1;
  List<String> imageUrlsPage = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        imageUrlsPage = pageModal.fetchedPageData;

        isPageLoading = false; // Turn off loading state
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? Container(
            margin: EdgeInsets.only(top: 16),
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.all(5),
                            child: Icon(Icons.image, size: 50)),
                        SizedBox(height: 10),
                        Text(
                          pageModal.pageTitles[index],
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrlsPage.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrlsPage[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPageIndex = index;
                    });
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedPageIndex == index
                            ? Colors.blue
                            : Colors.transparent,
                        width: selectedPageIndex == index ? 2.0 : 0.0,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(),
                          height: 110,
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                          // child: Image.network(
                          //   imageUrl,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        //  SizedBox(height: 5),
                        Text(
                          pageModal.pageTitles[index],
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
