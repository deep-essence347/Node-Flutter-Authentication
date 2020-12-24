import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:node_flutter/services/item.dart';
import 'package:node_flutter/services/message.dart';
import 'package:node_flutter/ui/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemForm extends StatefulWidget {
  static const id = 'Form';
  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final TextEditingController _item = TextEditingController();
  final TextEditingController _price = TextEditingController(text: '0');

  @override
  void dispose() {
    _item.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: "Item",
                keyboardType: TextInputType.text,
                clearButtonMode: OverlayVisibilityMode.editing,
                autocorrect: false,
                controller: _item,
              ),
              SizedBox(height: 5),
              Container(
                width: 100,
                child: CupertinoTextField(
                  placeholder: "Price",
                  keyboardType: TextInputType.number,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                  controller: _price,
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                onPressed: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  if (_price.text.trim() == '') {
                    FlashMessage.errorFlash('Invalid Price');
                  } else {
                    await ItemService.addItem(_item.text,
                            int.parse(_price.text), _prefs.getString('userId'))
                        .then((res) {
                      if (res['isSuccess']) {
                        Navigator.pushNamed(context, HomePage.id);
                        FlashMessage.successFlash(res['message']);
                      } else {
                        FlashMessage.errorFlash(res['message']);
                      }
                    });
                  }
                },
                child: Text('Add Item'),
                color: Colors.indigoAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
