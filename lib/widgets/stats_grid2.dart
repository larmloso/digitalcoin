import 'package:flutter/material.dart';

import '../dto/symbol.dart';
import '../services/bitkub_service.dart';

class StatsGrid2 extends StatefulWidget {
  @override
  _StatsGrid2State createState() => _StatsGrid2State();
}

class _StatsGrid2State extends State<StatsGrid2> {
  Future fetchCoins() async {
    print('fetchCoins');
    return await BitkubService().getSymbols();
  }

  @override
  Widget build(BuildContext context) {
    String str = 'hello';

    fetchCoins().then((value) => value.forEach((e) {}));

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
