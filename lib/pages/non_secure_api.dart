import 'package:flutter/material.dart';
import '../dto/symbol.dart';
import '../services/bitkub_service.dart';

class NonSecureApiPage extends StatefulWidget {
     @override
     _NonSecureApiState createState() => _NonSecureApiState();
}

class _NonSecureApiState extends State<NonSecureApiPage> {


     Future fetchCoins() async {
          print('fetchCoins');
          return await BitkubService().getSymbols();
     }

     @override
     Widget build(BuildContext context) {
          return Scaffold(
               appBar: AppBar(
                    title: Text("Non Secure API"),
               ),
               body: FutureBuilder(
                    future: fetchCoins(),
                    builder: (BuildContext  contex, AsyncSnapshot tickerSnap) {
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
                                        return new Text('${tickerSnap.error}', style: TextStyle(color: Colors.red),);
                                   } else {
                                        return ListView.builder(
                                             itemCount: (tickerSnap.data == null) ? 0 : tickerSnap.data.length,
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