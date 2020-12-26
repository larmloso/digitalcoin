import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:convert' show utf8;

import 'package:digitalcoin/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class StatsGrid2 extends StatefulWidget {
  @override
  _StatsGrid2State createState() => _StatsGrid2State();
}

class _StatsGrid2State extends State<StatsGrid2> {
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
    String str = 'hello';

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      //color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '  Popular 55',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Row(
              children: [
                _buildStatCard('$str', '756,995.29', Colors.orange),
                _buildStatCard('ETH/THB', '18,000.33', Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                _buildStatCard('XRP/THB', '9.85', Colors.green),
                _buildStatCard('ZIL/THB', '2.12', Colors.lightBlue),
                _buildStatCard('DOG/THB', '9.53', Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              count,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
