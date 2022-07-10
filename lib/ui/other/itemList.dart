import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/item.dart';

class ItemList extends StatelessWidget {
  ItemList(this.items, this.length);
  final List<ItemModel> items;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
      child: length > 0
          ? ListView.builder(
              itemCount: length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(items[index].name),
                          Text(items[index].price.toString()),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                      height: 1.5,
                      thickness: 1.0,
                    )
                  ],
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            ),
    );
  }
}
