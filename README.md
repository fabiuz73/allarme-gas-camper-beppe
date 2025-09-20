# allarme-gas-camper-beppe
Progetto smath per rilevare Gas
# Allarme Gas Camper Display

## Descrizione del Progetto

Questo progetto utilizza una ESP32 per monitorare la qualità dell'aria in un camper, visualizzando i dati su un display ST7789 da 1,14", segnalando gli allarmi via LED RGB, buzzer e inviando informazioni via Bluetooth ad un'app Flutter.

---

## Componenti Utilizzati

- **Microcontrollore**: ESP32
- **Display**: ST7789 1,14"
- **Sensore Monossido di Carbonio**: MQ-7
- **Sensore Gas Tossici**: MQ-135
- **LED RGB**: Modulo KY-016
- **Buzzer**: Classico buzzer attivo/passivo
- **Cavi jumper**

---

## Schema di Collegamento

| Componente      | Pin ESP32      | Note              |
|-----------------|---------------|-------------------|
| Display ST7789  | CS: 15        |                   |
|                 | DC: 2         |                   |
|                 | RST: 4        |                   |
|                 | BL(backlight): 32 |                |
| MQ-7            | AOUT: 34      | Ingresso Analogico|
| MQ-135          | AOUT: 35      | Ingresso Analogico|
| LED RGB         | R: 12         | Uscita PWM        |
|                 | G: 13         | Uscita PWM        |
|                 | B: 14         | Uscita PWM        |
| Buzzer          | 27            | Uscita Digitale   |

---

## Istruzioni di Collegamento

1. Collega il display ST7789 ai pin dell'ESP32 come da tabella.
2. Collega il sensore MQ-7 al pin ADC 34 dell'ESP32.
3. Collega il sensore MQ-135 al pin ADC 35 dell'ESP32.
4. Collega i pin del modulo LED RGB KY-016 ai pin 12 (rosso), 13 (verde) e 14 (blu) dell'ESP32.
5. Collega il buzzer al pin 27 dell'ESP32.
6. Assicurati che la retroilluminazione del display (BL) sia collegata al pin 32 e impostata su HIGH.
7. Alimenta correttamente la scheda ESP32 e i sensori secondo le specifiche.

---

## Funzionamento

- I sensori MQ-7 e MQ-135 monitorano la presenza di gas tossici.
- I valori letti vengono visualizzati sul display.
- Se uno dei valori supera la soglia impostata, il LED RGB si accende rosso e il buzzer suona.
- In stato di attenzione (valori vicini alla soglia), il LED si accende giallo.
- In stato normale, il LED si accende verde.
- I dati vengono trasmessi via Bluetooth verso l'app Flutter.

---

## Sketch di esempio

Vedi nella cartella `src` lo sketch completo per ESP32.

---

## Note

- Modifica le soglie di allarme nel codice secondo le tue esigenze.
- Assicurati di aver installato le librerie Adafruit ST7789, Adafruit GFX e BluetoothSerial.
- Per la parte Flutter, puoi usare il plugin `flutter_bluetooth_serial` per ricevere i dati.

---

## Credits

Sviluppato da [fabiuz73](https://github.com/fabiuz73)
