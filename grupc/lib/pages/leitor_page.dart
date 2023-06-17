import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LeitorPage extends StatefulWidget {
  const LeitorPage({super.key});

  @override
  State<LeitorPage> createState() => _LeitorPageState();
}

class _LeitorPageState extends State<LeitorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitura de código'),
        centerTitle: true,
      ),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          Navigator.pop(context, barcode.rawValue);
        },
        fit: BoxFit.cover,
      ),
    );
  }
}