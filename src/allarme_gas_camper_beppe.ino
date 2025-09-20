#include <BluetoothSerial.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ST7789.h>
#include <SPI.h>

// Pin Display ST7789
#define TFT_CS    15
#define TFT_DC    2
#define TFT_RST   4
#define TFT_BL    32

// Pin sensori gas
#define PIN_MQ7    34
#define PIN_MQ135  35

// Pin LED RGB KY-016
#define PIN_LED_R  12
#define PIN_LED_G  13
#define PIN_LED_B  14

// Pin buzzer
#define PIN_BUZZER 27

// Soglie allarme
const int sogliaMq7    = 2000;  // CO
const int sogliaMq135  = 1500;  // Gas tossici

Adafruit_ST7789 tft = Adafruit_ST7789(TFT_CS, TFT_DC, TFT_RST);
BluetoothSerial SerialBT;

void setup() {
  Serial.begin(115200);
  SerialBT.begin("AllarmeGasBeppe");

  pinMode(PIN_LED_R, OUTPUT);
  pinMode(PIN_LED_G, OUTPUT);
  pinMode(PIN_LED_B, OUTPUT);
  pinMode(PIN_BUZZER, OUTPUT);

  pinMode(TFT_BL, OUTPUT);
  digitalWrite(TFT_BL, HIGH); // Accendi retroilluminazione display

  tft.init(135, 240); // 1,14" tipico: 240x135 px
  tft.setRotation(1);
  tft.fillScreen(ST77XX_BLACK);
  tft.setTextSize(2);
  tft.setTextColor(ST77XX_WHITE);
  tft.setCursor(10, 10);
  tft.println("Allarme Gas");
}

void loop() {
  int mq7 = analogRead(PIN_MQ7);
  int mq135 = analogRead(PIN_MQ135);

  // Invio dati via Bluetooth
  String data = "MQ7:" + String(mq7) + ",MQ135:" + String(mq135) + "\n";
  SerialBT.print(data);

  // Stato e allarme
  bool allarmeCO = mq7 > sogliaMq7;
  bool allarmeTossici = mq135 > sogliaMq135;
  bool allarme = allarmeCO || allarmeTossici;

  // LED RGB
  if (allarme) {
    // Rosso
    digitalWrite(PIN_LED_R, HIGH);
    digitalWrite(PIN_LED_G, LOW);
    digitalWrite(PIN_LED_B, LOW);
    digitalWrite(PIN_BUZZER, HIGH);
  } else if (mq7 > sogliaMq7 * 0.8 || mq135 > sogliaMq135 * 0.8) {
    // Giallo
    digitalWrite(PIN_LED_R, HIGH);
    digitalWrite(PIN_LED_G, HIGH);
    digitalWrite(PIN_LED_B, LOW);
    digitalWrite(PIN_BUZZER, LOW);
  } else {
    // Verde
    digitalWrite(PIN_LED_R, LOW);
    digitalWrite(PIN_LED_G, HIGH);
    digitalWrite(PIN_LED_B, LOW);
    digitalWrite(PIN_BUZZER, LOW);
  }

  // DISPLAY
  tft.fillRect(0, 40, 240, 60, ST77XX_BLACK); // cancella zona dati
  tft.setCursor(10, 45);
  tft.printf("CO: %d", mq7);
  tft.setCursor(10, 70);
  tft.printf("Tossici: %d", mq135);

  tft.fillRect(0, 110, 240, 30, ST77XX_BLACK); // cancella zona stato
  tft.setCursor(10, 115);

  if (allarme) {
    tft.setTextColor(ST77XX_RED);
    tft.println("ALLARME!");
    tft.setTextColor(ST77XX_WHITE);
  } else if (mq7 > sogliaMq7 * 0.8 || mq135 > sogliaMq135 * 0.8) {
    tft.setTextColor(ST77XX_YELLOW);
    tft.println("ATTENZIONE");
    tft.setTextColor(ST77XX_WHITE);
  } else {
    tft.setTextColor(ST77XX_GREEN);
    tft.println("OK");
    tft.setTextColor(ST77XX_WHITE);
  }

  delay(1000);
}