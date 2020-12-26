
import 'dart:convert' as convert;
import 'dart:convert' show utf8;
//import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../dto/symbol.dart';
//import '../dto/balance.dart';
import '../dto/config.dart';

import '../app_config.dart';
//import '../util/coin_security.dart';


class BitkubService{

     Map<String, String> headers = {
          "content-type": "application/json",
          "Accept": "application/json",
     };

    //  Future<String> getServerTime() async {
    //       Config _config = await ApplicationConfig().loadAsset();
    //       final response = await http.get(_config.bitkubEndpoint + "/api/servertime", headers: headers);
    //       if (response.statusCode == 200) {
    //            return response.body;
    //       } else {
    //            throw Exception('Failed to load Server Time');
    //       }
    //  }

    //  Future<List<Balance>> getCoinsBalance() async {
    //       Config _config = await ApplicationConfig().loadAsset();
    //       String timestamp = await this.getServerTime();
    //       print('timestamp ::==$timestamp');
    //       var payload = {'ts': timestamp};
    //       print('payload ::==${convert.jsonEncode(payload)}');
    //       headers['X-BTK-APIKEY'] = _config.bitkubApikey;
    //       String hamcSing = new CoinSecurity().coinHmacSign(payload, _config.bitkubApiSecret);
    //       //print('payloadHmac ::==${convert.jsonEncode(hamcSing)}');
    //       payload['sig'] = hamcSing;
    //       String payLoadJson = convert.jsonEncode(payload);
    //       print('payLoadJson ::==$payLoadJson');
    //       final response =
    //       await http.post(_config.bitkubEndpoint + '/api/market/balances', headers: headers, body: payLoadJson);
    //       debugPrint('response headers ::==${convert.jsonEncode(response.headers)}',wrapWidth: 1024);
    //       debugPrint('response.statusCode :: ${response.statusCode}');
    //       if (response.statusCode == 200) {
    //            List<Balance> balances = new List();
    //            try {
    //                 String _body = convert.utf8.decode(response.bodyBytes);
    //                 print('response  _body::==$_body');
    //                 Map<String, dynamic> mapBodyRes = convert.jsonDecode(_body);
    //                 if(mapBodyRes['error'] == 1){
    //                      throw new Exception('error :: ${mapBodyRes['error']}');
    //                 }else{
    //                      Map<String,dynamic> mapResult = mapBodyRes['result'];
    //                      mapResult.forEach((balanceName, balanceDetail) {
    //                           balances.add(Balance.fromJson(balanceName, balanceDetail));
    //                      });
    //                      return balances;
    //                 }
    //            } catch (e) {
    //                 print('e::==$e');
    //                 throw e;
    //            }
    //       } else {
    //            throw Exception('Failed to load fetchCoinBalances');
    //       }
    //  }

     Future<List<Ticker>> getSymbols() async {
          Config _config = await ApplicationConfig().loadAsset();
          //print('_config  ::==${_config.bitkubEndpoint}');
          final response = await http.get(_config.bitkubEndpoint + "/api/market/ticker");
          //print('headers ::==${convert.jsonEncode(response.headers)}');
          if (response.statusCode == 200) {
               List<Ticker> tickers = new List();
               String _body = utf8.decode(response.bodyBytes);
               //print('_body ::==   $_body');
               try {
                    Map<String, dynamic> mapTickets = convert.jsonDecode(_body);
                    mapTickets.forEach((coinName, coinDetail) {
                        //print('coinName :: $coinName');
                        //print('coinDetail :: $coinDetail');
                        tickers.add(Ticker.fromJson(coinName, coinDetail));
                    });
                    //tickers.forEach((element) { print(element.baseVolume);});
                    return tickers;
               } catch (e) {
                    print('e::==$e');
                    throw e;
               }
          } else {
               throw Exception('Failed to load Coins');
          }
     }
}