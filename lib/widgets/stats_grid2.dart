import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;

class StatsGrid2 extends StatefulWidget {
  @override
  _StatsGrid2State createState() => _StatsGrid2State();
}

class _StatsGrid2State extends State<StatsGrid2> {
  var groupdata = [];
  var grouptopdata = [];
  var populardata = [];
  var topgainer = [];

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
        var data = {
          "key": key,
          "last": value["last"],
          "vol": value["baseVolume"],
          "percentChange": value["percentChange"]
        };
        groupdata.add(data);
        // grouptopdata.add(data);
      });
      groupdata.sort((a, b) => (b["last"]).compareTo(a["last"]));
      // grouptopdata.sort((a, b) => (b["percentChange"]).compareTo(a["percentChange"]));

      groupdata.forEach((element) {
        var newData = {"key": element["key"], "last": element["last"]};
        populardata.add(newData);
      });
      // grouptopdata.forEach((element) {
      //   var newData = {"key": element["key"], "per": element["percentChange"]};
      //   topgainer.add(newData);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('1');
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            '  Popular',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Row(
              children: [
                _buildStatCard(populardata[0]["key"],
                    populardata[0]["last"].toString(), Colors.orange),
                _buildStatCard(populardata[1]["key"],
                    populardata[1]["last"].toString(), Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                _buildStatCard(populardata[2]["key"].toString(),
                    populardata[2]["last"].toString(), Colors.green),
                _buildStatCard(populardata[3]["key"].toString(),
                    populardata[3]["last"].toString(), Colors.lightBlue),
                _buildStatCard(populardata[4]["key"].toString(),
                    populardata[4]["last"].toString(), Colors.purple),
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
            Text(
              " ≈ 1",
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
