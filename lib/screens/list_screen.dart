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

    bool isFavorited = true;
  int favoriteCount = 41;

  void _handleTap() {
    setState(() {
      isFavorited = !isFavorited;
      if (isFavorited) {
        favoriteCount += 1;
      } else {
        favoriteCount -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    padding: EdgeInsets.all(10.0),
                    itemCount:
                        (tickerSnap.data == null) ? 0 : tickerSnap.data.length,
                    itemBuilder: (contex, index) {
                      //print(tickerSnap);
                      Ticker ticker = tickerSnap.data[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            foregroundColor: Colors.green,
                            backgroundImage: NetworkImage(
                                'https://bitcoin.org/img/icons/opengraph.png?1608131429'),
                          ),
                          title: Text(
                            ticker.key,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            ticker.last.toString() + " = 1",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.green,
                            ),
                          ),
                          trailing: IconButton(
                            alignment: Alignment.centerRight,
                            icon: (isFavorited
                                ? Icon(Icons.bookmark_border)
                                : Icon(Icons.bookmark)),
                            color: Colors.orange,
                            onPressed: _handleTap,
                          ),
                        ),
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
