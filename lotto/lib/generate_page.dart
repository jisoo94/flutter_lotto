import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key}) : super(key: key);

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  static List<List<int>> randworld = <List<int>>[
    <int>[0, 0, 0, 0, 0, 0],
    <int>[0, 0, 0, 0, 0, 0],
    <int>[0, 0, 0, 0, 0, 0],
    <int>[0, 0, 0, 0, 0, 0],
    <int>[0, 0, 0, 0, 0, 0],
  ];

  List<bool> isActivated = [
    true,
    true,
    true,
    true,
    true,
  ];
  int activatedCount = 5;

  @override
  void initState() {
    super.initState();
    lottoNumberGenerate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (activatedCount <= 1) {
                        activatedCount = 1;
                      } else {
                        activatedCount--;
                      }
                      for (int i = 0; i < 5; i++) {
                        if (i < activatedCount) {
                          isActivated[i] = true;
                        } else {
                          isActivated[i] = false;
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#000000'),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                    ),
                    width: 40,
                    height: 40,
                    child: Transform.rotate(
                      angle: 180 * pi / 180,
                      child: const Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5.0)),
                GestureDetector(
                  onTap: lottoNumberGenerate,
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#000000'),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    width: 130,
                    height: 40,
                    child: Text(
                      '$activatedCount줄 생성',
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5.0)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (activatedCount >= 5) {
                        activatedCount = 5;
                      } else {
                        activatedCount++;
                      }
                      for (int i = 0; i < 5; i++) {
                        if (i < activatedCount) {
                          isActivated[i] = true;
                        } else {
                          isActivated[i] = false;
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor('#000000'),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        )),
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Container(
              width: screenWidth,
              height: 65.0,
              color: HexColor('#000000'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: generateLottoImage(0, isActivated[0], screenWidth, 65.0),
              ),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Container(
              width: screenWidth,
              height: 65.0,
              color: HexColor('#000000'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: generateLottoImage(1, isActivated[1], screenWidth, 65.0),
              ),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Container(
              width: screenWidth,
              height: 65.0,
              color: HexColor('#000000'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: generateLottoImage(2, isActivated[2], screenWidth, 65.0),
              ),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Container(
              width: screenWidth,
              height: 65.0,
              color: HexColor('#000000'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: generateLottoImage(3, isActivated[3], screenWidth, 65.0),
              ),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Container(
              width: screenWidth,
              height: 65.0,
              color: HexColor('#000000'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: generateLottoImage(4, isActivated[4], screenWidth, 65.0),
              ),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: lottoNumberGenerate,
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor('#000000'),
                        borderRadius: BorderRadius.circular(5)),
                    alignment: const Alignment(0.0, 0.0),
                    width: 100,
                    height: 40,
                    child: const Text(
                      '번호 생성',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(4.0)),
                Container(
                  decoration: BoxDecoration(
                    color: HexColor('#000000'),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: const Alignment(0.0, 0.0),
                  width: 100,
                  height: 40,
                  child: const Text(
                    "번호 저장",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  void lottoNumberGenerate() {
    setState(() {
      for (int k = 0; k < 5; k++) {
        List<int> lottonum = [];
        for (int i = 1; i <= 45; i++) {
          lottonum.add(i);
        }
        for (int i = 0; i < 6; i++) {
          int randnum = Random().nextInt(lottonum.length);
          randworld[k][i] = lottonum.elementAt(randnum);
          lottonum.removeAt(randnum);
        }
        randworld[k].sort();
      }
    });
  }

  Widget generateLottoImage(int row, bool activated, double w, double h) {
    if (activated) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                color: HexColor('#FFFFFF'),
                'assets/image/${randworld[row][0]}.png',
                width: 38,
                height: 38),
            const Padding(padding: EdgeInsets.all(5.0)),
            Image.asset(
                color: HexColor('#FFFFFF'),
                'assets/image/${randworld[row][1]}.png',
                width: 38,
                height: 38),
            const Padding(padding: EdgeInsets.all(5.0)),
            Image.asset(
                color: HexColor('#FFFFFF'),
                'assets/image/${randworld[row][2]}.png',
                width: 38,
                height: 38),
            const Padding(padding: EdgeInsets.all(5.0)),
            Image.asset(
                color: HexColor('#FFFFFF'),
                'assets/image/${randworld[row][3]}.png',
                width: 38,
                height: 38),
            const Padding(padding: EdgeInsets.all(5.0)),
            Image.asset(
                color: HexColor('#FFFFFF'),
                'assets/image/${randworld[row][4]}.png',
                width: 38,
                height: 38),
            const Padding(padding: EdgeInsets.all(5.0)),
            Image.asset(
                color: HexColor('#FFFFFF'),
                'assets/image/${randworld[row][5]}.png',
                width: 38,
                height: 38),
          ],
        ),
      );
    } else {
      return Container(
        width: w,
        height: h,
        color: HexColor('#FFFFFF'),
      );
    }
  }
}
