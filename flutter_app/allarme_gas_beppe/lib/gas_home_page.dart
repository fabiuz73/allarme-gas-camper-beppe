import 'package:flutter/material.dart';
import 'gas_data.dart';
import 'bluetooth_service.dart';
import 'soglie_page.dart';
import 'select_device_page.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class GasHomePage extends StatefulWidget {
  @override
  _GasHomePageState createState() => _GasHomePageState();
}

class _GasHomePageState extends State<GasHomePage> {
  bool isConnected = false;
  GasData gasData = GasData(mq7: 0, mq135: 0);
  String status = "Non connesso";
  int sogliaMq7 = 2000;
  int sogliaMq135 = 1500;
  BluetoothDevice? selectedDevice;

  @override
  void initState() {
    super.initState();
    BluetoothService.onDataReceived = (GasData data) {
      setState(() {
        gasData = data;
      });
    };
  }

  Future<void> selectDeviceAndConnect() async {
    final device = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SelectDevicePage()),
    );
    if (device != null && device is BluetoothDevice) {
      setState(() {
        selectedDevice = device;
        status = "Connessione in corso...";
      });
      bool result = await BluetoothService.connectToDevice(device);
      setState(() {
        isConnected = result;
        status = result ? "Connesso a ${device.name}" : "Non connesso";
      });
    }
  }

  void aggiornaSoglie(int nuovaMq7, int nuovaMq135) {
    setState(() {
      sogliaMq7 = nuovaMq7;
      sogliaMq135 = nuovaMq135;
    });
  }

  @override
  void dispose() {
    BluetoothService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoraggio Gas Beppe'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SogliePage(
                    sogliaMq7: sogliaMq7,
                    sogliaMq135: sogliaMq135,
                  ),
                ),
              );
              if (result != null) {
                aggiornaSoglie(result['mq7'], result['mq135']);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Stato: $status', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isConnected ? null : selectDeviceAndConnect,
              child: Text(isConnected ? "Connesso" : "Seleziona e Connetti ESP32"),
            ),
            SizedBox(height: 40),
            Text('MQ-7 (CO): ${gasData.mq7}', style: TextStyle(fontSize: 22)),
            if (gasData.mq7 > sogliaMq7)
              Text('ALLARME CO!', style: TextStyle(fontSize: 28, color: Colors.red)),
            SizedBox(height: 10),
            Text('MQ-135 (Gas tossici): ${gasData.mq135}', style: TextStyle(fontSize: 22)),
            if (gasData.mq135 > sogliaMq135)
              Text('ALLARME GAS TOSSICO!', style: TextStyle(fontSize: 28, color: Colors.red)),
            SizedBox(height: 30),
            Text('Soglia MQ-7: $sogliaMq7', style: TextStyle(fontSize: 14)),
            Text('Soglia MQ-135: $sogliaMq135', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}