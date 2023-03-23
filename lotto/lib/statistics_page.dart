import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

Future<List<int>> fetchGet() async {
  await Future.delayed(const Duration(seconds: 1));
  http.Response response = await http
      .get('https://www.dhlottery.co.kr/gameResult.do?method=statByNumber');
  dom.Document document = parser.parse(response.body);
  final mainclass = document.getElementsByClassName('tbl_data');
  List<int> myList = [];
  for (int i = 2; i < 135; i += 3) {
    myList.add(int.parse(mainclass[1].getElementsByTagName('td')[i].innerHtml));
  }
  return myList;
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Future<List<int>> powertest;

  @override
  void initState() {
    super.initState();
    powertest = fetchGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('번호별 통계번호', style: TextStyle(fontSize: 20)),
          FutureBuilder<List<int>>(
            future: powertest,
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 400.0,
                      width: 350.0,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/${index + 1}.PNG'),
                                ),
                                title: FittedBox(
                                  child: SizedBox(
                                    width: 200.0,
                                    height: 0.1,
                                    child: CustomPaint(
                                        size: const Size(100.0, 0.1),
                                        painter: MyPainter(
                                          lottoCountC: double.parse(
                                              snapshot.data![index].toString()),
                                        )),
                                  ),
                                ),
                                trailing:
                                    Text(snapshot.data![index].toString()),
                              ))),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double? lottoCount;

  MyPainter({double? lottoCountC}) {
    this.lottoCount = lottoCountC!;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    Offset p1 = Offset(0.0, 0.0);
    Offset p2 = Offset(lottoCount!, size.height);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
