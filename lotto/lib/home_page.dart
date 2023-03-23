import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

Future<Post> fetchPost() async {
  final firstDate = DateTime(2002, 12, 07);
  final nowDate = DateTime.now();
  final round = ((nowDate.difference(firstDate).inDays / 7 + 1).toInt());
  final response = await http.get(
      'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=${round}');
  final response_under = await http.get(
      'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=${round - 1}');
  var decodeData = json.decode(response.body);
  if (decodeData['returnValue'] == 'success') {
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  } else {
    if (response_under.statusCode == 200) {
      return Post.fromJson(json.decode(response_under.body));
    } else {
      throw Exception('failed to load post');
    }
  }
}

class Post {
  final int? num1;
  final int? num2;
  final int? num3;
  final int? num4;
  final int? num5;
  final int? num6;
  final int? numBonus;

  Post(
      {this.num1,
      this.num2,
      this.num3,
      this.num4,
      this.num5,
      this.num6,
      this.numBonus});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      num1: json['drwtNo1'],
      num2: json['drwtNo2'],
      num3: json['drwtNo3'],
      num4: json['drwtNo4'],
      num5: json['drwtNo5'],
      num6: json['drwtNo6'],
      numBonus: json['bnusNo'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Post>? latest_number;
  Future<Post>? lasest_number_under;
  String output = "output";

  @override
  void initState() {
    super.initState();
    latest_number = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          width: 350,
          child: Card(
            color: const Color.fromARGB(255, 237, 247, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 10.0,
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "이번주 로또 번호\n",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<Post>(
                      future: latest_number,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/image/${snapshot.data!.num1}.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/image/${snapshot.data!.num2}.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/image/${snapshot.data!.num3}.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/image/${snapshot.data!.num4}.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/image/${snapshot.data!.num5}.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/image/${snapshot.data!.num6}.png',
                                width: 40,
                                height: 40,
                              ),
                              const Text(" + "),
                              Image.asset(
                                'assets/image/${snapshot.data!.numBonus}.png',
                                width: 40,
                                height: 40,
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      },
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
