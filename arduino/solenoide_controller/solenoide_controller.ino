unsigned char incomingByte = '\0';
//unsigned int incomingTime = 0;
int L1 = 3;
int i = 0;

void setup() {
  pinMode(L1, OUTPUT);  
  Serial.begin(115200);
}

void loop() {
  
  // Esse if evita bugs
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
  }

  // Aperta L1 se '01100100'(=char(100)) for enviado ao arduino, 
  // soltando em seguida, com o menor tempo possível
  if(incomingByte == char(100)){
    // delay(600);
    digitalWrite(L1, HIGH);
    delay(50);

    // Solta o botão
    incomingByte = '\0';
    digitalWrite(L1, LOW);
  }

  // Apenas aperta o botão L1, sem soltar, se '01100101'(=char(101)) 
  // for enviado ao arduino.
  if(incomingByte == char(101)){
    // Aperta o botão
    digitalWrite(L1, HIGH);
  }

  // Apenas solta o botão L1 se '01100110'(=char(102))
  // for enviado ao arduino.
  if(incomingByte == char(102)){
    // Solta o botão
    incomingByte = '\0';
    digitalWrite(L1, LOW);
  }
  
  // Segura o botão por determinado tempo
  // Codificação para enviar o tempo
  // p + tempo desejado + q
  if(incomingByte == char(112)){ // p=char(112)
    String str = Serial.readStringUntil(char(113)); // q=char(113)
    int time1 = str.toInt();
    digitalWrite(L1, HIGH);
    delay(time1);
    digitalWrite(L1, LOW);
  }

  // Dorme por determinado tempo
  // Codificação para enviar o tempo
  // r + tempo desejado + s
  if(incomingByte == char(114)){ // r=char(114)
    String str = Serial.readStringUntil(char(115)); // s=char(115)
    int time1 = str.toInt();
    delay(time1);
  }

}
