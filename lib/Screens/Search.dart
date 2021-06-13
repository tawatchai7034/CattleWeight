import 'dart:html';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: การทำงานเมื่อกด Search icon
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  late String selectResult;
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      child: Center(child: Text(selectResult)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: แสดงการทำงานตาม function ต่อไปนี้
    throw UnimplementedError();
  }
}
