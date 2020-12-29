import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter/ui/itemList.dart';
import '../services/item.dart';
import '../services/message.dart';
import '../model/item.dart';

class Datalist extends StatefulWidget {
  static const id = 'datalist';

  @override
  _DatalistState createState() => _DatalistState();
}

class _DatalistState extends State<Datalist> {
  List<ItemModel> _items = [];
  List<ItemModel> _searchedItems = [];
  final TextEditingController _searchText = TextEditingController();
  bool hasFiltered = false;

  @override
  void initState() {
    ItemService.getItems().then((res) {
      if (res['message'] != null) {
        FlashMessage.errorFlash(res['message']);
      } else {
        res['items'].forEach((item) {
          setState(() {
            _items.add(ItemModel.fromJson(item));
          });
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  _search() async {
    _searchedItems = [];
    if (_searchText.text != null || _searchText.text.trim() != '')
      await ItemService.searchItems(_searchText.text.trim()).then((res) {
        if (res['message'] != null) {
          FlashMessage.errorFlash(res['message']);
        } else {
          setState(() {
            hasFiltered = true;
          });
          res['items'].forEach((item) {
            setState(() {
              _searchedItems.add(ItemModel.fromJson(item));
            });
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: CupertinoTextField(
                        placeholder: "Search",
                        keyboardType: TextInputType.text,
                        clearButtonMode: OverlayVisibilityMode.editing,
                        autocorrect: false,
                        controller: _searchText,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _search,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              hasFiltered
                  ? ItemList(_searchedItems, _searchedItems.length)
                  : ItemList(_items, _items.length),
            ],
          ),
          FlatButton(
            onPressed: (){
              setState(() {
                _searchedItems.clear();
                hasFiltered = false; 
                _searchText.text = ''; 
              });
            },
            color: Colors.red,
            child: Text('Clear Filter'),
          ),
        ],
      ),
    );
  }
}
