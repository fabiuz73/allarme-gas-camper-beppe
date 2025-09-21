import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_service.dart';

class SelectDevicePage extends StatefulWidget {
  @override
  _SelectDevicePageState createState() => _SelectDevicePageState();
}

class _SelectDevicePageState extends State<SelectDevicePage> {
  List<BluetoothDevice> devices = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  Future<void> loadDevices() async {
    devices = await BluetoothService.getBondedDevices();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Seleziona dispositivo Bluetooth')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(devices[i].name ?? devices[i].address),
                  subtitle: Text(devices[i].address),
                  onTap: () {
                    Navigator.pop(context, devices[i]);
                  },
                );
              },
            ),
    );
  }
}