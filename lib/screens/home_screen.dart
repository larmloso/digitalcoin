import 'package:flutter/material.dart';
import 'package:digitalcoin/config/palette.dart';
import 'package:digitalcoin/config/styles.dart';
import 'package:digitalcoin/widgets/widgets.dart';
import 'package:digitalcoin/data/data.dart';

import 'dart:convert' as convert;
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        grouptopdata.add(data);
      });
      groupdata.sort((a, b) => (b["last"]).compareTo(a["last"]));
      grouptopdata
          .sort((a, b) => (b["percentChange"]).compareTo(a["percentChange"]));

      groupdata.forEach((element) {
        var newData = {"key": element["key"], "last": element["last"]};
        populardata.add(newData);
      });
      grouptopdata.forEach((element) {
        var newData = {"key": element["key"], "per": element["percentChange"]};
        if (topgainer.length < 3) {
          topgainer.add(newData);
        }
      });
    });

    print(topgainer);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(screenHeight),
          _buildPreventionTips(screenHeight, topgainer),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            sliver: SliverToBoxAdapter(
              child: StatsGrid2(),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 20.0,
          ),
          padding: const EdgeInsets.all(10.0),
          height: screenHeight * 0.2,
          child: Row(
            children: [
              Image.network(
                  'https://www.pngarts.com/files/3/Bitcoin-PNG-Pic.png',
                  height: screenHeight * 0.14)
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight, List topgainer) {
    //print(topgainer);
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        //margin: EdgeInsets.all(10.0),
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Gainer',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: topgainer.map((e) {
                return Column(
                  children: [
                    Image.network(
                      'https://cdn.pixabay.com/photo/2019/12/31/18/53/chart-4732546_960_720.png',
                      height: screenHeight * 0.12,
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    ///Icon(Icons.money_off_csred_outlined),
                    Text(
                      e["key"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      e["per"].toString() + " %",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
