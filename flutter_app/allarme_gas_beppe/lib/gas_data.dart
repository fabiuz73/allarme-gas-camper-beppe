class GasData {
  final int mq7;
  final int mq135;

  GasData({required this.mq7, required this.mq135});

  factory GasData.fromBluetooth(String data) {
    // "MQ7:2100,MQ135:1800"
    int mq7 = 0;
    int mq135 = 0;
    final parts = data.split(',');
    for (var part in parts) {
      if (part.startsWith("MQ7:")) mq7 = int.tryParse(part.substring(4)) ?? 0;
      if (part.startsWith("MQ135:")) mq135 = int.tryParse(part.substring(6)) ?? 0;
    }
    return GasData(mq7: mq7, mq135: mq135);
  }
}