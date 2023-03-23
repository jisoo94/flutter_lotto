import 'package:flutter/material.dart';
// import 'package:lotto/camera.dart';
import 'package:lotto/generate_page.dart';
import 'package:lotto/home_page.dart';
import 'package:lotto/qrCode.dart';
import 'package:lotto/statistics_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Jisoo Lotto",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.home), text: '홈'),
              Tab(icon: Icon(Icons.loop), text: '번호생성'),
              Tab(icon: Icon(Icons.filter_6), text: '통계'),
              Tab(icon: Icon(Icons.camera_alt), text: '당첨 확인'),
            ]),
          ),
          body: const TabBarView(children: [
            HomePage(),
            GeneratePage(),
            StatisticsPage(),
            QrCode(),
            // Camera(),
          ]),
        ));
  }
}
