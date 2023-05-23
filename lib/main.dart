import 'package:flutter/material.dart';
import 'package:itemslist/data.dart';
import 'package:itemslist/finallist.dart';
import 'package:itemslist/list.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  ScreenshotController screenshotController = ScreenshotController();
  List<List<Map>> groceries = [
    [
      {"name": "Corn", "isChecked": false},
      {"name": "Coco powder ", "isChecked": false},
      {"name": "Paneer ", "isChecked": false},
      {"name": "Chaap ", "isChecked": false},
      {"name": "Khaand ", "isChecked": false},
      {"name": "Peele matar ", "isChecked": false},
    ],
    [
      {"name": "Rajma ", "isChecked": false},
    {"name": "Chhole", "isChecked": false},
    {"name": "Kaale chhole", "isChecked": false},
    {"name": "Moong saabut", "isChecked": false},
    {"name": "Moong dhuli ", "isChecked": false},
    {"name": "Moong chhilka ", "isChecked": false},
    {"name": "Urad sabat ", "isChecked": false},
    {"name": "Urad chilkaa  ", "isChecked": false},
    {"name": "Urad dhuli ", "isChecked": false},
    {"name": "Chane ki daal", "isChecked": false},
    {"name": "Arhar ki daal", "isChecked": false},
    {"name": "Month ", "isChecked": false},
    {"name": "Matar ", "isChecked": false},
    {"name": "Masar ki daal", "isChecked": false},
  ],
  [
    {"name": "Namak", "isChecked": false},
    {"name": "Laal mirch", "isChecked": false},
    {"name": "Haldi", "isChecked": false},
    {"name": "Sookha dhaniya", "isChecked": false},
    {"name": "Kaala namak", "isChecked": false},
    {"name": "Kaali mirch ", "isChecked": false},
    {"name": "Jira", "isChecked": false},
    {"name": "Rice", "isChecked": false},
    {"name": "Mustard seeds ", "isChecked": false},
    {"name": " Garam masala ", "isChecked": false},
    {"name": "Aamchoor ", "isChecked": false},
    {"name": " Anaar daana ", "isChecked": false},
    {"name": "Sonf", "isChecked": false},
    {"name": "Ajvain", "isChecked": false},
    {"name": "Chhoti ilaichi ", "isChecked": false},
    {"name": "Moti ilaichi", "isChecked": false},
    {"name": "Heeng", "isChecked": false},
    {"name": "Tez patta ", "isChecked": false},
    {"name": "Degi mirch", "isChecked": false},
    {"name": "Chaat masala", "isChecked": false},
    {"name": "Paav bhaaji masala", "isChecked": false},
    {"name": "Chhole masala", "isChecked": false},
    {"name": "Shahi paneer masala", "isChecked": false},
    {"name": "Kitchen King", "isChecked": false},

  ],
  [
    {"name": "Sooji", "isChecked": false},
    {"name": "Maida", "isChecked": false},
    {"name": "Idli mix", "isChecked": false},
    {"name": "Poha", "isChecked": false},
    {"name": "Pasta", "isChecked": false},
    {"name": "Bambino ", "isChecked": false},
    {"name": "Cheese slice", "isChecked": false},
    {"name": "Cheese", "isChecked": false},
    {"name": "Oregano", "isChecked": false},
    {"name": "Chilli flakes", "isChecked": false},
    {"name": "Chilli sauce", "isChecked": false},
    {"name": "Soya sauce", "isChecked": false},
    {"name": "Vinegar", "isChecked": false},
    {"name": "Baking soda", "isChecked": false},
    {"name": "Baking powder", "isChecked": false},
    {"name": "Diced cheese", "isChecked": false},
    {"name": "Frozen corn", "isChecked": false},
    {"name": "Frozen matar", "isChecked": false},
    {"name": "Soya chaap", "isChecked": false},
  ],
  [{"name": "Shampoo ", "isChecked": false},
  {"name": "Conditioner ", "isChecked": false},
  {"name": "Soap ", "isChecked": false},
  {"name": "Lizole ", "isChecked": false},
  {"name": "Harpik ", "isChecked": false},
  {"name": "Colin ", "isChecked": false},
  {"name": "Vim Bar ", "isChecked": false},
  {"name": "Shaving gel ", "isChecked": false},
  {"name": "Shaving foam ", "isChecked": false},
  {"name": "Razor ", "isChecked": false},
  {"name": "Toothpaste ", "isChecked": false},
  {"name": "Toothbrush ", "isChecked": false},

  ]
  ];

  int currentPageIndex = 0;
  late File _imageFile;

  @override
  Widget build(BuildContext context) {

      _takeScreenshotandShare() async {
    screenshotController
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((File image) async {
      setState(() {
        _imageFile = image;
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('Items', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Items'),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.bookmark_border),
              label: '1',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border),
              label: '2',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: '3',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: '4',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: '5',
            ),
                      NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark_border),
              label: '6',
            ),
          ],
        ),
        body: <Widget>[
          
          Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: ListItems(dataa: Data(tabNumber: currentPageIndex), groceries: groceries),
          ),
          Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: ListItems(dataa: Data(tabNumber: currentPageIndex),groceries: groceries),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: ListItems(dataa: Data(tabNumber: currentPageIndex),groceries: groceries),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: ListItems(dataa: Data(tabNumber: currentPageIndex),groceries: groceries),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: ListItems(dataa: Data(tabNumber: currentPageIndex),groceries: groceries),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: FinalList(groceries: groceries),
          ),
        ][currentPageIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _takeScreenshotandShare();
          },
          tooltip: 'Increment',
          child: Icon(Icons.share),
        ),
      ),
    );
  }
}


