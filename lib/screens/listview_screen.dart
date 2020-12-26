import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:digitalcoin/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:digitalcoin/config/palette.dart';

class ListviewScreen extends StatefulWidget {
  @override
  _ListviewScreenState createState() => _ListviewScreenState();
}

class _ListviewScreenState extends State<ListviewScreen> {
  var groupdata = [];

  void initState() {
    super.initState();
    this.getData();
  }

  void getData() async {
    final response = await http.get('https://api.bitkub.com/api/market/ticker');
    String _body = utf8.decode(response.bodyBytes);

    setState(() {
      Map<String, dynamic> mapTickets = convert.jsonDecode(_body);
      mapTickets.forEach((key, value) {
        print(value["last"]);
        var data = {
          "key": key,
          "last": value["last"],
          "vol": value["baseVolume"]
        };
        groupdata.add(data);
        //groupdata.add(value);
      });
      //print(groupdata);
      //groupdata.map((e) => print(e.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: showListView(),
        //color: Palette.primaryColor,
        color: Colors.grey[100],
      ),
    );
  }

  ListView showListView() {
    return ListView(
      children: groupdata.map((e) {
        return Card(
          //margin: EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(
              e["key"].toString(),
              style: TextStyle(color: Colors.green),
            ),
            subtitle: Text("Vol:  " + e["vol"].toString()),
            leading: Image.asset('assets/images/THB_ABT.png'),
          ),
        );
      }).toList(),
    );
  }
}
