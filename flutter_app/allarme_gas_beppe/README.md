# Allarme Gas Beppe

App Flutter per monitoraggio gas camper con ESP32 e sensori MQ-7/MQ-135.

## Funzionalità

- Connessione Bluetooth reale all'ESP32 (scelta dispositivo)
- Visualizzazione valori MQ-7 (CO) e MQ-135 (gas tossici)
- Allarmi visivi quando le soglie sono superate
- Impostazione soglie di allarme

## Struttura cartelle

- `lib/main.dart`: entry-point dell'app
- `lib/gas_home_page.dart`: home page con valori e allarmi
- `lib/bluetooth_service.dart`: gestione connessione Bluetooth
- `lib/gas_data.dart`: modello dati dei sensori
- `lib/soglie_page.dart`: schermata impostazione soglie
- `lib/select_device_page.dart`: selezione manuale dispositivo Bluetooth

## Avvio

1. Installa Flutter
2. Copia questi file nelle relative posizioni
3. Esegui `flutter pub get`
4. Avvia la app su Android
