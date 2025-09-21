import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'gas_data.dart';

class BluetoothService {
  static Function(GasData)? onDataReceived;
  static BluetoothConnection? _connection;
  static StreamSubscription<Uint8List>? _dataSubscription;

  // Restituisce la lista dei dispositivi Bluetooth associati
  static Future<List<BluetoothDevice>> getBondedDevices() async {
    FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
    if (!(await bluetooth.isEnabled ?? false)) {
      await bluetooth.requestEnable();
    }
    return await bluetooth.getBondedDevices();
  }

  // Connette al dispositivo selezionato
  static Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await BluetoothConnection.toAddress(device.address);

      _dataSubscription = _connection!.input!.listen((Uint8List data) {
        String message = String.fromCharCodes(data);
        if (onDataReceived != null) {
          onDataReceived!(GasData.fromBluetooth(message));
        }
      });

      return true;
    } catch (e) {
      print('Errore connessione Bluetooth: $e');
      return false;
    }
  }

  static Future<void> disconnect() async {
    await _dataSubscription?.cancel();
    await _connection?.close();
    _connection = null;
  }
}