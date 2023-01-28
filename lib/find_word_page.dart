// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:word_search/trie.dart';

class FindWordPage extends StatefulWidget {
  final List<TextField?> gridcara;
  final int colnumber;
  const FindWordPage(
      {Key? key, required this.gridcara, required this.colnumber})
      : super(key: key);
  @override
  String toTextField() {
    return '${gridcara.toString()}';
  }

  // => gridcara.toString();
  @override
  _FindWordPageState createState() => _FindWordPageState();
}

class _FindWordPageState extends State<FindWordPage> {
  bool match = false;
  TextEditingController wordcontroller = TextEditingController();
  late List<TextField?> _options;
  //= <TextField?>[widget.gridcara[0]];

  late List<List<String?>> wrdgrd;

  final trie = Trie();
  late List<String> sword;

  @override
  void initState() {
    sword = widget.gridcara.cast<String>().toList();
    // TODO: implement initState
    for (int ind = 0; ind < widget.gridcara.length; ind++) {
      _options = <TextField?>[widget.gridcara[ind]];
      print("option..$_options");
    }
    for (final option in _options) {
      trie.insert(wordcontroller.text);
    }
    super.initState();

    wrdgrd = List.generate(
        int.tryParse(widget.gridcara.length.toString())!,
        (i) => List.filled(int.tryParse(widget.colnumber.toString())!, "a",
            growable: true),
        growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "FIND WORD",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          //alignment: Alignment.,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 400,
                //color: Colors.yellow,
                child: GridView.builder(
                    itemCount: widget.gridcara.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.colnumber,
                        childAspectRatio: .8,
                        crossAxisSpacing: 23,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 40,
                        color:
                            match == false ? Colors.black12 : Colors.blueAccent,
                        child: Center(child: widget.gridcara[index]),
                      );
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                controller: wordcontroller,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    hintText: "Enter word"
                    //labelText: 'Enter word',
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int r = 0;

                      for (int p = 0;
                          p <
                              (int.parse(widget.gridcara.length.toString()) /
                                  (int.parse(widget.colnumber.toString())));
                          p++) {
                        if (r >
                            (int.parse(widget.gridcara.length.toString()))) {
                          return;
                        }

                        for (int q = 0;
                            q < (int.parse(widget.colnumber.toString()));
                            q++) {
                          wrdgrd[p][q] =
                              widget.gridcara[r]?.controller?.text.toString();
                          print("${wrdgrd[p][q]}");
                          r++;
                        }
                      }
                      print("Word Grid Char=${wrdgrd[2][1]}");
                      trie.insert(wordcontroller.text);

                      print(trie.has('het'));
                    });
                  },
                  child: Text(
                    "SEARCH",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ));
  }

//   Widget search() {
//     return Autocomplete(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         return _findCompletions(textEditingValue.text.toLowerCase());
//       },
//       // displayStringForOption: _displayStringForOption,
//       onSelected: (selection) {
//         debugPrint('You selected $selection');
//       },
//     );
//   }
//   //static String _displayStringForOption( sword.toString() option) => option.name;
//
//   Iterable _findCompletions(String query) => trie.find(query);
}
