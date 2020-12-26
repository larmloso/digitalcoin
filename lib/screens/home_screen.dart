import 'package:flutter/material.dart';
import 'package:digitalcoin/config/palette.dart';
import 'package:digitalcoin/config/styles.dart';
import 'package:digitalcoin/widgets/widgets.dart';
import 'package:digitalcoin/data/data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(screenHeight),
          _buildPreventionTips(screenHeight),
          // _buildYourOwnTest(screenHeight),
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
        padding: const EdgeInsets.all(10.0),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Palette.primaryColor, Color(0xFFAD9FE4)],
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/own_test.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cryptocurrency!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Digital assets designed as\na medium of exchange.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        //color: Colors.orange,
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
              children: prevention
                  .map(
                    (e) => Column(
                      children: [
                        Image.asset(
                          e.keys.first,
                          height: screenHeight * 0.12,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          e.values.first,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
