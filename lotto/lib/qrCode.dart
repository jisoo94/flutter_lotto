import 'package:flutter/material.dart';
import 'package:lotto/qr_check_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCode extends StatefulWidget {
  const QrCode({Key? key}) : super(key: key);

  @override
  State<QrCode> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  String qrResult = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              child: const Text(
                'Connect it here.\nClick',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () => launch(qrResult),
            ),
          ),
          const SizedBox(height: 50),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 0,
                blurRadius: 5.0,
                offset: const Offset(0, 10), // changes position of shadow
              ),
            ], borderRadius: BorderRadius.circular(10), color: Colors.black),
            height: 100,
            width: 200,
            child: TextButton.icon(
                onPressed: _onPressedFAB,
                icon: const Icon(Icons.qr_code_2,
                    size: 50.0, color: Colors.white),
                label: const Text(
                  'QR_Code',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  void _onPressedFAB() async {
    dynamic result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const QRCheckScreen(eventKeyword: '');
    }));

    if (result != null) {
      setState(() {
        qrResult = result.toString();
      });
    }
  }
}
