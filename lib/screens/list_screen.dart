import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:digitalcoin/config/palette.dart';
import 'package:digitalcoin/config/styles.dart';
import 'package:digitalcoin/widgets/widgets.dart';

import '../dto/symbol.dart';
import '../services/bitkub_service.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Future fetchCoins() async {
    print('fetchCoins');
    return await BitkubService().getSymbols();
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   fetchCoins().then((value) => value.forEach((e) {
          
    //       }));
    // });

    //tickers.forEach((element) { print(element.baseVolume);});
    print(fetchCoins().toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: fetchCoins(),
        builder: (BuildContext contex, AsyncSnapshot tickerSnap) {
          switch (tickerSnap.connectionState) {
            case ConnectionState.none:
              return new Text('Input a URL to start');
              break;
            case ConnectionState.waiting:
              return new Center(child: new CircularProgressIndicator());
              break;
            case ConnectionState.active:
              return new Text('');
              break;
            case ConnectionState.done:
              if (tickerSnap.hasError) {
                return new Text(
                  '${tickerSnap.error}',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return ListView.builder(
                    itemCount:
                        (tickerSnap.data == null) ? 0 : tickerSnap.data.length,
                    itemBuilder: (contex, index) {
                      Ticker ticker = tickerSnap.data[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(ticker.key),
                            subtitle: Text(ticker.last.toString()),
                          ),
                        ],
                      );
                    });
              }
              break;
            default:
              return Container();
          }
        },
      ),
    );
  }
}
