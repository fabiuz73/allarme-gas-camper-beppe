import 'package:flutter/material.dart';

class SogliePage extends StatefulWidget {
  final int sogliaMq7;
  final int sogliaMq135;

  SogliePage({required this.sogliaMq7, required this.sogliaMq135});

  @override
  _SogliePageState createState() => _SogliePageState();
}

class _SogliePageState extends State<SogliePage> {
  late TextEditingController mq7Controller;
  late TextEditingController mq135Controller;

  @override
  void initState() {
    super.initState();
    mq7Controller = TextEditingController(text: widget.sogliaMq7.toString());
    mq135Controller = TextEditingController(text: widget.sogliaMq135.toString());
  }

  @override
  void dispose() {
    mq7Controller.dispose();
    mq135Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Imposta Soglie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Soglia MQ-7 (CO):'),
            TextField(
              keyboardType: TextInputType.number,
              controller: mq7Controller,
            ),
            SizedBox(height: 16),
            Text('Soglia MQ-135 (Gas tossici):'),
            TextField(
              keyboardType: TextInputType.number,
              controller: mq135Controller,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'mq7': int.tryParse(mq7Controller.text) ?? widget.sogliaMq7,
                  'mq135': int.tryParse(mq135Controller.text) ?? widget.sogliaMq135,
                });
              },
              child: Text('Salva soglie'),
            )
          ],
        ),
      ),
    );
  }
}