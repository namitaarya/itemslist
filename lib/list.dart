import 'package:flutter/material.dart';
import 'package:itemslist/data.dart';
import 'package:flutter/widgets.dart';
class ListItems extends StatefulWidget {
  final Data dataa;
  final List<List<Map>> groceries;
  const ListItems({Key? key, required this.dataa, required this.groceries}) : super(key: key);

  @override
  State<ListItems> createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {
  final myController = TextEditingController();

  void addItemToList(){
    setState(() {
      widget.groceries[widget.dataa.tabNumber].add({"name": "${myController.text}", "isChecked": false});
    });
  }

  @override
    void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
    }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Please Choose: ",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            TextField(
              controller: myController,
            ),
            ElevatedButton(
              child: Text('Add'),
            onPressed: () {
              addItemToList();
            },
            ),
            Column(
                children: widget.groceries[widget.dataa.tabNumber].map((favorite) {
              return CheckboxListTile(
                  activeColor: Colors.deepPurpleAccent,
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: favorite["isChecked"],
                  title: Text(favorite["name"]),
                  onChanged: (val) {
                    setState(() {
                      favorite["isChecked"] = val;
                    });
                  });
            }).toList()),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Wrap(
              children: widget.groceries[widget.dataa.tabNumber].map((favorite) {
                if (favorite["isChecked"] == true) {
                  return Card(
                    elevation: 3,
                    color: Colors.deepPurpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            favorite["name"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                favorite["isChecked"] = !favorite["isChecked"];
                              });
                            },
                            child: const Icon(
                              Icons.delete_forever_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              }).toList(),
            )
          ]),
        ),
      ),
    );
  }
}