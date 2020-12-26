import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;
import 'dto/config.dart';


class ApplicationConfig{
     Future<Config> loadAsset() async{
          String _json =   await rootBundle.loadString('assets/config.json');
          //print('assets/config json::==$_json');
          return Config.fromJson(convert.jsonDecode(_json));
     }

}