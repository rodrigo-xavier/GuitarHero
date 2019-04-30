#define led0 13
#define led1 12
#define led2 11
#define led3 10

unsigned char lsb = '\0';
unsigned char msb = '\0';
uint16_t wd = 0;

void setup() {
  Serial.begin(9600);
  // put your setup code here, to run once:
  pinMode(led0, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
}

void loop() {
  if (Serial.available() >= 2) {
    msb = Serial.read();
    lsb = Serial.read();
    wd = ( (msb << 8) | lsb);

    digitalWrite(led0, bitRead(wd, 12));  // turn the LED on (HIGH is the voltage level)
    digitalWrite(led1, bitRead(wd, 13));  // turn the LED on (HIGH is the voltage level)
    digitalWrite(led2, bitRead(wd, 14));  // turn the LED on (HIGH is the voltage level)
    digitalWrite(led3, bitRead(wd, 15));  // turn the LED on (HIGH is the voltage level)
    Serial.print(bitRead(wd, 15));
    Serial.print(bitRead(wd, 14));
    Serial.print(bitRead(wd, 13));
    Serial.print(bitRead(wd, 12));
    Serial.print(bitRead(wd, 11));
    Serial.print(bitRead(wd, 10));
    Serial.print(bitRead(wd, 9));
    Serial.print(bitRead(wd, 8));
    Serial.print(bitRead(wd, 7));
    Serial.print(bitRead(wd, 6));
    Serial.print(bitRead(wd, 5));
    Serial.print(bitRead(wd, 4));
    Serial.print(bitRead(wd, 3));
    Serial.print(bitRead(wd, 2));
    Serial.print(bitRead(wd, 1));
    Serial.print(bitRead(wd, 0));
//    Serial.println();

    lsb = 0;
    msb = 0;
    wd = 0;
  }
}
